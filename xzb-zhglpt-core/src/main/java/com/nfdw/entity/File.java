package com.nfdw.entity;

import lombok.Data;
import lombok.ToString;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "t_file")
@Data
@ToString
public class File {
	@Id
	@GeneratedValue(generator = "JDBC")
	private Integer id;
	
	@Column(name="file_name")
	private String fileName;

	@Column(name="file_path")
	private String filePath;

	@Column(name="file_size")
	private Long fileSize;
	
	@Column(name="file_type")
	private String fileType;
	
	public File() {
		super();
	}
	
	public File(String fileName, String filePath, Long fileSize, String fileType) {
		super();
		this.fileName = fileName;
		this.filePath = filePath;
		this.fileSize = fileSize;
		this.fileType = fileType;
	}
	
}
