<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% request.setAttribute("path",request.getContextPath()); %>

<html>
	<head>
		<title>ajax_upload.html</title>
		<!-- 注：jquery 必须放到ajaxfileupload.js前面来，否则使用不了 -->
		<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js"></script>
		<script type="text/javascript" src="${path}/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${path}/js/uploadPic.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/kindeditor/kindeditor-min.js" charset="UTF-8"></script>
		<!-- 注：js数组的扩展函数 -->
 
	<script type="text/javascript"> 
		var addfileIds = [];//存储附件的ID
		var pre_view_count = 1;//预览元素索引初始值
		var max_view_count = 4;//定义图片上传最大值（即：上传最多张数）
		//index 只是区分一下，比如页面有很多个上传控件时  就需要用到
		function ajaxFileUpload(index , fileObj,rentAllId) {
			if (addfileIds.length > max_view_count - 1) {
				alert("图片最多只能上传" + max_view_count + "张!");
				return false;
			}
			check(fileObj);
			$("#pre_tr").append("<td id='preview_td_"+pre_view_count+"'><div id='preview"+pre_view_count+"'></div></td>");
			//等待图片
			$(".wait" + index).show();
			$.ajaxFileUpload({
				url : 'uploadPic.do', //上传到哪里   这边只是测试，返回一个数字，具体业务逻辑需要去开发
				type : 'post',
				data : { dir : 'rent\\RentAll\\',rentAllId:rentAllId }, // 此参数非常严谨，写错一个引号都不行 , 图片保存的目录
				secureuri : false,
				fileElementId : 'picFile1', // /文件上传空间的id属性 <input type="file" id="file" name="file" />
				dataType : 'json', // 服务器返回的格式,可以是json或xml等
				success : function(data, status) { //相当于java中try语句块的用法
					
					$(".wait" + index).hide();
					$("#mid").hide();
					$(".delete_bt").show();
					var str = "del('" + data.picid + "'," + pre_view_count + ");";
					var imageStr = '<img style="cursor: pointer; " onclick='+ '"' +str +'"' +' src="../images/delete_icon.jpg" width="50" height="50" >';
										
					$(".delete_bt").append('<span id="'+data.picid+'">' + data.filename+ "&nbsp;" + imageStr + "</span><br/>");
					addfileIds.push(data.picid);
					pre_view_count++;//数组索引增加
				},
				error : function(data, status, e) { //相当于java中catch语句块的用法
					alert("上传失败");
					$('#attach' + index).html('添加失败');
				}
			});
		}
		
		function del(picid, img_view_index) {
			//需要自己 去java后台删除对应的附件数据 和 文件
			$.ajax({
				type : 'post',
				url : 'deletePic.do',
				dataType : 'json',
				data : { picid : picid}, // 此参数非常严谨，写错一个引号都不行 , 图片保存的目录
				success : function(data, status) { //相当于java中try语句块的用法
						
					addfileIds.removeObj(data.picid);
					alert(addfileIds.join());
					$("#preview_td_" + img_view_index).remove();
					
					alert(data.success);				
				},
				error : function(data, status, e) { //相当于java中catch语句块的用法
					alert("删除失败");
					$('#attach' + index).html('添加失败');
				}
			});
		}
		
		KE.show({
			 id : "editor",
		     width : "900px",
		     height : "380px",		    
		     resizeMode : 1,
		     allowFileManager : true,
		     /*图片上传的SERVLET路径*/
		     imageUploadJson : "${pageContext.request.contextPath}/uploadImage.html", 
		     /*图片管理的SERVLET路径*/
		     fileManagerJson : "${pageContext.request.contextPath}/uploadImgManager.html",
		     /*允许上传的附件类型*/
		     accessoryTypes : "doc|xls|pdf|txt|ppt|rar|zip",
		     /*附件上传的SERVLET路径*/
		     accessoryUploadJson : "${pageContext.request.contextPath}/uploadAccessory.html"
		});
		
		//表单提交
		function sub(rentId){
			var detail = document.getElementById("editor").value;
			$.ajax({
				type : 'post',
				url : 'updateRent.do',
				dataType : 'json',
				data : { detail : detail , rentId : rentId}, // 此参数非常严谨，写错一个引号都不行 , 图片保存的目录
				success : function(data, status) { //相当于java中try语句块的用法
					$(subresult ).html(data.success);
				},
				error : function(data, status, e) { //相当于java中catch语句块的用法
					$(subresult ).html(data.failure);
				}
			});
		}	
		//清楚成功标志
		function clearTips(){
			$(subresult ).html("");
			alert("ad");
		}
	</script>
</head>
<!-- 预览图片样式 -->
<style type="text/css">
<!--图片预览-->
#preview {width: 160px;height: 100px;border: 1px solid #000;overflow: hidden}
#imghead {filter: progid :   DXImageTransform.Microsoft.AlphaImageLoader ( sizingMethod =   image );}

<!--模块文件 -->
.all table { float: left;}
.all { border: solid 1px gray;height:110px; }
.all span { float: left; vertical-align: middle;}
.wait1 { float: left;width: 100px;height:100px;}
#mid{ position:absolute; top:10%;   left:20%;   margin:0 0 0 0;   float: left;}

</style>

<body>
	
	<div class="all">
		<span>图1.</span>
		<img class="wait1" id="wait1" src="../images/default.png" />
		<table>
			<tr id="pre_tr">
			</tr>
		</table>
		<div id="mid">
			 <input type="file" name="picFile" id="picFile1" onchange="ajaxFileUpload(1,this,${rentAll.id });previewImage(this);" style="height: 30px; width: 350px"/>
		</div>
		<div class="delete_bt" style="display:none; position:absolute; top:10%; left:30%; margin:0 0 0 0; float: left;">
			
		</div>
	</div>
	
	<form action="updateRent.do" name="myform" method="post" >
		<br />
		<br />
		详细描述：
		<textarea id="editor" onchange="alert('0');"   name="rentdescribe" style="margin-top: 10px">${rentAll.rentdescribe }</textarea><br />
		<div align="center">
				<font color="red"><span id="subresult"></span></font><br />
				<input type="reset" value="  重置   " />  
				<input type="button" name="submit"  value="  提交   "  onclick="sub(${rentAll.id });" />      
		</div>
	</form>
	<br>
	<br>
	
</body>

</html>
