<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("path",request.getContextPath()); %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Test</title>
<link type="text/css" rel="stylesheet" href="${path}/css/main.css"/>
</head>
<body>
	<form action="user.do" method="post" name="userForm" id="userForm">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="main_table">
		<tr class="main_head">
			<th><input type="checkbox" name="sltAll" id="sltAll" onclick="sltAllUser()"/></th>
			<th>序号</th>
			<th>房屋户型</th>
			<th>操作</th>
		</tr>
		<c:choose>
			<c:when test="${not empty rentTypeList}">
				<c:forEach items="${rentTypeList }" var="type" varStatus="vs">
				<tr class="main_info">
				<td><input type="checkbox" name="rentIds" id="rentIds${type.id }" value="${type.id }"/></td>
				<td>${vs.index+1}</td>
				<td>${type.type }</td>
				<td><a href="javascript:delDirection(${type.id });">删除</a></td>
				</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr class="main_info">
					<td colspan="7">没有相关数据</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	<div class="page_and_btn">
		<div>
			<a href="javascript:addDirectionAll();" class="myBtn"><em>新增</em></a>
			<a href="javascript:exportUser();" class="myBtn"><em>导出</em></a>
		</div>
		${user.page.pageStr }
	</div>
	</form>
	<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js"></script>
	<script type="text/javascript" src="${path}/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${path}/js/lhgdialog/lhgdialog.min.js?t=self&s=areo_blue"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".main_info:even").addClass("main_table_even");
		});
		
		function sltAllUser(){
			if($("#sltAll").attr("checked")){
				$("input[name='rentIds']").attr("checked",true);
			}else{
				$("input[name='rentIds']").attr("checked",false);
			}
		}
		
		function addDirectionAll(){
			//$(".shadow").show();
			var dg = new $.dialog({
				title:'新增房屋户型',
				id:'user_new',
				width:400,
				height:200,
				iconTitle:false,
				cover:true,
				maxBtn:false,
				xButton:true,
				resize:true,
				page:'rent_type/add.do'
				});
    		dg.ShowDialog();
		}
		
		function delDirection(rentTypeId){
			if(confirm("确定要删除该记录？")){
				var url = "rent_type/delete.do?rentTypeId="+rentTypeId;
				$.get(url,function(data){
					if(data=="success"){
						document.location.reload();
					}
				});
			}
		}
		
		function search(){
			$("#userForm").submit();
		}
		
		function exportUser(){
			document.location = "user/excel.do";
		}
	</script>
</body>
</html>