<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("path",request.getContextPath()); %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>My Test</title>
	<link type="text/css" rel="stylesheet" href="../css/main.css" />
	<script type="text/javascript" src="${path}/js/jquery.js"></script>
	<style type="text/css">
		body { width: 100%; height: 100%; background-color: #FFFFFF; text-align: center;}
		.input_txt { width: 200px; height: 20px; line-height: 20px;}
		.info { height: 40px; line-height: 40px;}
		.info th { text-align: right; width: 65px; color: #4f4f4f; padding-right: 5px; font-size: 13px;}
		.info td { text-align: left;}
	</style>
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
						;
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
		//document.getElementById("provincediv").value="${community.pid}"; 
	</script>
</head>

	<body onload="getProvince()">

		<form action="save.do" name="userForm" id="userForm" target="result"
			method="post" onsubmit="return checkInfo();">

			<table border="0">
				<tr>
					<td>
						<div style="display: block;">
							请选择地址：
							<select id="provincediv" name="pid" style="width: 135px" onchange="getCity()">
								<option value="0">
									-请选择省份-
								</option>
							</select>
						</div>
					</td>
					<td>
						<div id="citydiv" style="display: none;">
							<select id="selcity"  name="cid" style="width: 170px" onchange="getArea()">
								<option value="0">
									-请选择城市-
								</option>
							</select>
						</div>
					</td>
					<td>
						<div id="areadiv" style="display: none;">
							<select id="selarea"  name="did">
								<option value="0">
									-请选择地区-
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
							请输入名称：
							<input type="text" name="communityname" value="${community.communityname }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							请输入地址：
							<input type="text" name="address" value="${community.address }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							请输入经度：
							<input type="text" name="longtitude" value="${community.longtitude }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							请输入维度：
							<input type="text" name="lantitude" value="${community.lantitude }" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="display: block;">
							当前住户数：
							<input type="text" name="households" value="${community.households }" />
						</div>
					</td>
				</tr>
			</table>
		</form>
		<iframe name="result" id="result" src="about:blank" frameborder="0"
			width="0" height="0"></iframe>

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
		if ($("#communityname").val() == "") {
			alert("请输入社区名!");
			$("#communityname").focus();
			return false;
		}
		if ($("#address").val() == "") {
			alert("请输入详细地址!");
			$("#address").focus();
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
		alert("新增失败，该小区已存在！");
		$("#communityname").select();
		$("#communityname").focus();
	}
</script>
</body>
</html>