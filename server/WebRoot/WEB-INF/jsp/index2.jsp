<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.alibaba.fastjson.JSON,java.util.*,com.tyh.entity.Menu"  %>
<%
	request.setAttribute("path",request.getContextPath());
	List<Menu> menuList = (List<Menu>)request.getAttribute("menuList");
	System.out.println(JSON.toJSONString(menuList));
	System.out.println();
%>

<html>
  <head>
	<title>测试菜单</title>
  </head>
  
  <body>
    			<c:forEach items="${menuList}" var="menu">
				<c:if test="${menu.hasMenu}">
					<h1><a>${menu.menuName }</a></h1>
					<div class="menu_line">
						<ul>
							<c:forEach items="${menu.subMenu}" var="sub">
								<c:if test="${sub.hasMenu}">
									<c:choose>
										<c:when test="${not empty sub.menuUrl}">
										<li><a href="${sub.menuUrl }" target="mainFrame">${sub.menuName }</a></li>
										</c:when>
										<c:otherwise>
										<li><a href="javascript:void(0);" target="mainFrame">${sub.menuName }</a></li>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</c:forEach>
  </body>
</html>
