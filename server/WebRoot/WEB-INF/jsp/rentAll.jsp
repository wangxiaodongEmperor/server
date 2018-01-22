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
	<form action="rentAll.do" method="post" name="userForm" id="userForm">
	<div class="search_div">
		标题：<input type="text" name="title"/>
		&nbsp;&nbsp;&nbsp;&nbsp;
		截止日期：
		<input type="text" name="beginDate"  onclick="WdatePicker()" readonly="readonly" style="width:70px;"/> -
		<input type="text" name="endDate"  onclick="WdatePicker()" readonly="readonly" style="width:70px;"/>
		&nbsp;&nbsp;&nbsp;&nbsp;租金：<input type="text" name="rents" />
		&nbsp;&nbsp;&nbsp;&nbsp;电话：<input type="text" name="phone" />
		<a href="javascript:search();" class="myBtn"><em>查询</em></a>
	</div>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="main_table">
		<tr class="main_head">
			<th><input type="checkbox" name="sltAll" id="sltAll" onclick="sltAllUser()"/></th>
			<th>序号</th>
			<th>标题</th>
			<th>区/县</th>
			<th>小区</th>			
			<th>户型</th>	
			<th>朝向</th>	
			<th>租金</th>	
			<th>电话</th>
			<th width="160">发布时间</th>
			<th>操作</th>
		</tr>
		<c:choose>
			<c:when test="${not empty rentAllList}">
				<c:forEach items="${rentAllList }" var="rent" varStatus="vs">
				<tr class="main_info">
				<td><input type="checkbox" name="rentIds" id="rentIds${rent.id }" value="${rent.id }"/></td>
				<td>${vs.index+1}</td>
				<td><a href="javascript:editRentDetail(${rent.id });">${rent.title }</a></td>
				<td>${rent.districtname }</td>
				<td>${rent.commname }</td>				
				<td>${rent.huname }</td>				
				<td>${rent.directionname }</td>				
				<td>${rent.rents }</td>				
				<td>${rent.phone }</td>				
				<td><fmt:formatDate value="${rent.ptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><a href="javascript:editRent(${rent.id });">修改</a> | <a href="javascript:delRent(${rent.id });">删除</a></td>
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
			<a href="javascript:addRentAll();" class="myBtn"><em>新增</em></a>
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
		
		function addRentAll(){
			//$(".shadow").show();
			var dg = new $.dialog({
				title:'新增房屋整租',
				id:'user_new',
				width:900,
				height:450,
				iconTitle:false,
				cover:true,
				maxBtn:false,
				xButton:true,
				resize:true,
				page:'rentAll/add.do'
				});
    		dg.ShowDialog();
		}
		
		function editRent(rentId){
			var dg = new $.dialog({
				title:'修改整租信息',
				id:'user_edit',
				width:900,
				height:450,
				iconTitle:false,
				cover:true,
				maxBtn:false,
				resize:false,
				page:'rentAll/edit.do?rentId='+rentId
				});
    		dg.ShowDialog();
		}
		
		function editRentDetail(rentId){
			var dg = new $.dialog({
				title:'编辑整租信息详细',
				id:'user_edit',
				width:900,
				height:450,
				iconTitle:false,
				cover:true,
				maxBtn:false,
				resize:false,
				page:'rentAll/editDetail.do?rentId='+rentId
				});
    		dg.ShowDialog();	
		}
		
		function delRent(rentId){
			if(confirm("确定要删除该记录？")){
				var url = "rentAll/delete.do?rentId="+rentId;
				$.get(url,function(data){
					if(data=="success"){
						document.location.reload();
					}
				});
			}
		}
		
		function search(){
			
			$.ajax({
				type : 'post',
				url : 'rentAll.do',
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						
						
						var html = "<option value='" + entry.p_id + "'>"
								+ entry.p_name + "</option>";
						$("#provincediv").append(html);
						
						
						
					});
				}
			});
			
			$("#userForm").submit();
		}
		
		function exportUser(){
			document.location = "user/excel.do";
		}
	</script>
</body>
</html>