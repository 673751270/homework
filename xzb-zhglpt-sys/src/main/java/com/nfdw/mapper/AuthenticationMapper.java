package com.nfdw.mapper;


import com.nfdw.base.BaseMapper;
import com.nfdw.entity.Authentication;
import org.apache.ibatis.annotations.Param;

public interface AuthenticationMapper extends BaseMapper<Authentication,String> {

    void addAuthentication(Authentication authentication);

    Authentication queryInfoById(String id);

    String getUserName(@Param("id") String id);

    void insertUsernames(@Param("usernames")String usernames,@Param("id")Integer id);
}
