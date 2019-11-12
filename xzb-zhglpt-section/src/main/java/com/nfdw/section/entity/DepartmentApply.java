package com.nfdw.section.entity;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
/**
 *  sjq
 * @author admin
 *  2019/1
 */
@Table(name = "department_apply")
@Data  //是 lombok 的注解，自动生成Getter，Setter，toString，构造函数等
@ToString
@EqualsAndHashCode
@Entity // 注解这是个实体类
public class DepartmentApply {
	
	    @Id
	    @GeneratedValue(generator = "JDBC")
	    private String id;
	    //单号
	    private String orderno;
	    //名称
	    private String ordername;
	    //区域
	    private String region;
	    //申请人
	    private String applicant;
	    //当前环节
	    private String currentlink;
	    //当前处理人
	    private String currenthandler;
	    //状态
	    private String state;
	    
	    

}
