package com.nfdw.util;

import lombok.Getter;

@Getter
public enum Path {
	DIARY_PATH(0,"diary","日记"),SHEDULE_PATH(1,"schedule","日程"),MAIL_PATH(2,"mail","邮件"),
    INFO_PATH(3,"info","信息发布");
    
    private final String path;
    
    private final int code;
    
    private final String type;
    
    private Path(int code, String path, String type)
    {
        this.path = path;
        this.code=code;
        this.type=type;
    }

}
