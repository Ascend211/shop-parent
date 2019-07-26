<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/17 0017
  Time: 上午 10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
</head>
<body>
<form >
    用户名:<input type="text" id="userName"/>
    密码:<input type="password" id="userPwd"/>
    验证码:<input type="text" id="code"/><img src="/fh/code" id="codeImage"/><a href="#" onclick="refreshCode();">看不清换一张</a>
    <input type="button" value="登录" onclick="login();"/>
    <input type="reset" value="重置">
</form>
<script src="/js/jquery-3.3.1.js"></script>
<script src="/js/md5.js"></script>
<script>
    function refreshCode() {
        var t = new Date().getTime();
        $("#codeImage").attr("src", "/fh/code?"+t);

    }
    
    function login() {
        var v_userName = $("#userName").val();
        var v_userPwd = $("#userPwd").val();
        var v_imageCode = $("#code").val();
        var md5pwd = hex_md5(v_userPwd);
        $.ajax({
            type:"post",
            url:"/user/login.jhtml",
            data:{"userName":v_userName, "userPwd":md5pwd, "imageCode":v_imageCode},
            success:function (data) {
                if (data.code == 200) {
                    // 跳转
                    location.href = "/product/toList.jhtml";
                } else {
                    alert(data.msg);
                }
            }
        })
    }
</script>
</body>
</html>
