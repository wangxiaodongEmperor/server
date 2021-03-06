<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setAttribute("path", request.getContextPath()+"/");
	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script language="javascript"
			src="<%=basePath%>js/jquery-1.5.1.min.js"></script>
		<script language="javascript" src="<%=basePath%>js/jquery.js"></script>
		<script language="javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>

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

		<script type="text/javascript">
	function seltargetFunction() {
		$("#seltarget option[value!=0]").remove();
		var object = $("#selarea");
		if (object.val() != 0) {
			$.ajax({
				type : 'post',
				url : '${path}/targetCtrl/getTarget.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.name + "'>"
								+ entry.name + "</option>";
						$("#seltarget").append(html);
					});
				}
			});
		}
	}
	function selfunctionFunction() {
		$("#selfunction option[value!=0]").remove();
		var object = $("#selarea");
		if (object.val() != 0) {
			$.ajax({
				type : 'post',
				url : '${path}/functionCtrl/getFunction.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.name + "'>"
								+ entry.name + "</option>";
						$("#selfunction").append(html);
					});
				}
			});
		}
	}
	function selpersonalityFunction() {
		$("#selpersonality option[value!=0]").remove();
		var object = $("#selarea");
		if (object.val() != 0) {
			$.ajax({
				type : 'post',
				url : '${path}/personalityCtrl/getPersonality.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.name + "'>"
								+ entry.name + "</option>";
						$("#selpersonality").append(html);
					});
				}
			});
		}
	}

	function load() {
		seltargetFunction();
		selfunctionFunction();
		selpersonalityFunction();
	}

	//上传文件
	function fileUpLoad() {

		var fileName = $("#btnFile").val();//文件名
		fileName = fileName.split("\\");
		fileName = fileName[fileName.length - 1];

		jQuery.ajaxSettings.traditional = true;
		$.ajaxFileUpload({
			url : '${path}/GiftPicUploadCtrl/SmartfileUpLoad.do',
			secureuri : false, //安全协议
			fileElementId : 'btnFile', //id
			type : 'POST',
			dataType : 'json',
			data : {
				dir : 'GiftPics'
			}, //图片保存的文件夹地址
			async : false,
			error : function(data, status, e) {
				alert('上传失败' + e);
			},
			success : function(json) {
				if (json.resultFlag == false) {
					alert(json.resultMessage);
				} else {
					
					var next = $("#fileUpLoad").html();
					$("#fileUpLoad").html(
							"<div id='"+json.fileid+"'>" + "文件:"
									+ json.ori_filename
									+ "   <a href='#' onclick='filedelete("
									+ "\"" + json.fileid + "\"" + "," + "\""
									+json.abspath + "\"" + ")'>删除</a>"
									+ "<br/><img width=\"200\" height=\"100\" src='"+json.abspath+"'/></div>");
					$("#fileUpLoad").append(next);
					//提交fileid到block
					var ids = $("#div_coverimgid").html();
					$("#div_coverimgid").html("<input class='"+json.fileid+"' id='imageid' type='hidden' name='imageid' value='"+json.fileid+"'/>");
					$("#div_coverimgid").append(ids);
					
					//显示图片
				}
			}
		});
	};

	//文件删除
	function filedelete(fileid, filename) {
		jQuery.ajaxSettings.traditional = true;
		$.ajax({
			url : '${path}/GiftPicUploadCtrl/SmartfileDelete.do',
			type : 'POST',
			dataType : 'json',
			data : {
				fileid : fileid,
				filename : filename
			}, //图片保存的文件夹地址
			async : false,
			error : function() {
				alert('Operate Failed!');
			},
			success : function(json) {
				if (json.resultFlag == false) {
					alert(json.resultMessage);
				} else {
					$("." + fileid).remove();
					$("#" + fileid).remove();
				}
			}
		});
	};

	function check(fileObj) {
		var allowExtention = ".jpg,.bmp,.gif,.png,.jpeg"; // 允许上传文件的后缀名document.getElementById("hfAllowPicSuffix").value;
		var extention = fileObj.value.substring(
				fileObj.value.lastIndexOf(".") + 1).toLowerCase();
		var browserVersion = window.navigator.userAgent.toUpperCase();
		if (allowExtention.indexOf(extention) > -1) {
			fileUpLoad();
		} else {
			alert("仅支持" + allowExtention + "为后缀名的文件!");
			fileObj.value = ""; // 清空选中文件
			if (browserVersion.indexOf("MSIE") > -1) {
				fileObj.select();
				document.selection.clear();
			}
			fileObj.outerHTML = fileObj.outerHTML;
			return false;
		}
	}
	
	function checkPrice(obj){
		obj.value=obj.value.replace(/[^\d.]/g,"");
		obj.value=obj.value.replace(/^\./g,"");
		//保证朱出现一次，而没有多个
		obj.value = obj.value.replace(/\.{2,}/g,".");
		//保证只出现一次，而不能出现两次以上
		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	}
	function chkLast(obj){
		if(obj.value.substr((obj.value.length-1),1)=='.'){
			obj.value = obj.value.substr(0,(obj.value.length-1));
		}
		
	}
</script>
	</head>

	<body onload="load()">
		<form action="save.do" name="userForm" id="userForm" target="result" method="post" onsubmit="return checkInfo();">
			<input id="id" type="hidden" name="id" value="${Gift4WJ.id }" />
			<input id="blockid" type="hidden"  name="blockid" value="${blockid }" />
			
			<div id="div_coverimgid"></div>
			<table border="0" align="left">
				<tr>
					<td align="left">
						<div
							style="display: block; padding-top: 10px; padding-left: 20px;">
							玩具标题：
							<input id="title" type="text" name="title"
								value="${Gift4WJ.title }" />
						</div>
					</td>
				</tr>
				<tr>
					<td align="left">
						<div
							style="display: block; padding-top: 10px; padding-left: 20px;">
							跳转链接：
							<input id="linkurl" type="text" name="linkurl" />
							<span style="color: red;">(不为空)</span>
						</div>
					</td>
				</tr>				
				<tr>
					<td align="left">
						<div style="display: block; padding-top: 10px; padding-left: 20px;">
							<span>设置权重：</span>
							<input id="weight" type="text" name="weight" value="1" />
							<span style="color: red;">(默认写 1)</span>

							<span style="padding-left: 20px;">玩具编码：</span>
							<input id="giftcode" type="text" name="giftcode" value="" />
							<span style="color: red;">(选填)</span>
						</div>
					</td>
				</tr>
				<tr>
					<td align="left">
						<div style="display: block; padding-top: 10px; padding-left: 20px;">
							<span>输入现价：</span>
							<input id="currentprice" type="text" name="currentprice" value="" onkeyup="checkPrice(this)" onblur="chkLast(this)"/>

							<span style="padding-left: 20px;">输入原价：</span>
							<input id="originalprice" type="text" name="originalprice" value="" onkeyup="checkPrice(this)" onblur="chkLast(this)"/>
						
							<span style="padding-left: 20px;">输入折扣：</span>
							<input id="discount" type="text" name="discount" value="" onkeyup="checkPrice(this)" onblur="chkLast(this)"/>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div
							style="display: block; padding-top: 10px; padding-left: 20px;">
							<span>是否精选：</span>
							<select name="isspecial" style="width: 170px;">
								<option value="是">
									是
								</option>
								<option value="否">
									否
								</option>
							</select>

							<span style="padding-left: 20px;">是否新品：</span>
							<select name="isnew" style="width: 170px;">
								<option value="是">
									是
								</option>
								<option value="否">
									否
								</option>
							</select>

							<span style="padding-left: 20px;">性别分类：</span>
							<select name="giftsex" style="width: 170px;">
								<option value="全部">
									全部
								</option>
								<option value="男孩">
									男孩
								</option>
								<option value="女孩">
									女孩
								</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div
							style="display: block; padding-top: 10px; padding-left: 20px;">
							<span>赠送对象：</span>
							<select id="seltarget" name="gifttarget" style="width: 170px">
								<option value="全部">
									-请选择赠送对象-
								</option>
							</select>

							<span style="padding-left: 20px;">玩具功能：</span>
							<select id="selfunction" name="giftfunction" style="width: 170px">
								<option value="全部">
									-请选择玩具功能-
								</option>
							</select>

							<span style="padding-left: 20px;">Ta的个性：</span>
							<select id="selpersonality" name="giftpersonality"
								style="width: 170px">
								<option value="全部">
									-请选择Ta的个性-
								</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td align="left">
						<div
							style="display: block; padding-top: 10px; padding-left: 20px;">
							<span style="padding-bottom: 5px;">封面简介：</span>
							<br />
							<textarea rows="5" cols="102" name="detail"
								value="${Gift4WJ.detail }"></textarea>
						</div>
					</td>
				</tr>
			</table>
		</form>

		<br />

		<table border="0" align="left">
			<tr>
				<td align="left">
					<div id="fileUpLoad" class="manage" style="float: left;padding-top: 10px; padding-left: 20px;">
						添附文件：
						<!-- 自定义 <input type="file"/> -->
						<input type="file" id="btnFile" name="btnFile"
							onchange="txtFoo.value=this.value;check(this);" hidden="hidden" />
						<input type="text" id="txtFoo" readonly="readonly" style="width: 300px" />
						<button onclick="btnFile.click()" style="height: 25px;"> 选择文件 </button>
					</div>
				</td>
			</tr>
		</table>


		<iframe name="result" id="result" src="about:blank" frameborder="0"
			width="0" height="0">
		</iframe>

<script type="text/javascript">
	var dg;
	$(document).ready(function() {
		dg = frameElement.lhgDG;
		dg.addBtn('ok', '保存', function() {
			$("#userForm").submit();
		});
	});

	function checkInfo() {
		if ($("#block").val() == "") {
			alert("请输入攻略标题");
			$("#block").focus();
			return false;
		} else if ($("#weight").val() == "") {
			alert("请输入权重");
			$("#weight").focus();
			return false;
		} else if ($("#linkurl").val() == "") {
			alert("请输入连接地址");
			$("#linkurl").focus();
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
		alert("新增失败，该赠送对象已存在！");
		$("#target").select();
		$("#target").focus();
	}
</script>
	</body>
</html>