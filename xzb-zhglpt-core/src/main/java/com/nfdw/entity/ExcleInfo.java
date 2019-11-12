package com.nfdw.entity;


import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Id;

@Data
public class ExcleInfo {
    @Id
    @Column(name = "rownum")
    private String rownum;
    @Column(name = "orgName")
    private String orgName;
    @Column(name = "principal")
    private String principal;
    @Column(name = "registerNum")
    private String registerNum;
    @Column(name = "addressArea")
    private String addressArea;
    @Column(name = "oph")
    private String oph;
    @Column(name = "fax")
    private String fax;
    @Column(name = "zip")
    private String zip;
    @Column(name = "departType")
    private String departType;
    @Column(name = "annals")
    private String annals;
    @Column(name = "clubYear")
    private String clubYear;
    @Column(name = "ismember")
    private String ismember;
    @Column(name = "state")
    private String state;




}
