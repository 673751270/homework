package com.nfdw.util;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author zhipeng
 */
public class VerificationUtil {

    /**
     * 验证
     *
     * @param request
     * @param response
     * @param port     请求端口
     * @param path     请求地址
     * @param userName 验证用户名
     * @param password 验证密码（加密后的）
     * @return 返回请求结果
     * @throws IOException
     */
    public static String verification(HttpServletRequest request, HttpServletResponse response, String port, String path, String userName, String password) throws Exception {

        CookieStore cookieStore = new BasicCookieStore();

        HttpClient httpClient = SSLClient.createSSLClientDefault(cookieStore);

        StringBuffer requestURL = request.getRequestURL();

        requestURL.replace(requestURL.lastIndexOf(":") + 1, requestURL.length(), port + path);

        HttpPost post = new HttpPost(requestURL.toString());
        List<NameValuePair> params = new ArrayList<>();
        params.add(new BasicNameValuePair("username", userName));
        params.add(new BasicNameValuePair("password", password));
        // 编码格式转换
        UrlEncodedFormEntity entity = new UrlEncodedFormEntity(params);

        post.addHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        post.addHeader("Referer", String.valueOf(request.getRequestURL()));
        post.setEntity(entity);

        HttpResponse execute = httpClient.execute(post);
        HttpEntity executeEntity = execute.getEntity();

        List<Cookie> cookies = cookieStore.getCookies();

        for (Cookie cookie : cookies) {
            javax.servlet.http.Cookie repCookie = new javax.servlet.http.Cookie(cookie.getName(), cookie.getValue());
            repCookie.setPath(cookie.getPath());
            repCookie.setDomain(cookie.getDomain());
            repCookie.setComment(cookie.getComment());
            repCookie.setSecure(cookie.isSecure());
            repCookie.setVersion(cookie.getVersion());
            repCookie.setHttpOnly(true);
            response.addCookie(repCookie);
        }

        return EntityUtils.toString(executeEntity, "utf-8");
    }
}
