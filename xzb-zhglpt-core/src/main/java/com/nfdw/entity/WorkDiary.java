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
工作日记
 */
@Table(name = "t_workdiary")
@Data
@ToString
@EqualsAndHashCode
public class WorkDiary {
	@Id
	@GeneratedValue(generator = "JDBC")
	private Integer id;


	@Column(name = "user_id")
	private String userId;//用户ID

	@Column(name = "user_name")
	private String userName;//用户姓名

	private String title;//标题

	private String content;//日记内容

	@Column(name = "file_ids")
	private String fileIds;//附件ID

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	@Column(name = "create_time")
	private Date createTime;//创建时间

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
	@Column(name = "update_time")
	private Date updateTime;//更新时间
	@Transient
	private List<File> files;
	
}