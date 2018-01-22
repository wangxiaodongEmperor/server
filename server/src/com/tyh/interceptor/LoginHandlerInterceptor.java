package com.tyh.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.tyh.entity.User;
import com.tyh.util.Constant;

public class LoginHandlerInterceptor extends HandlerInterceptorAdapter{

	private final Logger log = Logger.getLogger(getClass());
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String path = request.getServletPath();

		String requestHeader = request.getHeader("user-agent"); //检测是电脑还是手机
        if(Constant.isMobileDevice(requestHeader)){
        	log.info("使用手机浏览器");
        }else{
        	log.info("使用电脑浏览器");
        }
		
        if(path.matches(Constant.NO_INTERCEPTOR_PATH)){		
			//登录退出验证码不需要做检验
			return true;
		} else{
			HttpSession session = request.getSession();
			User user = (User)session.getAttribute(Constant.SESSION_USER);
			if(user!=null){
				return true;
			}else{
				response.sendRedirect(request.getContextPath()+"/loginerror.do");
				return false;
			}
		}
	}
	
}
