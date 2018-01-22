package com.tyh.resolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.tyh.util.Constant;

public class MyExceptionResolver implements HandlerExceptionResolver{
	
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		// TODO Auto-generated method stub
		System.out.println("==============异常开始=============");
		ex.printStackTrace();
		System.out.println("==============异常结束=============");
		ModelAndView mv = new ModelAndView("error");
		
		
		mv.addObject(Constant.RETURN_CODE, Constant.UNDIFINED_EX);
		mv.addObject(Constant.RETURN_MSG, ex.toString().replaceAll("\n", "<br/>"));

//		mv.addObject("exception", ex.toString().replaceAll("\n", "<br/>"));
		
		return mv;
	}

}
