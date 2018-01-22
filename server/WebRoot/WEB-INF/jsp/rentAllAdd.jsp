<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("path",request.getContextPath()); %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${path}/js/jquery.js"></script>
	<title>My Test</title>
	<link type="text/css" rel="stylesheet" href="../css/main.css" />

	<style type="text/css">
		body { width: 100%; height: 100%; background-color: #FFFFFF; text-align: center;}
		.input_txt { width: 200px; height: 20px; line-height: 20px;}
		.info { height: 40px; line-height: 40px;}
		.info th { text-align: right; width: 65px; color: #4f4f4f; padding-right: 5px; font-size: 13px;}
		.info td { text-align: left; }
	</style>

</head>

	<script type="text/javascript">
	function getProvince() {
		$.ajax({
			type : 'post',
			url : 'getPrivince.do',
			dataType : 'json',
			success : function(result) {
				$.each(result, function(entryIndex, entry) {
					var html = "<option value='" + entry.p_id + "'>"
							+ entry.p_name + "</option>";
					$("#provincediv").append(html); 
				});
			}
		});
		//加载户型
		$.ajax({
			type : 'post',
			url : 'getHuXing.do',
			dataType : 'json',
			success : function(result) {
				$.each(result, function(entryIndex, entry) {
					var html = "<option value='" + entry.type_id + "'>"
							+ entry.type_name + "</option>";
					$("#selhuxing").append(html);
				});
			}
		});
		//加载朝向
		$.ajax({
			type : 'post',
			url : 'getDirection.do',
			dataType : 'json',
			success : function(result) {
				$.each(result, function(entryIndex, entry) {
					var html = "<option value='" + entry.direction_id + "'>"
							+ entry.direction_name + "</option>";
					$("#seldirection").append(html);
				});
			}
		});
	}

	function getCity() {
		if (document.getElementById("citydiv").style.display == "block"
				|| document.getElementById("areadiv").style.display == "block") {
			document.getElementById("citydiv").style.display = "none";
			document.getElementById("areadiv").style.display = "none";
		}
		if (document.getElementById("citydiv").style.display == "none"
				&& document.getElementById("provincediv").value != 0) {
			document.getElementById("citydiv").style.display = "block";
		}
		$("#selcity option[value!=0]").remove();
		$("#selarea option[value!=0]").remove();
		var object = $("#provincediv");
		if (object.val() != 0) {
			$.ajax({
				type : 'post',
				url : 'getCity.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.c_id + "'>"
								+ entry.c_name + "</option>";
						$("#selcity").append(html);
					});
				}
			});
		}
	}

	function getArea() {
		if (document.getElementById("areadiv").style.display == "block") {
			document.getElementById("areadiv").style.display = "none";
		}
		if (document.getElementById("areadiv").style.display == "none"
				&& document.getElementById("selcity").value != 0) {
			document.getElementById("areadiv").style.display = "block";
		}
		$("#selarea option[value!=0]").remove();
		var object = $("#selcity");
		if (object.val() != 0) {
			$.ajax({
				type : 'post',
				url : 'getDistrict.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.d_id + "'>"
								+ entry.d_name + "</option>";
						$("#selarea").append(html);
					});
				}
			});
		}
	}

	function getCommunity() {
		$("#selcommunity option[value!=0]").remove();
		var object = $("#selarea");
		if (object.val() != 0) {
			$.ajax({
				type : 'post',
				url : 'getComm.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.community_id + "'>"
								+ entry.community_name + "</option>";
						$("#selcommunity").append(html);
					});
				}
			});
		}
	}
	//相当于JQUERY的初始化时候执行
	
</script>
	
	
	<body onload="getProvince()">
		<form action="save.do" name="userForm" id="userForm" target="result"
			method="post" onsubmit="return checkInfo();">
			<!-- 保存用户 -->
			<table border="0">
				<tr>
					<td>
						<div style="display: block;">
							请选择地址：
							<input type="hidden" id="province" value="${rentAll.pid }">
							<select id="provincediv" name="pid" style="width: 135px"
								onchange="getCity()">
								
								<option value="北京市">
									-请选择省份-
								</option>
							</select>
						</div>
					</td>
					<td>
						<div id="citydiv" style="display: none;">
							<select id="selcity" name="cid" style="width: 170px" onchange="getArea()">
								<option value="0">
									-请选择城市-
								</option>
							</select>
						</div>
					</td>
					<td>
						<div id="areadiv" style="display: none;">
							<select id="selarea" name="did" onchange="getCommunity()">
								<option value="0">
									-请选择地区-
								</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="communitydiv" style="display: block;">
							请选择小区：
							<select id="selcommunity" name="commid" style="width: 135px">
								<option value="0">
									-请选择小区-
								</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="huxingdiv" style="display: block;">
							请选择户型：
							<select id="selhuxing" name="huid" style="width: 135px">
								<option value="0">
									-请选择户型-
								</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="directiondiv" style="display: block;">
							请选择朝向：
							<select id="seldirection" name="directionid" style="width: 135px">
								<option value="0">
									-请选择朝向-
								</option>
							</select>
						</div>
					</td>
				</tr>								
			</table>

			<table border="0">
				<tr>
					<td>
						<div style="display: block;">
							请输入标题：
							<input type="text" name="title" value="${rentAll.title }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							请输入租金：
							<input type="text" name="rents" value="${rentAll.rents }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							联系人电话：
							<input type="text" name="phone" value="${rentAll.phone }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							请输入详细地址：
							<input type="text" name="address" value="${rentAll.address }" />
						</div>
					</td>
				</tr>				
				<tr>
					<td>
						<div style="display: block;">
							请输入房屋面积：
							<input type="text" name="rentsize" value="${rentAll.rentsize }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							请输入装修情况：
							<input type="text" name="rentstyle" value="${rentAll.rentstyle }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							详细的描述信息：
							<input type="text" name="rentdescribe" value="${rentAll.rentdescribe }" />
						</div>
					</td>
				</tr>				
			</table>
		</form>
		<iframe name="result" id="result" src="about:blank" frameborder="0" width="0" height="0"></iframe>

		<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js"></script>
		<script type="text/javascript">
	var dg;
	$(document).ready(function() {
		dg = frameElement.lhgDG;
		dg.addBtn('ok', '保存', function() {
			$("#userForm").submit();
		});
		if ($("#userId").val() != "") {
			$("#loginname").attr("readonly", "readonly");
			$("#loginname").css("color", "gray");
			var roleId = "${user.roleId}";
			if (roleId != "") {
				$("#roleId").val(roleId);
			}
		}
	});

	function checkInfo() {
		if ($("#title").val() == "") {
			alert("请输入标题!");
			$("#title").focus();
			return false;
		}
		if ($("#phone").val() == "") {
			alert("请输入电话!");
			$("#phone").focus();
			return false;
		}
		if ($("#rents").val() == "") {
			alert("请输入租金!");
			$("#rents").focus();
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
		alert("新增失败，该整租信息已存在！");
		$("#communityname").select();
		$("#communityname").focus();
	}
</script>
	</body>
</html>