package com.nfdw.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "tb_xzb_members_reg")
@Data
@ToString
@EqualsAndHashCode
public class Members {
    @Id
    @Column(name = "rownum")
    private String rownum;
    @Column(name = "userid")
    private String userid;
    @Column(name = "orgname")
    private String orgname;
    @Column(name = "orgduty")
    private String orgduty;
    @Column(name = "account")
    private String account;
    @Column(name = "ismember")
    private String ismember;
    @Column(name = "submittime")
    private String submittime;

}
