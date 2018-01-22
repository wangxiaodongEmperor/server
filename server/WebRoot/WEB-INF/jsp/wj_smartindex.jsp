<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script language="javascript" src="<%=basePath%>js/jquery-1.5.1.min.js"></script>
		<script language="javascript" src="<%=basePath%>js/jquery.js"></script>
		<script language="javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>

<script type="text/javascript">

	//上传文件
	function fileUpLoad() {
		
		var fileName = $("#btnFile").val();//文件名
		fileName = fileName.split("\\");
		fileName = fileName[fileName.length - 1];
		
		jQuery.ajaxSettings.traditional = true;
		$.ajaxFileUpload({
					url : 'BlockPicUploadCtrl/SmartfileUpLoad.do',
					secureuri : false,				//安全协议
					fileElementId : 'btnFile',		//id
					type : 'POST',
					dataType : 'json',
					data : { dir : 'BlockPics' },	//图片保存的文件夹地址
					async : false,
					error : function(data, status, e) {
						alert('上传失败'+e);
					},
					success : function(json) {
						if (json.resultFlag == false) {
							alert(json.resultMessage);
						} else {
							var next = $("#fileUpLoad").html();
							$("#fileUpLoad").html(
											"<div id='"+json.fileid+"'>"
													+ "文件:"
													+ json.ori_filename
													+ "   <a href='#' onclick='filedelete("
													+ "\"" + json.fileid + "\"" + ","
													+ "\"" + json.filename + "\"" + ","
													+ "\"" + json.dir + "\""
													+ ")'>删除a</a>"
													+ "<br/><img width=\"100\" height=\"100\" src='"+json.abspath+"'/></div>");
							$("#fileUpLoad").append(next);
						}
					}
				});
	};

	//文件删除
	function filedelete(fileid,filename, dir) {
		jQuery.ajaxSettings.traditional = true;
		$.ajax({
			url : 'BlockPicUploadCtrl/SmartfileDelete.do',
			type : 'POST',
			dataType : 'json',
			data : { fileid : fileid , filename : filename, dir : dir },	//图片保存的文件夹地址
			async : false,
			error : function() {
				alert('Operate Failed!');
			},
			success : function(json) {
				if (json.resultFlag == false) {
					alert(json.resultMessage);
				} else {
					alert('删除成功!');
					$("#" + fileid).remove();
				}
			}
		});
	};
	
	function check(fileObj) {
		var allowExtention = ".jpg,.bmp,.gif,.png,.jpeg"; // 允许上传文件的后缀名document.getElementById("hfAllowPicSuffix").value;
		var extention = fileObj.value.substring(fileObj.value.lastIndexOf(".") + 1).toLowerCase();
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
</script>

	</head>

	<body>
		<div id="fileUpLoad" class="manage">
			添附文件
			<!-- 自定义 <input type="file"/> -->
			<input type="file" id="btnFile" name="btnFile"
				onchange="txtFoo.value=this.value;check(this);" hidden="hidden" />
			<input type="text" id="txtFoo" readonly="readonly" style="width: 300px" />
			<button onclick="btnFile.click()" style="height: 25px;">
				选择文件
			</button>
		</div>

	</body>
</html>