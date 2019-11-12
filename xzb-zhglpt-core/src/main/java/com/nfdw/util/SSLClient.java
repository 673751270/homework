package com.nfdw.util;

import org.apache.http.client.CookieStore;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;

import javax.net.ssl.*;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;

public class SSLClient {


    static CloseableHttpClient createSSLClientDefault(CookieStore cookieStore) {

        try {
            //SSLContext sslContext = new SSLContextBuilder().loadTrustMaterial(null, new TrustStrategy() {
            // 在JSSE中，证书信任管理器类就是实现了接口X509TrustManager的类。我们可以自己实现该接口，让它信任我们指定的证书。
            // 创建SSLContext对象，并使用我们指定的信任管理器初始化
            //信任所有
            X509TrustManager x509mgr = new X509TrustManager() {

                //　　该方法检查客户端的证书，若不信任该证书则抛出异常
                @Override
                public void checkClientTrusted(X509Certificate[] xcs, String string) {
                }

                // 　　该方法检查服务端的证书，若不信任该证书则抛出异常
                @Override
                public void checkServerTrusted(X509Certificate[] xcs, String string) {
                }

                // 　返回受信任的X509证书数组。
                @Override
                public X509Certificate[] getAcceptedIssuers() {
                    return null;
                }
            };
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, new TrustManager[]{x509mgr}, null);
            ////创建HttpsURLConnection对象，并设置其SSLSocketFactory对象
            SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext, SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);

            //  HttpsURLConnection对象就可以正常连接HTTPS了，无论其证书是否经权威机构的验证，只要实现了接口X509TrustManager的类MyX509TrustManager信任该证书。
            return HttpClients.custom().setSSLSocketFactory(sslsf).setDefaultCookieStore(cookieStore).build();


        } catch (KeyManagementException e) {

            e.printStackTrace();

        } catch (NoSuchAlgorithmException e) {

            e.printStackTrace();

        } catch (Exception e) {

            e.printStackTrace();
        }

        // 创建默认的httpClient实例.
        return HttpClients.createDefault();

    }
}
