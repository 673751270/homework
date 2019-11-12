package com.nfdw.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "t_config")
@Data
@ToString
@EqualsAndHashCode
public class Config {

    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;

    private String name;

    private String parameter;
}
