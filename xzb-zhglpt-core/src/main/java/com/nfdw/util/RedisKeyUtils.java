package com.nfdw.util;

/**
 * 
 * @Description: redis键值工具类。key的封装规则统一为：前缀+模块+功能+自定义字符串（若字符串拼接次数较多，建议使用StringBuilder）
 * @author Ivan Lee
 * @time 2018-10-25
 */
public class RedisKeyUtils {
	
	/**
	 * 本项目redis所有key必须以次字符串作为前缀
	 */
	private static String KEY_PREFIX = "web_";
	
	/**
	 * 大屏模块接口
	 */
	private static String SCREEN_INTERFACE = "screen_interface_";
	
	
	
	public static String getScreenInterfaceDataKey(String startDate) {
		return KEY_PREFIX + SCREEN_INTERFACE + startDate;
	}
	
	public static String getOnlineInterfaceDataKey(String startDate) {
		return KEY_PREFIX + SCREEN_INTERFACE + startDate;
	}
	
}
