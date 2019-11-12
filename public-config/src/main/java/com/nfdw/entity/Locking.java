package com.nfdw.entity;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Data;

@Data
@JsonSerialize
public class Locking {
    private Integer lockingNumber;

    private Integer lockingMinute;
}
