<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("path",request.getContextPath()); %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>My Test</title>
		<link type="text/css" rel="stylesheet" href="${path}/css/main.css" />
		<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js" ></script>
		<style type="text/css">
			body { font-size: 14px; }
			input { vertical-align: middle; margin: 0; padding: 0 }
			.file-box { position: relative; width: 440px }
			.txt { height: 22px; border: 1px solid #cdcdcd; width: 180px;}
			.btn { background-color: #FFF; border: 1px solid #CDCDCD;height: 24px;width: 70px;}
			.file { position: absolute; top: 0; right: 80px; height: 24px; filter: alpha(opacity : 0); opacity: 0;width: 260px }
		</style>
	</head>
	<body>
	
		<div class="file-box">
	  		<form action="fileuploadControler/uploadPic.do" method="post" enctype="multipart/form-data">
	 			请选择图片：<input type='text' name='textfield' id='textfield' class='txt' />  
	 			<input type='button' class='btn' value='浏览...' />
	    		<input type="file" name="imgFile" class="file" id="imgFile1" size="28" onchange="document.getElementById('textfield').value=this.value" />
	 			
	 			<br />
	 			请选择图片：<input type='text' name='textfield2' id='textfield2' class='txt' />  
	 			<input type='button' class='btn' value='浏览...' />
	    		<input type="file" name="imgFile" class="file" id="imgFile2" size="28" onchange="document.getElementById('textfield2').value=this.value" />
	 			
	 			<input type="submit" name="submit" class="btn" value="上传" />
	  		</form>
		</div>
		<div class="y_nextto_left">
			<div class="y_tou_img" id="status1">
				<c:if test="${not empty sysuserinfo.headimgpath}">
					<img src="${path}/${sysuserinfo.headimgpath}" />
				</c:if>
			</div>
		</div>
	</body>
	
	<script type="text/javascript">
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
</script>


</html>