<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/header.jsp"></jsp:include>
    <title>商品列表</title>
</head>
<body>
<jsp:include page="/common/nav.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">商品查询</div>
                <form class="form-horizontal" id="productForm">
                    <input type="text" name="gc1" id="gc1">
                    <input type="text" name="gc2" id="gc2">
                    <input type="text" name="gc3" id="gc3">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">产品名</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="productName" name="productName" placeholder="请输入产品名...">
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
                        <label class="col-sm-2 control-label">价格区间</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="form-control" id="minPrice" name="minPrice">
                                <span class="input-group-addon">
                                    ¥
                                </span>
                                <input type="text" class="form-control" id="maxPrice" name="maxPrice">
                            </div>
                        </div>

                        <label class="col-sm-2 control-label">品牌</label>
                        <div class="col-sm-4">
                            <select id="brandSelect" class="form-control" name="brandId">
                                <option value="-1">===请选择===</option>
                            </select>
                        </div>

                    </div>
                    <div class="form-group" id="categorySelectDiv">
                        <label  class="col-sm-2 control-label">分类</label>

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
            <div style="text-align: left;background: #2aabd2;">
                <button type="button" class="btn btn-primary" onclick="showAddProductDlg();"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加</button>
                <button type="button" class="btn btn-danger" onclick="batchDelete();"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>批量删除</button>
                <button type="button" class="btn btn-success" onclick="exportExcel();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Excel</button>
                <button type="button" class="btn btn-success" onclick="exportPdf();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Pdf</button>
                <button type="button" class="btn btn-success" onclick="exportWord();"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>导出Word</button>
                <button type="button" class="btn btn-success" onclick="importExcel();"><span class="glyphicon glyphicon-upload" aria-hidden="true"></span>导入Excel</button>
                <button type="button" class="btn btn-success" onclick="refreshProductCache();"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>刷新商品缓存</button>

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">商品列表</div>
                <table id="productTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr >
                        <th>选择</th>
                        <th>产品名</th>
                        <th>状态</th>
                        <th>主图</th>
                        <th>品牌名</th>
                        <th>产品价格</th>
                        <th>日期</th>
                        <th>分类</th>
                        <th>热销</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tfoot>
                    <tr>
                        <th>选择</th>
                        <th>产品名</th>
                        <th>状态</th>
                        <th>主图</th>
                        <th>品牌名</th>
                        <th>产品价格</th>
                        <th>日期</th>
                        <th>分类</th>
                        <th>热销</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>

        </div>
    </div>
</div>

<!-- 商品的添加 -->
<div id="addProductDiv" style="display: none;">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">产品名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_productName" placeholder="请输入产品名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-4">
               <select id="add_brandSelect" class="form-control">
                    <option value="-1">===请选择===</option>
               </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">价格</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_price" placeholder="请输入价格">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">日期</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="add_createDate" placeholder="请输入日期">
            </div>
        </div>
        <div class="form-group" id="categoryDiv">
            <label class="col-sm-2 control-label">分类</label>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销</label>
            <div class="col-sm-4">
                <input type="radio" name="add_isHot" value="1">是
                <input type="radio" name="add_isHot" value="0">否
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">主图</label>
            <div class="col-sm-5">
                <input type="file" name="imageInfo" id="mainImage">
                <input type="text" id="add_mainImagePath"/>
            </div>
        </div>
    </form>
</div>


<!-- 商品的修改 -->
<div id="updateProductDiv" style="display: none;">
    <form class="form-horizontal">
        <input type="text" id="productId"/>
        <div class="form-group">
            <label  class="col-sm-2 control-label">产品名</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_productName" placeholder="请输入产品名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-4">
                <select id="update_brandSelect" class="form-control">
                    <option value="-1">===请选择===</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">价格</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_price" placeholder="请输入价格">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">日期</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" id="update_createDate" placeholder="请输入日期">
            </div>
        </div>
        <div class="form-group" id="update_categoryDiv">
            <label class="col-sm-2 control-label" id="categoryLable">分类</label>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销</label>
            <div class="col-sm-4">
                <input type="radio" name="update_isHot" value="1">是
                <input type="radio" name="update_isHot" value="0">否
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">主图</label>
            <div class="col-sm-5">
                <input type="file" name="imageInfo" id="update_mainImage">
                <input type="text" id="update_OldmainImagePath"/>
                <input type="text" id="update_mainImagePath"/>
            </div>
        </div>
    </form>
</div>

<div id="importExcelDiv" style="display: none;">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-md-2 control-label">Excel文件</label>
            <div class="col-md-6">
                <input type="file" class="form-control" name="uploadFileInfo" id="excelFile">
                <input type="text" class="form-control"  id="excelPath">

            </div>
        </div>
    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>
<script type="text/javascript">

    var v_addProductSource;
    var v_updateProductSource;
    var v_importExcelSource;

    var v_importExcelDialog;
    function importExcel() {
         v_importExcelDialog = bootbox.dialog({
            title: '导入Excel',
            message: $("#importExcelDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-primary',
                    callback: function(){
                        var v_path = $("#excelPath", v_importExcelDialog).val();
                        $.ajax({
                            type:"post",
                            url:"/product/importProductExcel.jhtml",
                            data:{"path":v_path},
                            success:function (data) {
                                if (data.code == 200) {
                                    // 刷新
                                    search();
                                }
                            }
                        })
                    }
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger'
                }
            }
        });
        // 还原
        $("#importExcelDiv").html(v_importExcelSource);
        initExcelFileInput();
    }
    
    function initExcelFileInput() {
        var s = {
            language: 'zh',
            uploadUrl: "/file/uploadFile.jhtml",
            showUpload : false,
            showRemove : false,
            allowedFileExtensions : [ 'xls', 'xlsx'] //上传的文件的后缀名
        };

        $("#excelFile").fileinput(s).on("fileuploaded", function(event, t, previewId, index) {
            var data = t.response;
            if (data.code == 200) {
                $("#excelPath", v_importExcelDialog).val(data.data);
            }
        });
    }

    function initMainImage() {
        var s = {
            language: 'zh',
            uploadUrl: "/file/uploadImage.jhtml",
            showUpload : false,
            showRemove : false,
            allowedFileExtensions : [ 'jpg', 'png', 'jpeg', 'gif'] //上传的文件的后缀名
        };



        $("#mainImage").fileinput(s).on("fileuploaded", function(event, t, previewId, index) {
            var data = t.response;
            if (data.code == 200) {
                $("#add_mainImagePath", v_addProductDialog).val(data.data);
            }
        });;
    }


    function initEditMainImage(imageArr) {
        var s = {
            language: 'zh',
            uploadUrl: "/file/uploadImage.jhtml",
            showUpload : false,
            showRemove : false,
            initialPreview:imageArr,
            initialPreviewAsData: true,
            allowedFileExtensions : [ 'jpg', 'png', 'jpeg', 'gif'] //上传的文件的后缀名
        };



        $("#update_mainImage").fileinput(s).on("fileuploaded", function(event, t, previewId, index) {
            var data = t.response;
            if (data.code == 200) {
                $("#update_mainImagePath", v_updateProductDialog).val(data.data);
            }
        });;
    }


    
    function exportExcel() {
        // 获取form表单
        var v_productForm = document.getElementById("productForm");
        // 动态设置action属性
        v_productForm.action = "/product/exportExcel.jhtml";
        v_productForm.method = "post";
        setGCInfo();
        v_productForm.submit();

    }

    function exportPdf() {
        // 获取form表单
        var v_productForm = document.getElementById("productForm");
        // 动态设置action属性
        v_productForm.action = "/product/exportPdf.jhtml";
        v_productForm.method = "post";

        setGCInfo();
        v_productForm.submit();
    }

    function setGCInfo() {
        var v_gc1 = $($("select[name='categorySelect']",$("#productForm"))[0]).val();
        var v_gc2 = -1;
        var v_gc3 = -1;
        if ($("select[name='categorySelect']",$("#productForm"))[1]) {
            v_gc2 = $($("select[name='categorySelect']",$("#productForm"))[1]).val();
        }
        if ($("select[name='categorySelect']",$("#productForm"))[2]) {
            v_gc3 = $($("select[name='categorySelect']",$("#productForm"))[2]).val();
        }
        $("#gc1").val(v_gc1);
        $("#gc2").val(v_gc2);
        $("#gc3").val(v_gc3);
    }

    function exportWord() {
        // 获取form表单
        var v_productForm = document.getElementById("productForm");
        // 动态设置action属性
        v_productForm.action = "/product/exportWord.jhtml";
        v_productForm.method = "post";
        setGCInfo();
        v_productForm.submit();
    }



    $(function() {
        // 获取添加产品div中的内容，备份
        v_addProductSource = $("#addProductDiv").html();
        v_updateProductSource = $("#updateProductDiv").html();
        v_importExcelSource = $("#importExcelDiv").html();
        // 初始化productTable
        initProductTable();
        // 初始化excel上传
        initExcelFileInput();
        // 初始化日期插件
        initDate();
        // 初始化添加商品中的日期控件
        initAddProductDate();
        initUpdateProductDate();
        // 初始化品牌列表
        initBrandList("add_brandSelect");
        initBrandList("update_brandSelect");
        initBrandList("brandSelect");
        // 初始化绑定事件
        initBindEvent();
        // 初始化查询时候的分类
        initCategory('categorySelectDiv', 0);
        // 初始化主图
        initMainImage();
    })

    var v_buttonFlag = 0;

    function edit_category(categoryName) {
        if (v_buttonFlag == 0) {
            // 清空分类名的label
            $("#categoryNameLabel").remove();
            // 改变按钮文字
            $("#cateButtonText").html("取消编辑");
            // 改变标志位
            v_buttonFlag = 1;
            // 添加下拉框
            initCategory('update_categoryDiv', 0);
        } else {
            // 删除所有的分类下拉列表
            $("#update_categoryDiv div", v_updateProductDialog).remove();
            // 改变按钮文字
            $("#cateButtonText").html("编辑");
            // 回填标签
            //$("#update_categoryDiv", v_updateProductDialog).append("<label class='col-sm-4 control-label' id='categoryNameLabel'>"+categoryName+"</label>");
            // append是在指定元素 内部的所有元素的后面 追加。
            // after是在指定元素的 后面 追加。
            $("#categoryLable", v_updateProductDialog).after("<label class='col-sm-4 control-label' id='categoryNameLabel'>"+categoryName+"</label>");
            // 重置标志位
            v_buttonFlag = 0;
        }
    }

    function initCategory(elementName, cateId, obj) {
        if (obj) {
            // 找到父级div的之后的同级元素进行删除
            $(obj).parent().nextAll().remove();
            // 动态给下拉列表添加属性
            $(obj).attr("data-categoryName", obj.options[obj.selectedIndex].text);
        }
        $.ajax({
            type:"post",
            url:"/category/findChildCategoryList.jhtml",
            data:{"id":cateId},
            success:function (data) {
                if (data.code == 200) {
                    if (data.data.length == 0) {
                        return;
                    }
                    // 在指定的div中追加select
                    var v_select = '<div class="col-sm-2"><select class="form-control" name="categorySelect" onchange="initCategory(\''+elementName+'\', this.value, this)"><option value="-1">==请选择==</option>';
                    var v_cateArr = data.data;
                    for (var i = 0; i < v_cateArr.length; i++) {
                        v_select += "<option value='"+v_cateArr[i].id+"' data-categoryName='"+v_cateArr[i].categoryName+"'>"+v_cateArr[i].categoryName+"</option>";
                    }
                    v_select += "</select></div>";
                    if (elementName == "categorySelectDiv") {
                        $("#"+elementName).append(v_select);
                    } else if (elementName == "categoryDiv") {
                        $("#"+elementName, v_addProductDialog).append(v_select);
                    } else if (elementName == "update_categoryDiv") {
                        $("#"+elementName, v_updateProductDialog).append(v_select);
                    }

                }
            }
        })
    }
    
    function batchDelete() {
        // 先判断是否选中了要删除的数据
        if (ids.length > 0) {
            bootbox.confirm({
                message: "你确定删除吗?",
                size: 'small',
                title: "提示信息",
                buttons: {
                    confirm: {
                        label: '<span class="glyphicon glyphicon-ok"></span>确定',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '<span class="glyphicon glyphicon-remove"></span>取消',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if (result) {
                        // 删除
                        $.ajax({
                            type:"post",
                            url:"/product/deleteBatch.jhtml",
                            data:{"ids":ids},
                            success:function (r) {
                                if (r.code == 200) {
                                    // 清空ids数组
                                    ids = [];
                                    // 刷新
                                    search();
                                } else {
                                    bootbox.alert({
                                        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>操作错误",
                                        size: 'small',
                                        title: "提示信息"
                                    });
                                }
                            }
                        })
                    }
                }
            })
        } else {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-exclamation-sign'></span>请选择要删除的数据",
                size: 'small',
                title: "提示信息"
            });
        }
    }
    var ids = [];
    function initBindEvent() {
        // 动态绑定事件【当元素是 动态生成 的则使用动态绑定事件】
        $("#productTable tbody").on("click", "tr", function () {
            // 当前tr对应的jquery对象
            var v_checkbox = $(this).find("input[type='checkbox']")[0];
            if (v_checkbox.checked) {
                // 取消选中，取消背景色
                $(this).css("background-color", "");
                v_checkbox.checked = false;
                // 从数组中删除指定id
                deleteId(v_checkbox.value);
            } else {
                // 选中，改变背景色
                $(this).css("background-color", "blue");
                v_checkbox.checked = true;
                // 将选中行的唯一标识存入数组中
                ids.push(v_checkbox.value);
            }

        })

    }

    function deleteId(id) {
        for (var i = ids.length-1; i >= 0; i--) {
            if (ids[i] == id) {
                ids.splice(i, 1);
            }
        }
    }

    function initBrandList(elementId) {
        $.ajax({
            "url":"/brand/findAll.jhtml",
            "type":"post",
            "success":function (result) {
                if (result.code == 200) {
                   var v_brandList = result.data;
                   var info = "";
                   for (var i = 0; i < v_brandList.length; i++) {
                       info += "<option value='"+v_brandList[i].id+"'>"+v_brandList[i].brandName+"</option>";
                   }
                   $("#"+elementId).append(info);

                } else {
                    bootbox.alert({
                        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>操作错误",
                        size: 'small',
                        title: "提示信息"
                    });
                }
            }
        })
    }

    function initAddProductDate() {
        $('#add_createDate').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
    }

    function initUpdateProductDate() {
        $('#update_createDate').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
    }
    var v_addProductDialog;
    function showAddProductDlg() {
        v_addProductDialog = bootbox.dialog({
            title: '添加商品',
            message: $("#addProductDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-primary',
                    callback: function(){
                        // 获取表单信息
                        var v_productName = $("#add_productName", v_addProductDialog).val();
                        var v_price = $("#add_price", v_addProductDialog).val();
                        var v_createDate = $("#add_createDate", v_addProductDialog).val();
                        var v_brandId = $("#add_brandSelect", v_addProductDialog).val();
                        var v_mainImagePath = $("#add_mainImagePath", v_addProductDialog).val();
                        var v_gc1 = $($("select[name='categorySelect']", v_addProductDialog)[0]).val();
                        var v_gc2 = $($("select[name='categorySelect']", v_addProductDialog)[1]).val();
                        var v_gc3 = $($("select[name='categorySelect']", v_addProductDialog)[2]).val();
                        var v_gc1Name = $($("select[name='categorySelect']", v_addProductDialog)[0]).attr("data-categoryname");
                        var v_gc2Name = $($("select[name='categorySelect']", v_addProductDialog)[1]).attr("data-categoryname");
                        var v_gc3Name = $($("select[name='categorySelect']", v_addProductDialog)[2]).attr("data-categoryname");
                        var v_cateName = v_gc1Name+"-->"+v_gc2Name+'-->'+v_gc3Name;
                        var v_isHot = $("input[name='add_isHot']:checked", v_addProductDialog).val();
                        // 发送请求，传递参数
                        var v_param = {};
                        v_param.productName = v_productName;
                        v_param.productPrice = v_price;
                        v_param.createDate = v_createDate;
                        v_param["brand.id"] = v_brandId;
                        v_param.gc1 = v_gc1;
                        v_param.gc2 = v_gc2;
                        v_param.gc3 = v_gc3;
                        v_param.mainImagePath = v_mainImagePath;
                        v_param.categoryName = v_cateName;
                        v_param.isHot = v_isHot;
                        $.ajax({
                            url:"/product/add.jhtml",
                            data:v_param,
                            type:"post",
                            success:function(data) {
                                if (data.code == 200) {
                                    // 刷新标识
                                    search();
                                } else {
                                    bootbox.alert({
                                        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>操作错误",
                                        size: 'small',
                                        title: "提示信息"
                                    });
                                }
                            },
                            error:function(result, x, c) {
                                console.log(x);
                                console.log(c);
                                bootbox.alert({
                                    message: "<span class='glyphicon glyphicon-exclamation-sign'></span>操作错误，错误码是："+
                                    result.status+",错误信息:"+result["statusText"]+",请联系管理员！！！",
                                    size: 'small',
                                    title: "提示信息"
                                });
                            }
                        })
                    }
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger'
                }
            }
        });
        // 还原
        $("#addProductDiv").html(v_addProductSource);
        // 初始化添加商品中的日期控件
        initAddProductDate();
        initBrandList("add_brandSelect");
        initCategory('categoryDiv', 0);
        initMainImage();
    }

    function search() {
        // 获取参数信息
        var v_productName = $("#productName").val();
        var v_minPrice = $("#minPrice").val();
        var v_maxPrice = $("#maxPrice").val();
        var v_minCreateDate = $("#minCreateDate").val();
        var v_maxCreateDate = $("#maxCreateDate").val();
        var v_brandId = $("#brandSelect").val();
        var v_gc1 = $($("select[name='categorySelect']",$("#productForm"))[0]).val();
        var v_gc2 = $($("select[name='categorySelect']",$("#productForm"))[1]).val();
        var v_gc3 = $($("select[name='categorySelect']",$("#productForm"))[2]).val();
        // 传递参数
        var v_param = {};
        v_param.productName = v_productName;
        v_param.minPrice = v_minPrice;
        v_param.maxPrice = v_maxPrice;
        v_param.minDate = v_minCreateDate;
        v_param.maxDate = v_maxCreateDate;
        v_param.brandId = v_brandId;
        v_param.gc1 = v_gc1;
        v_param.gc2 = v_gc2;
        v_param.gc3 = v_gc3;
        productTable.settings()[0].ajax.data = v_param;
        productTable.ajax.reload();
    }
    var productTable;

    function initDate() {
        $('#minCreateDate').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });

        $('#maxCreateDate').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-CN',
            showClear: true
        });
    }
    
    function deleteProduct(productId) {
        window.event.stopPropagation();
        bootbox.confirm({
            message: "你确定删除吗?",
            size: 'small',
            title: "提示信息",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确定',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
               if (result) {
                   // 删除
                   $.ajax({
                       type:"post",
                       url:"/product/delete.jhtml",
                       data:{"id":productId},
                       success:function (r) {
                           if (r.code == 200) {
                               search();
                           } else {
                               bootbox.alert({
                                   message: "<span class='glyphicon glyphicon-exclamation-sign'></span>操作错误",
                                   size: 'small',
                                   title: "提示信息"
                               });
                           }
                       }
                   })
               }
            }
        })
    }
    var v_updateProductDialog;
    function showUpdateProductDlg(id) {
        // 阻止事件冒泡
        window.event.stopPropagation();
        $.ajax({
            type:"post",
            url:"/product/find.jhtml?id="+id,
            success:function (r) {
                if (r.code == 200) {
                    // 回填数据
                    var v_result = r.data;
                    $("#update_productName").val(v_result.productName);
                    $("#productId").val(v_result.id);
                    $("#update_price").val(v_result.productPrice);
                    $("#update_createDate").val(v_result.createDate);
                    $("#update_brandSelect").val(v_result.brandId);
                    $("input[name='update_isHot']").each(function() {
                        if (this.value == v_result.isHot) {
                            this.checked='checked';
                            return;
                        }
                    })
                    $("#update_categoryDiv").append("<label class='col-sm-4 control-label' id='categoryNameLabel'>"+v_result.categoryName+"</label>");
                    $("#update_categoryDiv").append("<button type=\"button\" class=\"btn btn-primary\" onclick=\"edit_category('"+v_result.categoryName+"');\"><span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span><span id=\"cateButtonText\">编辑</span></button>");

                    var v_imageArr = [];
                    v_imageArr.push(v_result.mainImagePath);
                    // 初始化编辑时候的主图
                    initEditMainImage(v_imageArr);

                    $("#update_OldmainImagePath").val(v_result.mainImagePath);

                    v_updateProductDialog = bootbox.dialog({
                        title: '修改商品',
                        message: $("#updateProductDiv form"),
                        size:"large",
                        buttons: {
                            confirm: {
                                label: '<span class="glyphicon glyphicon-ok"></span>确认',
                                className: 'btn-primary',
                                callback: function(){

                                    // 获取值
                                    var v_productName = $("#update_productName", v_updateProductDialog).val();
                                    var v_id = $("#productId", v_updateProductDialog).val();
                                    var v_price = $("#update_price", v_updateProductDialog).val();
                                    var v_createDate = $("#update_createDate", v_updateProductDialog).val();
                                    var v_brandId = $("#update_brandSelect", v_updateProductDialog).val();
                                    var v_isHot = $("input[name='update_isHot']:checked", v_updateProductDialog).val();
                                    var v_mainImagePath = $("#update_mainImagePath", v_updateProductDialog).val();
                                    var v_oldMainImagePath = $("#update_OldmainImagePath", v_updateProductDialog).val();
                                    var v_gc1;
                                    var v_gc2;
                                    var v_gc3;
                                    var v_categoryName;
                                    if (v_buttonFlag == 0) {
                                        // 用户没有编辑
                                        v_gc1 = v_result.gc1;
                                        v_gc2 = v_result.gc2;
                                        v_gc3 = v_result.gc3;
                                        v_categoryName = v_result.categoryName;
                                    } else {
                                        // 用户编辑了
                                        v_gc1 = $($("select[name='categorySelect']", v_updateProductDialog)[0]).val();
                                        v_gc2 = $($("select[name='categorySelect']", v_updateProductDialog)[1]).val();
                                        v_gc3 = $($("select[name='categorySelect']", v_updateProductDialog)[2]).val();
                                        var v_gc1Name = $($("select[name='categorySelect']", v_updateProductDialog)[0]).attr("data-categoryname");
                                        var v_gc2Name = $($("select[name='categorySelect']", v_updateProductDialog)[1]).attr("data-categoryname");
                                        var v_gc3Name = $($("select[name='categorySelect']", v_updateProductDialog)[2]).attr("data-categoryname");
                                        v_categoryName = v_gc1Name+"-->"+v_gc2Name+'-->'+v_gc3Name;
                                    }
                                    // 发送请求，传递参数
                                    var v_param = {};
                                    v_param.productName = v_productName;
                                    v_param.productPrice = v_price;
                                    v_param.createDate = v_createDate;
                                    v_param.id = v_id;
                                    v_param["brand.id"] = v_brandId;
                                    v_param.gc1 = v_gc1;
                                    v_param.gc2 = v_gc2;
                                    v_param.gc3 = v_gc3;
                                    v_param.categoryName = v_categoryName;
                                    v_param.isHot = v_isHot;
                                    v_param.mainImagePath = v_mainImagePath;
                                    v_param.oldMainImagePath = v_oldMainImagePath;

                                    $.ajax({
                                        url:"/product/update.jhtml",
                                        data:v_param,
                                        type:"post",
                                        success:function(data) {
                                            if (data.code == 200) {
                                                // 刷新标识
                                                    var oTable = $("#productTable").dataTable(); //table1为表格的id
                                                    var tableSetings=oTable.fnSettings();
                                                    var paging_length=tableSetings._iDisplayLength;//当前每页显示多少
                                                    var page_start=tableSetings._iDisplayStart;//当前页开始
                                                    var page=(page_start / paging_length); //得到页数值  比页码小1
                                                    console.log(page_start+":"+paging_length+":"+page)
                                                    oTable.fnPageChange(page);//加载跳转

                                            } else {
                                                bootbox.alert({
                                                    message: "<span class='glyphicon glyphicon-exclamation-sign'></span>操作错误",
                                                    size: 'small',
                                                    title: "提示信息"
                                                });
                                            }
                                        }
                                })
                            }},
                            cancel: {
                                label: '<span class="glyphicon glyphicon-remove"></span>取消',
                                className: 'btn-danger'
                            }
                        }
                    });
                    // 还原
                    $("#updateProductDiv").html(v_updateProductSource);
                    initUpdateProductDate();
                    initBrandList("update_brandSelect");
                    // 归零
                    v_buttonFlag = 0;
                }
            }


        })
    }
    
    
    function refreshProductCache() {
        $.ajax({
            type:"post",
            url:"/product/refreshProductCache.jhtml",
            success:function(data) {
                if (data.code == 200) {
                    alert("刷新成功");
                }
            }
        })
    }




    function isExist(id) {
        for (var i = 0; i < ids.length; i++) {
            if (id == ids[i]) {
                return true;
            }
        }
        return false;
    }

    function initProductTable() {
        productTable = $('#productTable').DataTable({
            "processing": true,
            "serverSide": true,
            "lengthMenu": [5, 10, 20],
            // 是否允许检索
            "searching": false,
            "ajax": {
                url:"<%=request.getContextPath()%>/product/findList.jhtml",
                type:"post",
                "dataSrc": function (result) {
                    if (result.code == 200) {
                        result.draw = result.data.draw;
                        result.recordsTotal = result.data.recordsTotal;
                        result.recordsFiltered = result.data.recordsFiltered;
                        // console.log(result.data);
                        // console.log(result.data.data);
                        return result.data.data;
                    }
                }
            },
            "language": {
                "url": "/js/DataTables/Chinese.json"

            },
            drawCallback:function (s) {
                // 对比，将当前表格中出现的行的唯一标识和ids数组中的唯一标识对比，一致则回填
                $("#productTable tbody tr").each(function () {
                    var v_checkbox = $(this).find("input[type='checkbox']")[0];
                    if (v_checkbox) {
                        var id = v_checkbox.value;
                        console.log(id);
                        if (isExist(id)) {
                            $(this).css("background-color", "blue");
                            v_checkbox.checked = true;
                        }
                    }
                })
            },
            "columns": [
                {
                    "data":"productId",
                    "render": function (data, type, row, meta) {
                        return "<input type='checkbox' name='ids' value='"+data+"'/>";
                    }
                },
                { "data": "productName" },
                { "data": "status",
                    "render": function (data, type, row, meta) {
                        return data==1?"正常":"下架";
                    }
                },
                {
                    "data": "mainImagePath",
                    "render": function (data, type, row, meta) {
                        return "<img src='"+data+"' width='100px' height='100px'/>";
                    }
                },
                {"data": "brandName"},
                { "data": "productPrice" },
                { "data": "createDate" },
                { "data": "categoryName" },
                { "data": "isHot" ,
                "render": function (data, type, row, meta) {
                    return data==1?"是":"否";
                 }
                },
                {
                    "data":"productId",
                    "render": function (data, type, row, meta) {
                        var str = "";
                        var className = "";
                        var status;
                        if (row.status == 1) {
                            // 下架
                            str = '下架';
                            className = "btn btn-warning";
                            status = 2;
                        } else {
                            // 上架
                            str = '上架';
                            className = "btn btn-success";
                            status = 1;
                        }
                       return "<div class=\"btn-group\" role=\"group\" >\n" +
                           "                                            <div class=\"btn-group \" role=\"group\">\n" +
                           "                                                <button type=\"button\" class=\"btn btn-info \" onclick=\"showUpdateProductDlg('"+data+"');\"><i class=\"glyphicon glyphicon-pencil\"></i>修改</button>\n" +
                           "                                            </div>\n" +
                           "                                            <div class=\"btn-group\" role=\"group\">\n" +
                           "                                                <button type=\"button\" class=\"btn btn-danger \" onclick=\"deleteProduct('"+data+"')\"><i class=\"glyphicon glyphicon-trash\"></i>删除</button>\n" +
                           "                                            </div>\n" +
                           "                                            <div class=\"btn-group\" role=\"group\">\n" +
                           "                                                <button type=\"button\" class=\""+className+" \" onclick=\"updateProductStatus('"+data+"','"+status+"')\">"+str+"</button>\n" +
                           "                                            </div>\n" +
                           "                                        </div>"
                    },
                }
            ]
        });
    }

    function updateProductStatus(id, status) {
        window.event.stopPropagation();
        var v_info = status==1?"上架":"下架";
        bootbox.confirm({
            message: "你确定"+v_info+"吗?",
            size: 'small',
            title: "提示信息",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确定',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result) {
                    $.ajax({
                        type:"post",
                        url:"/product/updateProductStatus.jhtml",
                        data:{"id":id,"status":status},
                        success:function(data) {
                            if(data.code == 200) {
                                // 刷新
                                search();
                            }
                        }
                    })
                }
            }
        })

    }
</script>
</body>
</html>