package com.nfdw.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "t_authentication")
@Data
public class Authentication {
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;
    @Column(name = "right_name")
    private String rightName;
    @Column(name = "right_code")
    private String rightCode;
    @Column(name = "user_ids")
    private String userIds;
    @Column(name = "user_names")
    private String userNames;
}
