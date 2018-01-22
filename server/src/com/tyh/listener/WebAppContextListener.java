package com.tyh.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.tyh.util.Constant;

public class WebAppContextListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent event) {
		// TODO Auto-generated method stub
		System.out.println("========销毁Spring WebApplicationContext");
	}

	public void contextInitialized(ServletContextEvent event) {
		// TODO Auto-generated method stub
		
		Constant.WEB_APP_CONTEXT = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
//		Const.WEB_APP_CONTEXT = new ClassPathXmlApplicationContext("spring-mvc.xml");
		System.out.println("========获取Spring WebApplicationContext");
		System.out.println("========WebApplicationContext  :   "+Constant.WEB_APP_CONTEXT);
		
	}

}
