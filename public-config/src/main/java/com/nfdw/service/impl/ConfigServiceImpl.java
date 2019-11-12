package com.nfdw.service.impl;

import com.nfdw.entity.Config;
import com.nfdw.mapper.ConfigMapper;
import com.nfdw.service.ConfigService;
import com.nfdw.util.JsonUtil;
import com.nfdw.util.StringUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;
import net.sf.json.util.JSONUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.MapKey;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;

@Service
public class ConfigServiceImpl implements ConfigService {

    @Autowired
    ConfigMapper configMapper;

    @Override
    public Object get(Object object) {
        Config config = new Config();
        Class<?> clazz = object.getClass();
        config.setName(clazz.getSimpleName());
        config = configMapper.selectOne(config);
        if (null != config) {
            String parameter = config.getParameter();
            Object json = new JSONTokener(parameter).nextValue();
            if (json instanceof JSONArray) {
                Collection collection = JSONArray.toCollection(JSONArray.fromObject(parameter), clazz);
                for (Object o : collection) {
                    JSONObject jsonObject = JSONObject.fromObject(o);
                    Field[] fields = clazz.getDeclaredFields();
                    for (Field field : fields) {
                        String filedName = field.getName();
                        //获取get方法名
                        String getMethodName = "get" + StringUtils.firstLetterToUpperCase(filedName);
                        try {
                            Method getMethod = clazz.getMethod(getMethodName, new Class[]{});
                            //这个对象字段get方法的值
                            Object value = getMethod.invoke(object, new Object[]{});
                            if (value != null) {
                                if (jsonObject.get(filedName).equals(value)) {
                                    return o;
                                }
                            }
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        } catch (NoSuchMethodException e) {
                            e.printStackTrace();
                        } catch (InvocationTargetException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return null;
    }

    @Override
    public Object getAll(Class clazz) {
        Config config = new Config();
        config.setName(clazz.getSimpleName());
        config = configMapper.selectOne(config);
        if (null != config) {
            String parameter = config.getParameter();
            Object json = new JSONTokener(parameter).nextValue();
            if (json instanceof JSONArray) {
                return JSONArray.toCollection(JSONArray.fromObject(parameter), clazz);
            }
            if (json instanceof JSONObject) {
                return JSONObject.toBean(JSONObject.fromObject(parameter), clazz);
            }
        }
        return null;
    }

    @Override
    public Object getBykey(Object object) {
        Config config = new Config();
        Class<?> clazz = object.getClass();
        config.setName(clazz.getSimpleName());
        config = configMapper.selectOne(config);
        if (null != config) {
            String parameter = config.getParameter();
            Object json = new JSONTokener(parameter).nextValue();
            if (json instanceof JSONArray) {
                Collection collection = JSONArray.toCollection(JSONArray.fromObject(parameter), clazz);
                for (Object o : collection) {
                    JSONObject jsonObject = JSONObject.fromObject(o);
                    try {
                        Field[] fields = clazz.getDeclaredFields();
                        for (Field field : fields) {
                            if (field.isAnnotationPresent(MapKey.class)) {
                                if (jsonObject.get(field.getName()).equals(field.get(field))) {
                                    return o;
                                }
                            }
                        }

                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    }
                }

            }
        }
        return null;
    }

    @Override
    public JsonUtil add(String clazzName, Object object) {
        Config config = new Config();
        config.setName(clazzName);
        config = configMapper.selectOne(config);
        JsonUtil jsonUtil = new JsonUtil();
        if (null == config) {
            config = new Config();
            if (JSONUtils.isObject(object)) {
                config.setParameter(JSONObject.fromObject(object).toString());
            }
            if (JSONUtils.isArray(object)) {
                config.setParameter(JSONArray.fromObject(object).toString());
            }
            config.setName(clazzName);
            configMapper.insertSelective(config);
            jsonUtil.setMsg("添加成功");
        } else {
            jsonUtil.setFlag(false);
            jsonUtil.setMsg("已经拥有");
        }
        return jsonUtil;
    }

    @Override
    public JsonUtil update(String clazzName, Object object) {
        Config config = new Config();
        Class<?> clazz = object.getClass();
        config.setName(clazzName);
        config = configMapper.selectOne(config);
        JsonUtil jsonUtil = new JsonUtil();

        if (null != config) {
            String parameter = config.getParameter();
            Object json = new JSONTokener(parameter).nextValue();
            if (json instanceof JSONObject) {
                JSONObject jsonObject = JSONObject.fromObject(parameter);
                Field[] fields = clazz.getDeclaredFields();
                for (Field field : fields) {
                    field.setAccessible(true);
                    String filedName = field.getName();
                    //获取get方法名
                    String getMethodName = "get" + StringUtils.firstLetterToUpperCase(filedName);
                    try {
                        Method getMethod = clazz.getMethod(getMethodName, new Class[]{});
                        //这个对象字段get方法的值
                        Object value = getMethod.invoke(object, new Object[]{});
                        if (value != null) {
                            jsonObject.put(field.getName(), value);
                        }
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    } catch (NoSuchMethodException e) {
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        e.printStackTrace();
                    }
                }
                config.setParameter(jsonObject.toString());
            }
            if (json instanceof JSONArray) {
                Collection collection = JSONArray.toCollection(JSONArray.fromObject(parameter), clazz);
                Field[] fields = clazz.getDeclaredFields();
                Collection oldCollection = new ArrayList();
                for (Object o : collection) {
                    JSONObject jsonObject = JSONObject.fromObject(o);
                    try {
                        for (Field field : fields) {

                            String filedName = field.getName();
                            //获取get方法名
                            String getMethodName = "get" + StringUtils.firstLetterToUpperCase(filedName);
                            Method getMethod = clazz.getMethod(getMethodName, new Class[]{});
                            //这个对象字段get方法的值
                            Object value = getMethod.invoke(object, new Object[]{});
                            if (null != value && !field.isAnnotationPresent(MapKey.class)) {
                                jsonObject.put(filedName, value);
                            }
                        }
                        oldCollection.add(JSONObject.toBean(jsonObject, clazz));
                    } catch (NoSuchMethodException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        e.printStackTrace();
                    }
                }
                config.setParameter(JSONArray.fromObject(oldCollection).toString());
            }
            configMapper.updateByPrimaryKeySelective(config);
            jsonUtil.setMsg("修改成功");
        }
        return jsonUtil;
    }

    @Override
    public JsonUtil updateBykey(String clazzName, Object object) {
        Config config = new Config();
        Class<?> clazz = object.getClass();
        config.setName(clazzName);
        config = configMapper.selectOne(config);
        JsonUtil jsonUtil = new JsonUtil();

        if (null != config) {
            String parameter = config.getParameter();
            Object json = new JSONTokener(parameter).nextValue();
            if (json instanceof JSONArray) {
                Collection collection = JSONArray.toCollection(JSONArray.fromObject(parameter), clazz);
                Field[] fields = clazz.getDeclaredFields();
                Collection oldCollection = new ArrayList();
                for (Object o : collection) {
                    JSONObject jsonObject = JSONObject.fromObject(o);
                    try {
                        for (Field field : fields) {

                            if (field.isAnnotationPresent(MapKey.class)) {
                                String filedName = field.getName();
                                //获取get方法名
                                String getMethodName = "get" + StringUtils.firstLetterToUpperCase(filedName);
                                Method getMethod = clazz.getMethod(getMethodName, new Class[]{});
                                //这个对象字段get方法的值
                                Object value = getMethod.invoke(object, new Object[]{});
                                if(jsonObject.get(filedName).equals(value)){
                                    for (Field field1 : fields) {
                                        String filedName1 = field1.getName();
                                        //获取get方法名
                                        String getMethodName1 = "get" + StringUtils.firstLetterToUpperCase(filedName1);
                                        Method getMethod1 = clazz.getMethod(getMethodName1, new Class[]{});
                                        //这个对象字段get方法的值
                                        Object value1 = getMethod1.invoke(object, new Object[]{});
                                        if (value1 != null) {
                                            jsonObject.put(filedName1, value1);
                                        }
                                    }
                                }
                            }
                        }

                        oldCollection.add(JSONObject.toBean(jsonObject, clazz));
                    } catch (NoSuchMethodException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        e.printStackTrace();
                    }
                }
                config.setParameter(JSONArray.fromObject(oldCollection).toString());
            }
            configMapper.updateByPrimaryKeySelective(config);
            jsonUtil.setMsg("修改成功");
        }
        return jsonUtil;
    }

    @Override
    public JsonUtil delete(Object object) {
        return null;
    }
}
