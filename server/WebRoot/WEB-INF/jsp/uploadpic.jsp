<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("path",request.getContextPath()); %>

<html>
	<head>
		<script type="text/javascript" src="${path}/js/jquery-1.5.1.min.js"></script>
		<script type="text/javascript" src="${path}/js/ajaxfileupload.js"></script>
	
	<script type="text/javascript">
    function IsRepeat(obj) {
        var filters = "jpg png bmp jpeg gif";

        var val = $(obj).val();
        var arr = val.split('.');
        if (filters.indexOf(arr[arr.length - 1]) < 0) {
            $(obj).val("");
            alert("请上传 " + filters + " 格式的图片", "提示");
            return;
        }
        var count = 0;
        $("input[name='upload']").each(function () {
            if ($(this).val()) {
                if ($(this).val() == val) {
                    if (count >= 1) {
                        $(this).val("");
                        alert("已上传该图片，请重新选择！", "提示");
                        return;
                    }
                    count++;
                }
            }
        })
    }

    function deleteImage(val) {
        if (confirm("是否删除图片？")) {
            falg = false;
            var id = "#del_" + val;
            $(id).parent().remove();
            id = "#image_" + val;
            $(id).parent().remove();
            $("#trimagedivAft").closest("td").before("<td style=\"width:25%\"><input style=\"width:100px;height:80px;display:none\" type=\"image\" src=\"#\"></td>");
            $("#footerimagedivAft").closest("td").before("<td class='footertd' style=\"text-align:center;width:25%\"><div style=\"display:none\"><a href=\"#\">删除</a></div></td>");
        }
    }

    function addfile(obj, maxNum) {
        $(obj).closest("tr").before("  <tr class=\"tr\"><td width=\"80%\"><input name=\"upload\" type=\"file\" onchange=\"IsRepeat(this)\" style=\"width:100%;\" /></td><td width=\"20%\"><input type=\"button\" value=\"删除\" onclick=\"deletefile(this," + maxNum + ");\" /> </td></tr>");
        //检测是否已经到达最大的个数，需要隐藏添加按钮
        if (maxNum > 0) {
            if ($(obj).closest("table").children().children(".tr").length == maxNum) {
                $(obj).hide();
            }
        }
        return false;
    }

    function deletefile(obj, maxNum) {
        //检测是否已经到达最大的个数，需要隐藏添加按钮
        if (maxNum > 0) {
            var inputAdd = $(obj).closest("table").children().children(".footTr").children().children("input");
            var num = $(obj).closest("table").children().children(".tr").length;
            $(obj).closest("tr").remove();
            if ((num - 1) < maxNum) {
                inputAdd.show(); //定位到添加按钮
            }
        }
        else {
            $(obj).closest("tr").remove();
        }
        return false;
    }
    
    
    var falg = false;
    var countFalg = 0;
    function uploadFile() {
        var falg = true;
        $("input[name='upload']").each(function () {
            if ($(this).val() == "") {
                falg = false;
            }
        })

        if (!falg) {
            alert("上传图片不能为空", "提示");
            return;
        }
        $.ajaxFileUpload({
            url: "uploadPic.do",
            type : 'post',
    		data : { dir : 'rent/RentAll' }, // 此参数非常严谨，写错一个引号都不行 , 图片保存的目录
            secureuri: false,
            fileElementId: 'myBlogImage',//修改了ajaxFileUpload.js源码，支持上传多个name相同的文件，修改处在45行~57行
            dataType: 'json',
            success: function (data, status) {
                
                //alert(data['status'] + '-----' + data['fileName'] + '-----' + data['extName']);
                if (data != null) {
                    var returnValue = data['filePath'];
                    if (returnValue) {

                        var array = returnValue.split('|');
                        var retLen = array.length;
                        var ss = "";
                        for (var i = 0; i < array.length; i++) {
                            if (array[i]) {
                                var len = $("#trimagedivAft").closest("tr").children(".td").length;
                                var ran = Math.ceil(Math.random() * 9999999999999999);
                                var fp = "";

                                fp = "uploadPic.do" + "?filePath=" + array[i].split(',')[0];
                                    if (!falg) {
                                        $("#trimagedivAft").parent().prev().remove();
                                        $("#footerimagedivAft").parent().prev().remove();
                                        $("#trimagedivBef").closest("td").after("<td class='td' style=\"width:25%\"><input width='100px' id='image_" + ran + "' height='80px' value=" + array[i] + "  src=" + fp + " type=\"image\"/></td>");

                                        $("#footerimagedivBef").closest("td").after("<td class='footertd' style=\"text-align:center;width:25%\"><div onclick='deleteImage(" + ran + ")'  id='del_" + ran + "'><a href=\"#\">删除</a></div></td>");
                                    } else {
                                        $("#trimagedivBef").parent().next().remove();
                                        $("#footerimagedivBef").parent().next().remove();
                                        $("#trimagedivAft").closest("td").before("<td class='td' style=\"width:25%\"><input width='100px' id='image_" + ran + "' height='80px' value=" + array[i] + " src=" + fp + " type=\"image\"/></td>");
                                        $("#footerimagedivAft").closest("td").before("<td class='footertd' style=\"text-align:center;width:25%\"><div onclick='deleteImage(" + ran + ")' id='del_" + ran + "'><a href=\"#\">删除</a></div></td>");
                                    }
                                    countFalg++;
                                    if (countFalg >= 4) {
                                        falg = true;
                                    }
                                }

                            }
                        }
                    }
                },
            error: function (data, status, e) {
                //alert(e);
                alert("上传失败");
                return false;
            }
        })
    }
	
</script>
	</head>

	<body style="background: #FFFFFF;">
		<form action="uploadPic.do" id="form1" name="form1" method="post">
			<table style="width: 100%" class="SubTable">
				<tbody>
					<tr class="tr">
						<td style="width: 80%">
							<input id="myBlogImage" name="myfiles" type="file" onchange="IsRepeat(this)" style="width: 100%" />
						</td>
						<td style="width: 20%">
							<input type="button" value="删除" onclick="deletefile(this, 4)" />
						</td>
					</tr>
					<tr class="footTr">
						<td colspan="2">
							<input type="button" value="添加" onclick="addfile(this, 4)" />
						</td>
					</tr>
					<tr>
						<td style="text-align: center" colspan="2">
							<input type="button" value="提交" id="BtnSub" onclick="uploadFile()"/>
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tr>
					<td style="height: 130px; width: 18%">
						图片预览:
					</td>
					<td style="height: 130px; width: 82%">
						<table style="width: 100%" class="SubTable">
							<tbody>
								<tr class="tr">
									<td>
										<div id="trimagedivBef" style="display: none"></div>
									</td>
									<td style="width: 25%">
										<input style="width: 100px; height: 80px; display: none"
											type="image">
									</td>
									<td style="width: 25%">
										<input style="width: 100px; height: 80px; display: none"
											type="image">
									</td>
									<td style="width: 25%">
										<input style="width: 100px; height: 80px; display: none"
											type="image">
									</td>
									<td style="width: 25%">
										<input style="width: 100px; height: 80px; display: none"
											type="image">
									</td>
									<td>
										<div id="trimagedivAft" style="display: none"></div>
									</td>
								</tr>
								<tr class="footer">
									<td>
										<div id="footerimagedivBef" style="display: none"></div>
									</td>
									<td class='footertd' style="width: 25%">
										<div style="display: none">
											<a href="#">删除</a>
										</div>
									</td>
									<td class='footertd' style="width: 25%">
										<div style="display: none">
											<a href="#">删除</a>
										</div>
									</td>
									<td class='footertd' style="width: 25%">
										<div style="display: none">
											<a href="#">删除</a>
										</div>
									</td>
									<td class='footertd' style="width: 25%">
										<div style="display: none">
											<a href="#">删除</a>
										</div>
									</td>
									<td style="text-align: center">
										<div id="footerimagedivAft" style="display: none"></div>
									</td>
								</tr>

							</tbody>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>