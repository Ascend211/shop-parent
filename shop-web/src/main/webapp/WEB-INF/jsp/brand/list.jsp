<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/9 0009
  Time: 下午 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/header.jsp"/>
    <title>品牌列表</title>
</head>
<body>
<jsp:include page="/common/nav.jsp"/>
<div class="container-fluid">
    <div class="row">
    <div class="col-md-12">
        <div class="panel panel-info">
            <div class="panel-heading">品牌列表</div>
            <table id="brandTable" class="table table-striped table-bordered" style="width:100%">
                <thead>
                <tr >
                    <th>选择</th>
                    <th>品牌名</th>
                    <th>logo</th>
                    <th>是否推荐</th>
                    <th>排序</th>
                </tr>
                </thead>

                <tfoot>
                <tr>
                    <th>选择</th>
                    <th>品牌名</th>
                    <th>logo</th>
                    <th>是否推荐</th>
                    <th>排序</th>
                </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
</div>
<jsp:include page="/common/script.jsp"/>
<script>
   $(function () {
       initBrandTable();
   })

   function search() {
       brandTable.ajax.reload();
   }
    var brandTable;
    function initBrandTable() {
        brandTable = $('#brandTable').DataTable({
            "processing": true,
            "serverSide": true,
            "lengthMenu": [5, 10, 20],
            // 是否允许检索
            "searching": false,
            "ajax": {
                url:"<%=request.getContextPath()%>/brand/list.jhtml",
                type:"post"
            },
            "language": {
                "url": "/js/DataTables/Chinese.json"

            },

            "columns": [
                {
                    "data":"id",
                    "render": function (data, type, row, meta) {
                        return "<input type='checkbox' name='ids' value='"+data+"'/>";
                    }
                },
                { "data": "brandName" },
                {"data":"logo",
                    "render": function (data, type, row, meta) {
                        return "<img src='"+data+"' width='100px' height='100px'/>";
                    }
                },
                {"data":"isRecommend",
                    "render": function (data, type, row, meta) {

                        return data=='1'?'<button type="button" class="btn btn-primary" onclick="updateStatus(\''+data+'\', \''+row.id+'\');">推荐</button>':"<button type=\"button\" class=\"btn btn-default\" onclick=\"updateStatus(\'"+data+"\', \'"+row.id+"\');\">推荐</button>"
                    }
                },
                { "data": "orderPos" }
            ]
        });
    }
    
    function updateStatus(status, id) {
        var v_status = status==1?0:1;

        $.ajax({
            type:"post",
            data:{"id":id,"status":v_status},
            url:"/brand/updateStatus.jhtml",
            success:function (result) {
                if (result.code == 200) {
                    search();
                }
            }
        })
    }
</script>
</body>
</html>
