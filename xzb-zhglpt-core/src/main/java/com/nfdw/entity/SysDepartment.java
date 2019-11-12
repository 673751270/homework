package com.nfdw.entity;


import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Table(name = "sys_department")
@Data
@ToString
@EqualsAndHashCode
public class SysDepartment {
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;
    @Column(name = "department_name")
    private String departmentName;
    @Column(name = "creater")
    private String creater;
    @Column(name = "create_time")
    private Date createTime;
    @Column(name = "gzarea")
    private String gzarea;

    @Transient
    private List<SysUser> users;

}
