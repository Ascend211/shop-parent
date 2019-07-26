<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/5 0005
  Time: 下午 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/header.jsp"/>
    <title>品牌增加</title>
</head>
<body>
<jsp:include page="/common/nav.jsp"/>

<form class="form-horizontal">
    <div class="form-group">
        <label  class="col-sm-2 control-label">品牌名</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="brandName" placeholder="请输入品牌名...">
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">logo</label>
        <div class="col-sm-4">
            <input type="file" name="imageInfo" id="logoImage">
            <input type="text" id="logoImagePath"/>
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">是否推荐</label>
        <div class="col-sm-4">
            <input type="radio" name="isRem" value="1">是
            <input type="radio" name="isRem" value="0">否
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">排序</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="orderPos" >
        </div>
    </div>
    <div style="text-align: center;">
        <button type="button" class="btn btn-primary" onclick="addBrand();" id="saveUserButton" ><span class="glyphicon glyphicon-search" aria-hidden="true"></span>添加</button>
        <button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>重置</button>
    </div>
</form>


<jsp:include page="/common/script.jsp"/>
<script>

    $(function () {
        initLogoImage();
    })

function initLogoImage() {
        var s = {
            language: 'zh',
            uploadUrl: "/file/uploadImage.jhtml",
            dropZoneEnabled: false,//是否显示拖拽区域
            showUpload : false,
            showRemove : false,
            allowedFileExtensions : [ 'jpg', 'png', 'jpeg', 'gif'] //上传的文件的后缀名
        };



        $("#logoImage").fileinput(s).on("fileuploaded", function(event, t, previewId, index) {
            var data = t.response;
            if (data.code == 200) {
                $("#logoImagePath").val(data.data);
            }
        });;
    }
function addBrand() {
    var v_brandName = $("#brandName").val();
    var v_logoPath = $("#logoImagePath").val();
    var v_isRem = $("input[name='isRem']:checked").val();
    var v_orderPos = $("#orderPos").val();
    $.ajax({
        type:"post",
        data:{"brandName":v_brandName,"isRecommend":v_isRem,"logo":v_logoPath,"orderPos":v_orderPos},
        url:"/brand/add.jhtml",
        success:function (data) {
            if (data.code == 200) {
                alert("增加成功");
            }
        }
    })
}
</script>
</body>
</html>
