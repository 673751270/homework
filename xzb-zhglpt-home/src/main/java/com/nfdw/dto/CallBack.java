package com.nfdw.dto;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Data
@Component
public class CallBack {

    @Value("${nfdw.oa.verification.path}")
    private String OAPath;

    @Value("${nfdw.oa.port}")
    private String OAPort;

    @Value("${nfdw.wb.verification.path}")
    private String WBPath;

    @Value("${nfdw.wb.port}")
    private String WBPort;
}
