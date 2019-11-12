package com.nfdw.entity;

import lombok.Data;
import lombok.ToString;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "t_system_dictionary")
@Data
@ToString
public class Dictionary {

	@Id
	@GeneratedValue(generator = "JDBC")
	private Integer id;
	private String dgroup;
	private String code;
	private String dvalue;
	private String name;
	
	private Double sort;
	private String isused;

	@Column(name="updatetime")
	private Date updateTime;
}
