package com.nfdw.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.Date;

@Table(name = "t_process_list")
@Data
@ToString
@EqualsAndHashCode
public class ProcessResult {

    @Id
    private String id;

    @Column(name = "serial_number")
    private String serialNumber;//流水号

    private String urgency;

    @Column(name = "fwzh")
    private String fwzh;//发文字号

    @Column(name = "process_type")
    private String processType;//流程类型

    @Column(name = "process_title")
    private String processTitle;//流程标题

    @Column(name = "process_state")
    private String processState;//流程状态

    @Column(name = "now_step")
    private String nowStep;//当前步骤

    @Column(name = "cb_State")
    private String cbState;

    @Column(name = "assign_Name")
    private String assignName;

    @Column(name = "fqsj")//发起时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date fqsj;

    @Column(name = "process_Type_Id")
    private Integer processTypeId;

    @Transient
    private int type;
}
