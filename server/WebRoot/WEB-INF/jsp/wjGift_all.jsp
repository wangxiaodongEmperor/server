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
	<form action="giftCtrl.do" method="post" name="userForm" id="userForm">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="main_table">
			<tr class="main_head">
				<th>序号-(编号)</th>
				<th style="max-width: 250px; padding-left: 3px;padding-right: 3px;">标题</th>
				<th>原价</th>
				<th>现价</th>
				<th>链接地址</th>
				<th>赠送对象</th>
				<th>玩具功能</th>
				<th>Ta的个性</th>
				<th>点击数</th>
				<th>封面图</th>
				<th>更新日期</th>
				<th>权重</th>
				<th>操作</th>
			</tr>
			<c:choose>
				<c:when test="${not empty list}">
				
					<c:forEach items="${list }" var="item" varStatus="vs">
					<tr class="main_info" style="padding-top: 3px;padding-bottom: 3px;">
					<td>${vs.index+1}-(${item.id })</td>
					<td style="max-width: 250px; padding-left: 3px;padding-right: 3px;"><a href="javascript:editItem(${item.id });">${item.title }</a></td>
					<td>${item.originalprice }</td>
					<td>${item.currentprice }</td>
					<td>${item.linkurl }</td>
					<td>${item.gifttarget }</td>
					<td>${item.giftfunction }</td>
					<td>${item.giftpersonality }</td>
					<td>${item.clickcount }</td>
					<td><img src='${item.coverimage }' width="160" height="80" style="padding-top: 3px;padding-bottom: 3px;"/></td>
					<td><fmt:formatDate value="${item.releasedate}" pattern="yyyy-MM-dd"/></td>
					<td>${item.weight }</td>
					<td><a>删除</a></td>
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
			<div class="page_and_btn">
				${page.pageStr }
			</div>
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
		
		function addGiftAll(blockid){
			var dg = new $.dialog({
				title:'新增礼物',
				id:'user_new',
				width:860,
				height:450,
				iconTitle:false,
				cover:true,
				maxBtn:false,
				xButton:true,
				resize:true,
				page:'${path}/giftCtrl/add.do?blockid='+blockid
				});
    		dg.ShowDialog();
		}
		
		function editItem(id){
			var dg = new $.dialog({
				title:'修改礼物',
				id:'user_new',
				width:860,
				height:450,
				iconTitle:false,
				cover:true,
				maxBtn:false,
				xButton:true,
				resize:true,
				page:'${path}/giftCtrl/edit.do?giftid='+id
				});
    		dg.ShowDialog();
		}
		
		
		function deleteItem(id){
			if(confirm("确定要删除该记录？")){
				var url = "${path}/giftCtrl/delete.do?id="+id;
				$.get(url,function(data){
					if(data=="success"){
						document.location.reload();
					}
				});
			}
		}
		
		function goback(){
			window.location.href ="${path}/blockCtrl.do";
		}
		
		function search(){
			$("#userForm").submit();
		}
		
	</script>
</body>
</html>