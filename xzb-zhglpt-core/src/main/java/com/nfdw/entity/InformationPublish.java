package com.nfdw.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
信息发布
 */
@Table(name = "t_information_publish")
@Data
@ToString
@EqualsAndHashCode
public class InformationPublish {
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;

    @Column(name = "publish_name")
    private String publishName;//发布者姓名

    @Column(name = "publish_department")
    private String publishDepartment;//发布部门
    
    private String title;//标题
    
    @Column(name = "information_type")
    private String informationType;//信息类型
    
    @Column(name = "important_type")
    private String importantType;//重要程度

    @Column(name = "file_ids")
    private String fileIds;//附件编号

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "GMT+8")
    @Column(name = "publish_time")
    private Date publishTime;//发布时间

    @Transient
    private List<File> files;
   
}