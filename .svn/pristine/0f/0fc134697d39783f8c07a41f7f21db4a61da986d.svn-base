<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/11 0011
  Time: 下午 12:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/header.jsp"></jsp:include>
    <title>Title</title>
</head>
<body>
<jsp:include page="/common/nav.jsp"></jsp:include>

<div class="container-fluid" >
    <div class="row" >
        <div class="panel panel-primary" id="productListDIV">
            <div class="panel-heading">热销商品</div>

        </div>
    </div>
</div>
<div style="display: none;" id="productTemplate">
    <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
            <img src="http://localhost:8080/##image##" style="height: 200px;width: 200px">
            <div class="caption">
                <h3>##productName##</h3>
                <p><font color="red"> ##price##</font></p>
                <p><a href="#" class="btn btn-primary" role="button" onclick="addCart('##productId##');">添加到购物车</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    $(function () {
        initProductList();
    })
    function initProductList() {
        $.ajax({
            type:"get",
            url:"/product/hotlist.jhtml",
            success:function (data) {
                if (data.code == 200) {
                    var v_result = data.data;
                    for (var i = 0; i < v_result.length; i++) {
                        var v_template = $("#productTemplate").html();
                        var v_product = v_result[i];
                        var t = v_template.replace(/##image##/g, v_product.mainImagePath)
                            .replace(/##productName##/g, v_product.productName)
                            .replace(/##productId##/g, v_product.id)
                            .replace(/##price##/g, v_product.price);
                        $("#productListDIV").append(t);
                    }
                }
            }


        })
    }
</script>
</body>
</html>
