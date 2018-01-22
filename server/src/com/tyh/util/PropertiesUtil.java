package com.tyh.util;

import java.util.Locale;

import org.apache.log4j.chainsaw.Main;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class PropertiesUtil implements ApplicationContextAware 
{
	private static ApplicationContext applicationContext;
    
    /**
     * @param key prop文件中key值的namespace部分
     * @param value value部分
     * @return prop文件中value值
     */
    public static String getProperties(String key, String value)
    {
        if(applicationContext == null)
        {
            return value;
        } 
        else
        {
        	return applicationContext.getMessage(key + "." + value, null, value, Locale.getDefault()).trim();
        }
    }
    
    /**
     * @param key prop文件中key值
     * @return prop文件中value值
     */
    public static String getProperties(String key)
    {
        if(applicationContext == null)
        {
            return "";
        } 
        else
        {
        	return applicationContext.getMessage(key, null, Locale.getDefault()).trim();
        }
    }
    
    /**
     * @param key prop文件中key值
     * @param array 赋值参数
     * @return prop文件中value值
     */
    public static String getProperties(String key,Object[] array)
    {
        if(applicationContext == null)
        {
            return "";
        } 
        else
        {
        	return applicationContext.getMessage(key, array, Locale.getDefault()).trim();
        }
    }
	
//	@Override
	public void setApplicationContext(ApplicationContext applicationcontext)
			throws BeansException {
		// TODO Auto-generated method stub
		applicationContext = applicationcontext;
	}

	public ApplicationContext getApplicationContext() {
		return applicationContext;
	}
	
	// 方法一：通过java.util.ResourceBundle读取资源属性文件    
    public static String getPropertyByName(String path, String name) {    
        String result = "";    
    
        try {    
            // 方法一：通过java.util.ResourceBundle读取资源属性文件    
            result = java.util.ResourceBundle.getBundle(path).getString(name);    
            System.out.println("name:" + result);    
        } catch (Exception e) {    
            System.out.println("getPropertyByName2 error:" + name);    
        }    
        return result;    
    }  
    public static void main(String[] args) {
		System.out.println("getPropertyByName==="+PropertiesUtil.getPropertyByName("D:\\MyWork\\work\\Csii15\\server\\server\\src\\consmsg_zh_CN.properties", "lalalalal.aaaaa"));
	}
}
