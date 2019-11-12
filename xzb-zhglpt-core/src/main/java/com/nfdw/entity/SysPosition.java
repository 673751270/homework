package com.nfdw.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "sys_position")
@Data
@ToString
@EqualsAndHashCode
public class SysPosition {
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;
    @Column(name = "position_name")
    private String positionName;

    @Column(name = "creater")
    private String creater;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
    @Column(name = "creater_time")
    private Date createTime;
}
