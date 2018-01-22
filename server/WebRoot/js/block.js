<script type="text/javascript">

	function seltargetFunction() {
		$("#seltarget option[value!=0]").remove();
		var object = $("#selarea");
		if (object.val() != 0) {
			$.ajax({
				type : 'post',
				url : 'getTarget.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.name + "'>" + entry.name + "</option>";
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
				url : 'getFunction.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.name + "'>" + entry.name + "</option>";
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
				url : 'getPersonality.do',
				data : {
					id : object.val()
				},
				dataType : 'json',
				success : function(result) {
					$.each(result, function(entryIndex, entry) {
						var html = "<option value='" + entry.name + "'>" + entry.name + "</option>";
						$("#selpersonality").append(html);
					});
				}
			});
		}
	}
	
	function load(){
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
							alert('文件上传成功!');
							var next = $("#fileUpLoad").html();
							$("#fileUpLoad")
									.html(
											"<div id='"+json.fileid+"'>"
													+ "文件:"
													+ json.ori_filename
													+ "   <a href='#' onclick='filedelete("
													+ "\"" + json.fileid + "\"" + ","
													+ "\"" + json.filename + "\"" + ","
													+ "\"" + json.dir + "\""
													+ ")'>删除</a>"
													+ "<br/></div>");
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