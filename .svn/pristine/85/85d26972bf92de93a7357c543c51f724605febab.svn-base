<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/27 0027
  Time: 下午 16:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/header.jsp"></jsp:include>
    <title>日志管理</title>
</head>
<body>
<jsp:include page="/common/nav.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">日志查询</div>
                <form class="form-horizontal" id="productForm">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="userName" name="userName" placeholder="请输入用户名...">
                        </div>
                        <label class="col-sm-2 control-label">日期范围</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="minCreateDate" name="minCreateDate">
                                <span class="input-group-addon">
                                    <i class="glyphicon glyphicon-calendar"></i>
                            </span>
                                <input type="text" class="form-control" id="maxCreateDate" name="maxCreateDate">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-4">
                            <select id="statusSelect" class="form-control">
                                <option value="-1">===请选择===</option>
                                <option value="0">失败</option>
                                <option value="1">成功</option>
                            </select>
                        </div>

                        <label class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="content" name="content" placeholder="请输入内容...">
                        </div>

                    </div>
                    <div style="text-align: center;">
                        <button type="button" class="btn btn-primary" onclick="search();"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
                        <button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>重置</button>
                    </div>

                </form>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">日志列表</div>
                <table id="productTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr >
                        <th>用户名</th>
                        <th>内容</th>
                        <th>状态</th>
                        <th>日期</th>
                        <th>详细信息</th>
                    </tr>
                    </thead>

                    <tfoot>
                    <tr >
                        <th>用户名</th>
                        <th>内容</th>
                        <th>状态</th>
                        <th>日期</th>
                        <th>详细信息</th>
                    </tr>
                    </tfoot>
                </table>
            </div>

        </div>
    </div>
</div>


<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    $(function() {
        initDate();
        initLogTable();
    })

    function search() {
        // 获取参数信息
        var v_userName = $("#userName").val();
        var v_minCreateDate = $("#minCreateDate").val();
        var v_maxCreateDate = $("#maxCreateDate").val();
        var v_status = $("#statusSelect").val();
        var v_content = $("#content").val();
        // 传递参数
        var v_param = {};
        v_param.userName = v_userName;
        v_param.minCreateDate = v_minCreateDate;
        v_param.maxCreateDate = v_maxCreateDate;
        v_param.status = v_status;
        v_param.content = v_content;
        logTable.settings()[0].ajax.data = v_param;
        logTable.ajax.reload();
    }

    var logTable;
    function initLogTable() {
        logTable = $('#productTable').DataTable({
            "processing": true,
            "serverSide": true,
            "lengthMenu": [10, 20, 30],
            // 是否允许检索
            "searching": false,
            "ajax": {
                url:"<%=request.getContextPath()%>/log/logdata.jhtml",
                type:"post"
            },
            "language": {
                "url": "/js/DataTables/Chinese.json"

            },

            "columns": [

                { "data": "userName" },
                {"data": "content"},
                {
                    "data": "status",
                    "render": function (data, type, row, meta) {
                        if (data == 0) {
                            return "失败";
                        } else {
                            return "成功";
                        }
                    }
                },
                { "data": "createDate" },
                { "data": "detailInfo" }
            ]
        });
    }

    function initDate() {
        $('#minCreateDate').datetimepicker({
            format: 'YYYY-MM-DD HH:00:00',
            locale: 'zh-CN',
            showClear: true
        });

        $('#maxCreateDate').datetimepicker({
            format: 'YYYY-MM-DD HH:00:00',
            locale: 'zh-CN',
            showClear: true
        });
    }
</script>
</body>
</html>
