package com.cgutech.meeting.utils;

import java.lang.reflect.Type;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class JsonUtil {

	private static final Gson gson = new GsonBuilder().disableHtmlEscaping().serializeNulls().setDateFormat("yyyy-MM-dd HH:mm:ss")
			.create();

	public static String toJson(Object object) {
		return gson.toJson(object);
	}

	public static Gson getGson() {
		return gson;
	}
 	  
	  /** 
	     * json字符串转成对象 
	     * @param str   
	     * @param type 
	     * @return  
	     */  
	    public static <T> T fromJson(String str, Type type) {  
	       
	        return gson.fromJson(str, type);  
	    }  
	  
	    /** 
	     * json字符串转成对象 
	     * @param str   
	     * @param type  
	     * @return  
	     */  
	    public static <T> T fromJson(String str, Class<T> type) {       
	        return gson.fromJson(str, type);  
	    }  

}
