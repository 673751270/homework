package com.nfdw.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.Date;

@Mapper
public interface PublicUserMapper {

    @Update({"update sys_user set locking_date=#{lockingDate} where username=#{username}"})
    int updateByUserName(@Param("lockingDate") Date lockingDate,@Param("username") String userName);

}
