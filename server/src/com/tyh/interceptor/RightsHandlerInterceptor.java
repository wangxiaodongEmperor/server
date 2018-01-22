package com.tyh.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.tyh.entity.User;
import com.tyh.util.Constant;
import com.tyh.util.RightsHelper;
import com.tyh.util.Tools;

public class RightsHandlerInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		String path = request.getServletPath();
		System.out.println("===RightsHandlerInterceptor==="+path);
		
		String requestHeader = request.getHeader("user-agent");  //检测是电脑还是手机
		if(path.matches(Constant.NO_INTERCEPTOR_PATH)){
			//登录退出交易不做判断
			return true;
		} else if(path.matches(Constant.NO_INTERCEPTOR_PATH_PHONE) && Constant.isMobileDevice(requestHeader)){
			//手机端发起的请求，不做登录校验
			return true;
		}
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(Constant.SESSION_USER);
		
		//System.out.println(path+"===="+menuId);
		return super.preHandle(request, response, handler);
	}
}
