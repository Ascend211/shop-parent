<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/27 0027
  Time: 上午 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">飞狐电商后台管理</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
            <ul class="nav navbar-nav" id="menuItems">
                <li class="active" id="item_1"><a href="/product/toList.jhtml#1">商品管理 <span class="sr-only">(current)</span></a></li>
                <li id="item_2" class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">品牌管理<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/brand/index.jhtml#2">品牌列表</a></li>
                        <li><a href="/brand/toAdd.jhtml#2">品牌添加</a></li>
                    </ul>

                </li>
                <li id="item_3"><a href="#">分类管理</a></li>
                <li id="item_4"><a href="/log/index.jhtml#4">日志管理</a></li>
                <li id="item_5"><a href="/area/index.jhtml#5" >地区管理</a></li>
                <li id="item_6"><a href="/user/toAdd.jhtml#6">用户管理</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="#">欢迎${user.realName}登录<c:if test="${!empty user.loginTime}">
                    ，您上次登录时间<fmt:formatDate value="${user.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </c:if></a> </li>
                <li><a href="#" onclick="logout();">退出</a> </li>
            </ul>

        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<script type="text/javascript" src="/js/jquery-3.3.1.js"></script>
<script>
    function logout() {
        $.ajax({
            type:"get",
            url:"/user/logout.jhtml",
            success:function (data) {
                if (data.code == 200) {
                    location.href = "/";
                }
            }
        })
    }

    $(function () {
        initMenuItem();
        // 全局设置
        $.ajaxSetup( {
            //设置ajax请求结束后的执行动作
            complete :
                function(XMLHttpRequest, textStatus) {
                    var responseJSON = XMLHttpRequest.responseJSON;
                    console.log(responseJSON);
                    var responseHeader = XMLHttpRequest.getResponseHeader("ajaxTimeout");
                    // alert(responseHeader+":"+XMLHttpRequest.status);
                    if (XMLHttpRequest.status == 400 && responseHeader == "timeout") {
                        window.location.href="/";
                    }
                }
        });
    })
    
    function initMenuItem() {
        var hash = window.location.hash;
        if (hash.length > 0) {
            hash = hash.substring(1);
            // 清除其他的选中项
            $("#menuItems > li").removeClass("active");
            $("#item_"+hash).addClass("active");
        }
    }









</script>