package com.nfdw.entity;


import lombok.Data;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "t_black_user")
@Data
public class Blacklist {
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;
    private String username;
    private String realName;
    private String ip;
}
