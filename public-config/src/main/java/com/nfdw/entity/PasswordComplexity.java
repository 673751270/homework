package com.nfdw.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.MapKey;
import javax.persistence.Table;

@Data
@Table(name = "t_password_complexity")
public class PasswordComplexity {

    @Id
    @MapKey
    private Integer id;

    private String name;

    private String java;

    private String js;

    private String msg;

    @Column(name = "is_use")
    private Integer isUse;
}
