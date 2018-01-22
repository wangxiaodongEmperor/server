<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("path",request.getContextPath()); %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>My Test</title>
		<link type="text/css" rel="stylesheet" href="css/main.css" />
	</head>
	
	<body>
		<form action="community.do" method="post" name="userForm"
			id="userForm">

			<div class="search_div">
				社区名称：
				<input type="text" name="communityname"
					value="${community.communityname }" />
				<a href="javascript:search();" class="myBtn"><em>查询</em> </a>
			</div>

			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="main_table">
				<tr class="main_head">
					<th>
						<input type="checkbox" name="sltAll" id="sltAll"
							onclick="sltAllUser()" />
					</th>
					<th>
						序号
					</th>
					<th>
						社区名称
					</th>
					<th>
						社区地址
					</th>
					<th>
						省
					</th>
					<th>
						市
					</th>
					<th>
						区/县
					</th>
					<th>
						经度
					</th>
					<th>
						维度
					</th>
					<th>
						小区住户数
					</th>
					<th>
						操作
					</th>
				</tr>
				<c:choose>
					<c:when test="${not empty listpage}">
						<c:forEach items="${listpage }" var="community" varStatus="vs">
							<tr class="main_info">
								<td>
									<input type="checkbox" name="rentIds" id="rentIds${rent.id }"
										value="${rent.id }" />
								</td>
								<td>
									${vs.index+1}
								</td>
								<td>
									${community.communityname }
								</td>
								<td>
									${community.address }
								</td>
								<td>
									${community.provincename }
								</td>
								<td>
									${community.cityname }
								</td>
								<td>
									${community.districtname }
								</td>
								<td>
									${community.longtitude }
								</td>
								<td>
									${community.lantitude }
								</td>
								<td>
									${community.households }
								</td>
								<td>
									<a href="javascript:editCommunity(${community.id });">修改</a> |
									<a href="javascript:delCommunity(${community.id });">删除</a>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="main_info">
							<td colspan="7">
								没有相关数据
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
			<div class="page_and_btn">
				<div>
					<a href="javascript:addRentAll();" class="myBtn"><em>新增</em> </a>
					<a href="javascript:exportUser();" class="myBtn"><em>导出</em> </a>
				</div>
				${user.page.pageStr }
			</div>
		</form>

		<div class="page_and_btn">
			${page.pageStr }
		</div>
		
<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${path}/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${path}/js/lhgdialog/lhgdialog.min.js?t=self&s=areo_blue"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".main_info:even").addClass("main_table_even");
	});

	function sltAllUser() {
		if ($("#sltAll").attr("checked")) {
			$("input[name='rentIds']").attr("checked", true);
		} else {
			$("input[name='rentIds']").attr("checked", false);
		}
	}

	function addRentAll() {
		//$(".shadow").show();
		var dg = new $.dialog({
			title : '新增社区',
			id : 'user_new',
			width : 600,
			height : 300,
			iconTitle : false,
			cover : true,
			maxBtn : false,
			xButton : true,
			resize : true,
			page : 'community/add.do'
		});
		dg.ShowDialog();
	}

	function editCommunity(communityId) {
		var dg = new $.dialog({
			title : '修改用户',
			id : 'user_edit',
			width : 600,
			height : 300,
			iconTitle : false,
			cover : true,
			maxBtn : false,
			resize : false,
			page : 'community/edit.do?communityId=' + communityId
		});
		dg.ShowDialog();
	}

	function delCommunity(communityId) {
		if (confirm("确定要删除该记录？")) {
			var url = "community/delete.do?communityId=" + communityId;
			$.get(url, function(data) {
				if (data == "success") {
					document.location.reload();
				}
			});
		}
	}

	function search() {
		$("#userForm").submit();
	}

	function exportUser() {
		document.location = "user/excel.do";
	}
</script>
</body>
</html>