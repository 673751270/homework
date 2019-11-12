package com.nfdw.dto;

import com.nfdw.entity.InformationPublish;
import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Data
@ToString
public class HomeResult {
    /**
     * 通知
     */
    private List<InformationPublish> noticeInfos;

    private List<ProcessResult> processResults;

    private int processesCount;
}
