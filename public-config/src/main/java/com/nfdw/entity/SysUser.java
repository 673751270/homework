package com.nfdw.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.nfdw.validator.group.AddGroup;
import com.nfdw.validator.group.UpdateGroup;
import lombok.Data;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.util.Date;

@Table(name = "sys_user")
@Data
@ToString
public class SysUser {
    @Id
    @GeneratedValue(generator = "JDBC")
    private String id;

    @NotEmpty(message = "用户名不能为空", groups = {AddGroup.class, UpdateGroup.class})
    private String username;

    @NotEmpty(message = "密码不能为空", groups = {AddGroup.class, UpdateGroup.class})
    private String password;

    private Integer age;

    private String email;

    private String photo;

    @Column(name = "real_name")
    private String realName;

    @Column(name = "create_by")
    private String createBy;

    @Column(name = "update_by")
    private String updateBy;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @Column(name = "create_date")
    private Date createDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @Column(name = "update_date")
    private Date updateDate;

    /**
     * 0可用1封禁
     */
    @Column(name = "del_flag")
    private int delFlag;

    /**
     * 在线状态1进行中0下线
     */
    private int status;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @Column(name = "locking_date")
    private Date lockingDate;

    /**
     * 排序
     */
    private Integer sort;

    @Column(name = "department_id")
    private Integer departmentId;

    @Column(name = "position_id")
    private Integer positionId;

    @Transient
    private String departmentName;

    @Transient
    private String positionName;

    @Transient
    private String gzarea;

}