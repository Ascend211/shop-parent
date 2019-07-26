<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/20 0020
  Time: 上午 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="/js/bootstrap3/css/bootstrap.min.css">
    <title>添加用户</title>
</head>
<body>
<form class="form-horizontal">
    <div class="form-group">
        <label  class="col-sm-2 control-label">用户名</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="userName" placeholder="请输入用户名..." onblur="checkUserName(this.value);">
            <span id="userNameTip"></span>
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">密码</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="userPwd" placeholder="请输入密码...">
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-2 control-label">确认密码</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="userConfirmPwd" placeholder="请再次输入密码...">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label">真实姓名</label>
        <div class="col-sm-4">
            <input type="text" class="form-control" id="realName" placeholder="请输入真实姓名...">
        </div>
    </div>
    <div style="text-align: center;">
        <button type="button" class="btn btn-primary" onclick="saveUser();" id="saveUserButton" ><span class="glyphicon glyphicon-search" aria-hidden="true"></span>添加</button>
        <button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>重置</button>
    </div>
</form>


<script src="/js/jquery-3.3.1.js"></script>
<script src="/js/bootstrap3/js/bootstrap.min.js"></script>

<script>
    function checkUserName(userName) {
        if (userName.length > 0) {
            // 发送ajax请求
            $.ajax({
                type:"post",
                data:{"userName":userName},
                url:"/user/checkUserName.jhtml",
                success:function (data) {
                    if (data.code != 200) {
                        // 提示用户名已经存在
                        $("#userNameTip").html("<font color='red'><b>用户名已存在</b></font>");
                        // 禁用按钮
                        $("#saveUserButton").attr("disabled", "disabled");
                    } else {
                        // 还原
                        $("#userNameTip").html("");
                        $("#saveUserButton").removeAttr("disabled");
                    }
                }

            })
        } else {
            alert("请输入用户名");
        }
    }
    
    function saveUser() {
        var v_param = {};
        var v_userName = $("#userName").val();
        var v_userPwd = $("#userPwd").val();
        var v_realName = $("#realName").val();

        v_param.userName = v_userName;
        v_param.userPwd = v_userPwd;
        v_param.realName = v_realName;


        $.ajax({
            type:"post",
            data:v_param,
            url:"http://192.168.0.150:8082/api/member/reg.jhtml",
            success:function (data) {
                if (data.code == 200) {
                    alert("添加成功");
                     // 跳转页面

                } else {
                    // 错误提示

                }
            }
        })
    }
</script>
</body>
</html>
