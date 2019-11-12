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

@Configuration
@EnableTransactionManagement
@MapperScan(basePackages = {"com.nfdw.oa.mapper"}, sqlSessionFactoryRef = "oaSqlSessionFactory")
public class OAConfig {

    @Value("${spring.datasource.oa.url}")
    private String url;
    @Value("${spring.datasource.oa.username}")
    private String username;
    @Value("${spring.datasource.oa.password}")
    private String password;
    @Value("${spring.datasource.oa.filters}")
    private String filters;
    @Value("${spring.datasource.oa.driver-class-name}")
    private String driverClassName;
    @Value("${spring.datasource.oa.initialSize}")
    private int initialSize;
    @Value("${spring.datasource.oa.minIdle}")
    private int minIdle;

    @Bean("oaDataSource")
    public DataSource oaDataSource() {
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

    @Bean(name = "oaSqlSessionFactory")
    public SqlSessionFactory oaSqlSessionFactory(@Qualifier("oaDataSource") DataSource oaDataSource)
            throws Exception {
        final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(oaDataSource);
        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver()
                .getResources("classpath*:oa/mapper/*.xml"));
        return sessionFactory.getObject();
    }

    @Bean
    public SqlSessionTemplate sqlSessionTemplete(@Qualifier("oaSqlSessionFactory") SqlSessionFactory sqlSessionFactory) {

        return new SqlSessionTemplate(sqlSessionFactory);
    }
}
