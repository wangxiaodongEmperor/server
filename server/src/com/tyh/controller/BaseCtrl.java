package com.tyh.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.tyh.util.Constant;

/**
 * @title :struts2基类 初始化 request response context 等对象
 * @description :
 * @author: Hehzen
 * @data: 2014-12-09
 */
public class BaseCtrl {
	@Autowired
	protected HttpServletRequest request;
	@Autowired
	protected HttpSession session;
	
	

	/**
	 * 初始化图片加载路径
	 * */
	protected void initPicPath2(){
		
		String aa = request.getSession().getServletContext().getRealPath("/");
		
		String aaa = request.getRealPath("/");
		String bbb = request.getContextPath();
		String ccc = aaa.substring(0, aaa.length()-bbb.length());
		Constant.UploadDir = ccc +"ServerPics/";
	}
	
	/**
	 * 通过PrintWriter将响应数据写入response，ajax可以接受到这个数据
	 */
	protected void renderData(HttpServletResponse response, String data) {
		PrintWriter printWriter = null;
		try {
			response.setContentType("text/html;charset=utf-8");
			printWriter = response.getWriter();
			printWriter.print(data);
		} catch (IOException ex) {
			Constant.print(ex.toString());
		} finally {
			if (null != printWriter) {
				printWriter.flush();
				printWriter.close();
			}
		}
	}
}
