package com.nfdw.service;

import com.nfdw.entity.PasswordComplexity;
import com.nfdw.util.JsonUtil;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

public interface ConfigService {

    Object get(Object object);

    Object getAll(Class clazz);

    Object getBykey(Object object);

    JsonUtil add(String clazzName, Object object);

    JsonUtil update(String clazzName, Object object);

    JsonUtil updateBykey(String clazzName,Object object);

    JsonUtil delete(Object object);
}
