package com.tyh.util;

import org.springframework.context.ApplicationContext;

import com.alibaba.fastjson.JSON;

public class Constant {
	
	public static final int UPLOAD_IMAGE_WIDTH = 10800;		//设定上传时图片的宽度
	public static final int UPLOAD_IMAGE_HEIGHT = 19200;	//设定上传时图片的高度
	public static String UploadDir = "/Users/Tian/Documents/SoftWare/Tomcat7/AllPics/"; //上传图片的绝对地址-图片服务器地址
//	public static String UploadDir = "/home/wanjujiaoshoucwea9n0jmuijlioa0ofsrh3oxu/wwwroot/AllPics/"; //上传图片的绝对地址-图片服务器地址
//	public static String UploadDir = "/AllPics/"; //上传图片的绝对地址-图片服务器地址
	public static String HttpUrl = "/AllPics/"; //http请求图片的地址 
	
	public static final String SESSION_SECURITY_CODE = "sessionSecCode";
	public static final String SESSION_USER = "sessionUser";
	public static final String SESSION_USER_RIGHTS = "sessionUserRights";
	public static final String SESSION_ROLE_RIGHTS = "sessionRoleRights";
	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(code)|(home)|(loginerror)).*";	//不对匹配该值的访问路径拦截（正则）
	//".*/((login)|(logout)|(code)|(home)|(test)|(NotLogin)).*";	//不对匹配该值的访问路径拦截（正则）
	public static final String NO_INTERCEPTOR_PATH_PHONE = ".*/((info)|(test)).*" + //不对手机端传来的这些交易做访问路径判断
			"" +
			"" +
			"" +
			"" +
			"" +
			"";	
	
	public static ApplicationContext WEB_APP_CONTEXT = null; //该值会在web容器启动时由WebAppContextListener初始化

	public static final String RETURN_CODE = "returnCode";
	public static final String RETURN_MSG = "returnMsg";
	public static final String NORMAL_ERROR ="999999";		//正常报错编号
	public static final String NORMAL_SUCCESS ="000000";
	public static final String UNDIFINED_EX = "999991";		//未知错误
	
	public static final boolean isPrint = true;
	public static void print(Object msg){
		if(isPrint)
			System.out.println(JSON.toJSONString(msg));
	}
	
	//判断请求是从手机端发起还是电脑端发起
	public static boolean  isMobileDevice(String requestHeader){
        /**
         * android : 所有android设备
         * mac os : iphone ipad
         * windows phone:Nokia等windows系统的手机
         */
        String[] deviceArray = new String[]{"android","mac os","windows phone"};
        if(requestHeader == null)
            return false;
        requestHeader = requestHeader.toLowerCase();
        for(int i=0;i<deviceArray.length;i++){
            if(requestHeader.indexOf(deviceArray[i])>0){
                return true;
            }
        }
        return false;
	}
	
}
