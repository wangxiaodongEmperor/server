<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("path",request.getContextPath()); %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js"></script>
		<title>My Test</title>
		<link type="text/css" rel="stylesheet" href="../css/main.css" />

		<style type="text/css">
body {
	width: 100%;
	height: 100%;
	background-color: #FFFFFF;
	text-align: center;
}

.input_txt {
	width: 200px;
	height: 20px;
	line-height: 20px;
}

.info {
	height: 40px;
	line-height: 40px;
}

.info th {
	text-align: right;
	width: 65px;
	color: #4f4f4f;
	padding-right: 5px;
	font-size: 13px;
}

.info td {
	text-align: left;
}
</style>

	</head>

	<body>
		<form action="save.do" name="userForm" id="userForm" target="result"
			method="post" onsubmit="return checkInfo();">
			<table border="0" align="left">
				<tr>
					<td>
						<div style="display: block;">
							请输入户型：
							<input type="text" name="type" value="${type.type }" />
						</div>
					</td>
				</tr>
			</table>
		</form>
		<iframe name="result" id="result" src="about:blank" frameborder="0"
			width="0" height="0"></iframe>

		<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js"></script>
		<script type="text/javascript">
	var dg;
	$(document).ready(function() {
		dg = frameElement.lhgDG;
		dg.addBtn('ok', '保存', function() {
			$("#userForm").submit();
		});
	});

	function checkInfo() {
		if ($("#direction").val() == "") {
			alert("请输入户型!");
			$("#direction").focus();
			return false;
		}
		return true;
	}

	function success() {
		if (dg.curWin.document.forms[0]) {
			dg.curWin.document.forms[0].action = dg.curWin.location + "";
			dg.curWin.document.forms[0].submit();
		} else {
			dg.curWin.location.reload();
		}
		dg.cancel();
	}

	function failed() {
		alert("新增失败，该朝向已存在！");
		$("#direction").select();
		$("#direction").focus();
	}
</script>
	</body>
</html>