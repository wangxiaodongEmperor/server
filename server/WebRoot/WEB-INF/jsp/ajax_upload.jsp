<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" pageEncoding="UTF-8"%>
<% request.setAttribute("path",request.getContextPath()); %>

<html>
	<head>
		<title>ajax_upload.html</title>
		<!-- 注：jquery 必须放到ajaxfileupload.js前面来，否则使用不了 -->
		<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js"></script>
		<script type="text/javascript" src="${path}/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${path}/js/uploadPic.js"></script>
		<!-- 注：js数组的扩展函数 -->
		
	<script type="text/javascript">
		var addfileIds = [];//存储附件的ID
		var pre_view_count = 1;//预览元素索引初始值
		var max_view_count = 4;//定义图片上传最大值（即：上传最多张数）
		//index 只是区分一下，比如页面有很多个上传控件时  就需要用到
		function ajaxFileUpload(index , fileObj) {
			
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
				data : { dir : 'rent\\RentAll\\' }, // 此参数非常严谨，写错一个引号都不行 , 图片保存的目录
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
			//需要自己 去java后台删除对应的附件数据 和 文件\
			alert(filename);
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
	</script>
</head>
<!-- 预览图片样式 -->
<style type="text/css">
<!--图片预览-->
#preview {width: 160px;height: 100px;border: 1px solid #000;overflow: hidden}
#imghead {filter: progid :   DXImageTransform.Microsoft.AlphaImageLoader ( sizingMethod =   image );}

<!--模块文件 -->
.all {border: solid 1px black;height:110px; }
.all table {float: left;}
.wait1 {float: left;width: 100px;height:100px;}
#mid{position:absolute; top:10%;   left:20%;   margin:0 0 0 0;   float: left;}

</style>

<body>
	请上传相关的图片：
	<div class="all">
		<img class="wait1" id="wait1" src="../images/default.png" />
		<table>
			<tr id="pre_tr">
			</tr>
		</table>
		<div  id="mid">
			 <input type="file" name="picFile" id="picFile1" onchange="ajaxFileUpload(1,this);previewImage(this);" style="height: 30px; width: 350px"/>
		</div>
		<div class="delete_bt" style="display:none; position:absolute; top:10%; left:30%; margin:0 0 0 0; float: left;">
			
		</div>
	</div>  
</body>

</html>
