package com.nfdw.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import com.alibaba.druid.support.spring.stat.DruidStatInterceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.aop.support.JdkRegexpMethodPointcut;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Scope;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.filter.DelegatingFilterProxy;
import tk.mybatis.spring.annotation.MapperScan;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 *
 */
@Configuration
@EnableTransactionManagement
@MapperScan(basePackages = {"com.nfdw.mapper", "com.nfdw.section.mapper"},sqlSessionFactoryRef = "druidSqlSessionFactory")
public class DruidConfig {

    @Value("${spring.datasource.druid.url}")
    private String url;
    @Value("${spring.datasource.druid.username}")
    private String username;
    @Value("${spring.datasource.druid.password}")
    private String password;
    @Value("${spring.datasource.druid.filters}")
    private String filters;
    @Value("${spring.datasource.druid.driver-class-name}")
    private String driverClassName;
    @Value("${spring.datasource.druid.initialSize}")
    private int initialSize;
    @Value("${spring.datasource.druid.minIdle}")
    private int minIdle;

    @Bean("druidDataSource")
    @Primary
    public DataSource druidDataSource() {
        DruidDataSource datasource = new DruidDataSource();

        datasource.setUrl(url);
        datasource.setUsername(username);
        datasource.setPassword(password);
        datasource.setDriverClassName(driverClassName);
        datasource.setInitialSize(initialSize);
        datasource.setMinIdle(minIdle);
        try {
            datasource.setFilters(filters);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return datasource;
    }

    @Bean(name = "druidSqlSessionFactory")
    @Primary
    public SqlSessionFactory druidSqlSessionFactory(@Qualifier("druidDataSource") DataSource druidDataSource)
            throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(druidDataSource);
        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver()
                .getResources("classpath*:mapper/*.xml"));
        return sessionFactory.getObject();
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplete(@Qualifier("druidSqlSessionFactory") SqlSessionFactory sqlSessionFactory) {

        return new SqlSessionTemplate(sqlSessionFactory);
    }


    @Bean
    public FilterRegistrationBean filterRegistrationBean() {
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        filterRegistrationBean.setFilter(new WebStatFilter());
        filterRegistrationBean.addUrlPatterns("/*");
        filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.bmp,*.png,*.css,*.ico,/druid/*,*.html");

        DelegatingFilterProxy proxy = new DelegatingFilterProxy();
        proxy.setTargetFilterLifecycle(true);
        proxy.setTargetBeanName("shiroFilter");

        filterRegistrationBean.setFilter(proxy);
        return filterRegistrationBean;
    }

    @Bean
    public ServletRegistrationBean druidServlet() {
        ServletRegistrationBean servletRegistrationBean = new ServletRegistrationBean();
        servletRegistrationBean.setServlet(new StatViewServlet());
        servletRegistrationBean.addUrlMappings("/druid/*");
        Map<String, String> initParameters = new HashMap<String, String>();
        initParameters.put("resetEnable", "false");
        initParameters.put("allow", "");
        servletRegistrationBean.setInitParameters(initParameters);
        return servletRegistrationBean;
    }

    @Bean
    public DruidStatInterceptor getDruidStatInterceptor() {
        return new DruidStatInterceptor();
    }

    @Bean
    @Scope("prototype")
    public JdkRegexpMethodPointcut getJdkRegexpMethodPointcut() {
        JdkRegexpMethodPointcut pointcut = new JdkRegexpMethodPointcut();
        String[] str = {"com.nfdw.service.*", "com.nfdw.mapper.*"};
        pointcut.setPatterns(str);
        return pointcut;
    }

}
