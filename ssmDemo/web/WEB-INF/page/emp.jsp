<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/dist/css/bootstrap.min.css">
    <%--
        <script href="static/dist/js/jquery-1.7.2.js"></script>
    --%>
    <script src="static/dist/js/bootstrap.min.js"></script>
    <script src="static/dist/js/jquery-1.12.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script>
        $(function () {
            //添加按钮
            $("#addemp").click(function () {
                $("#deptNameadd").empty();
                $.ajax({
                    url: "${pageContext.request.contextPath}/dept",
                    type: "GET",
                    success: function (data) {
                        $.each(data, function () {
                            var option = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                            option.appendTo($("#deptNameadd"))
                        })
                    }
                });

                //重置表单
                $("#addempform")[0].reset();
                $("#addempform span").text("");
                $("#addempform div").removeClass("has-success has-error");

                layer.open({
                    type: 1,
                    area: ["500px", "350px"],
                    content: $("#addempinfo")
                })


                //表单验证提示信息
                //用户名验证
                $("#unameinput").change(function () {
                    var name = $("#unameinput").val();
                    var checkname = /^[a-z0-9_-]{4,16}$|^[\u2E80-\u9FFF]{2,10}$/;
                    $("#unameinput").parent().removeClass("has-success has-error");
                    $("#unameinput").next("span").text("");
                    if (!checkname.test(name)) {
                        $("#unameinput").parent().addClass("has-error");
                        $("#unameinput").next("span").text("用户名不合法");
                        $("#unameinput").attr("iskeyong","no");
                    } else {
                        $("#unameinput").parent().addClass("has-success");
                        var url="/selectUname";
                        var data={"name":name};
                        $.post(url,data,function (msg) {
                            if(msg=="yes"){
                                $("#unameinput").next("span").text("用户名可用");
                                $("#unameinput").attr("iskeyong","yes");
                            }else {
                                $("#unameinput").parent().addClass("has-error");
                                $("#unameinput").next("span").text("用户名重复");
                            }
                        })

                    }
                });


                //邮箱验证
                $("#uEmailaddinput").change(function () {
                    var email = $("#uEmailaddinput").val();
                    var checkemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                    $("#uEmailaddinput").parent().removeClass("has-success has-error");
                    $("#uEmailaddinput").next("span").text("");
                    if (!checkemail.test(email)) {
                        $("#uEmailaddinput").parent().addClass("has-error");
                        $("#uEmailaddinput").next("span").text("邮箱格式不正确");
                        $("#uEmailaddinput").attr("iskeyong","no");
                    }else {
                        $("#uEmailaddinput").parent().addClass("has-success");
                        $("#uEmailaddinput").attr("iskeyong","yes");
                    }
                });
                //取消按钮
                $("#quxiaoemp").click(function () {
                    layer.closeAll();
                });

                //保存按钮
                $("#save_add").click(function () {
                    var url = "${pageContext.request.contextPath}/saveAdd";
                    var data = $("#addempform").serializeArray();
                    if ($("#unameinput").attr("iskeyong")=="yes"&&$("#uEmailaddinput").attr("iskeyong")=="yes"&&$("#unameinput").val().length>0){
                            $.post(url, data, function (data1) {
                            layer.closeAll();
                            window.location.reload();
                        })
                    }
                });
            });
            //编辑按钮
            $(".update-btn").click(function () {
                $("#deptNameupdate").empty();
                $("#save_update").attr("suibian",$(this).attr("update-id"))
                $.ajax({
                    url: "${pageContext.request.contextPath}/dept",
                    type: "GET",
                    success: function (data) {
                        $.each(data, function () {
                            var option = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                            option.appendTo($("#deptNameupdate"))
                        })
                    }
                });
                $.ajax({
                    url:"${pageContext.request.contextPath}/update_emp/"+$(this).attr("update-id"),
                    type:"Get",
                    success:function (result) {
                        $("#update-name").text(result.uName);
                        $("#updateempinfo input[name=uGander]").val([result.uGander]);
                        $("#uEmailupdateinput").val(result.uEmail);
                        $("#deptNameupdate").val(result.dId)
                    }
                });
                //重置编辑按钮弹出框
                $("#updateempform")[0].reset();
                $("#updateempform span").text("");
                $("#updateempform div").removeClass("has-success has-error");
                //编辑按钮弹出狂
                layer.open({
                    type: 1,
                    area: ["500px", "350px"],
                    content: $("#updateempinfo")
                })
            });
            //修改信息邮箱验证
            $("#uEmailupdateinput").change(function () {
                var email = $("#uEmailupdateinput").val();
                var checkemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                $("#uEmailupdateinput").parent().removeClass("has-success has-error");
                $("#uEmailupdateinput").next("span").text("");
                if (!checkemail.test(email)) {
                    $("#uEmailupdateinput").parent().addClass("has-error");
                    $("#uEmailupdateinput").next("span").text("邮箱格式不正确");
                    $("#uEmailupdateinput").attr("iskeyong","no");
                }else {
                    $("#uEmailupdateinput").parent().addClass("has-success");
                    $("#uEmailupdateinput").attr("iskeyong","yes");
                }
            });
            //编辑 弹框内的保存按钮
            $("#save_update").click(function () {
                $.ajax({
                    url:"${pageContext.request.contextPath}/updateemp/"+$(this).attr("suibian"),
                    type:"PUT",
                    data:$("#updateempform").serialize(),
                    success:function (result) {
                        layer.closeAll();
                        window.location.reload();
                    }
                })
            });
            //编辑 取消按钮
            $("#quxiaoemp_update").click(function () {
                layer.closeAll();
                window.location.reload();
            });
            //复选框 全选
            $("#checkbox-all").click(function () {
                var flag = $("#checkbox-all").is(":checked");
                $(".checkbox-each").each(function () {
                    $(this).prop("checked",flag);
                })
            });
            //选中所有复选框，全选
            $(".checkbox-each").click(function () {
              var flag=  $(".checkbox-each:checked").length==$(".checkbox-each").length;
                $("#checkbox-all").prop("checked",flag);
            });
            //单个删除
            $(".del-btn").click(function () {
                var name=$(this).parents("tr").find("td:eq(2)").text();
                var deleteid=$(this).parents("tr").find("td:eq(1)").text();
                if(confirm("是否删除 "+name+" 的信息?")){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/delete/"+deleteid,
                        type:"DELETE",
                        success:function (result) {
                            window.location.reload();
                        }
                    })
                }
            });
            //批量删除
            $("#delete-all-btn").click(function () {
                var names="";
                var id="";
                $(".checkbox-each:checked").each(function () {
                    names += $(this).parents("tr").find("td:eq(2)").text()+",";
                    id += $(this).parents("tr").find("td:eq(1)").text()+",";
                });
                names= names.substring(0,names.length-1);
                id= id.substring(0,id.length-1);
                if (confirm("是否删除 "+names+" 的信息")){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/delete/"+id,
                        type:"DELETE",
                        success:function (data) {
                            window.location.reload();
                        }
                    })
                }
            });
        })

    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <h1>员工部门信息表</h1>
        </div>
    </div>
    <div class="row">
        <div class="pull-right">
            <button class="btn btn-primary " id="addemp">添加</button>
            <button class="btn btn-danger " id="delete-all-btn">删除</button>
        </div>
    </div>
    <div class="row">
        <table class="table table-hover">
            <tr>
                <th><input type="checkbox" id="checkbox-all"></th>
                <th>编号</th>
                <th>u_name</th>
                <th>u_gander</th>
                <th>u_email</th>
                <th>dept_name</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${haha.list}" var="page">
                <tr>
                    <td><input type="checkbox" class="checkbox-each"></td>
                    <td>${page.uId}</td>
                    <td>${page.uName}</td>
                    <td>${page.uGander}</td>
                    <td>${page.uEmail}</td>
                    <td>${page.dept.deptName}</td>
                    <td>
                        <button class="btn btn-info btn-sm update-btn update-id " update-id="${page.uId}">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            编辑
                        </button>
                        <button class="btn btn-danger btn-sm del-btn" delete-id="${page.uId}">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                        </button>
                    </td>
                </tr>
            </c:forEach>

        </table>
    </div>
    <div class="row">
        <div class="col-lg-6">

            当前${haha.pageNum}页,共${haha.pages}页，共${haha.total}条

        </div>
        <div class="col-lg-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="/emp?pn=1">首页</a></li>
                    <c:if test="${haha.hasPreviousPage}">

                        <li>
                            <a href="/emp?pn=${haha.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${haha.navigatepageNums}" var="pNum">
                        <c:if test="${pNum==haha.pageNum}">
                            <li class="active"><a href="#">${pNum}</a></li>
                        </c:if>
                        <c:if test="${pNum!=haha.pageNum}">
                            <li><a href="/emp?pn=${pNum}">${pNum}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${haha.hasNextPage}">

                        <li>
                            <a href="/emp?pn=${haha.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="/emp?pn=${haha.pages}">尾页</a></li>
                </ul>
            </nav>
        </div>
    </div>

</div>
<div style="display: none " id="addempinfo">
    <form class="form-horizontal" id="addempform">
        <div class="form-group">
            <label for="unameinput" class="col-sm-2 control-label">uName</label>
            <div class="col-sm-6">
                <input type="text" name="uName" class="form-control" id="unameinput" placeholder="uName 2到4位汉字或6-9字母">
                <span class="help-block"></span>
            </div>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">uGander</label>
            <div class="col-sm-6">
                <input type="radio" name="uGander" value="男" checked="checked">男
                <input type="radio" name="uGander" value="女">女
            </div>
        </div>
        <div class="form-group">
            <label for="uEmailaddinput" class="col-sm-2 control-label"> uEmail</label>
            <div class="col-sm-6">
                <input type="text" name="uEmail" class="form-control" id="uEmailaddinput" placeholder="uEmail">
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">deptName</label>
            <div class="col-sm-4">
                <select name="dId" id="deptNameadd" class="form-control">

                </select>
            </div>
        </div>

        <div class="form-group  text-right">
            <div class="col-sm-offset-2 col-sm-10 ">
                <button type="button" class="btn btn-default" id="quxiaoemp">关闭</button>
                <button type="button" class="btn btn-info" id="save_add">保存</button>
            </div>
        </div>
    </form>
</div>
<div style="display: none " id="updateempinfo">
    <form class="form-horizontal" id="updateempform">
        <div class="form-group">
            <label for="unameinput" class="col-sm-2 control-label">uName</label>
            <div class="col-sm-6">
                <p class="form-control-static" id="update-name"></p>
            </div>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">uGander</label>
            <div class="col-sm-6">
                <input type="radio" name="uGander" value="男" checked="checked">男
                <input type="radio" name="uGander" value="女">女
            </div>
        </div>
        <div class="form-group">
            <label for="uEmailaddinput" class="col-sm-2 control-label"> uEmail</label>
            <div class="col-sm-6">
                <input type="text" name="uEmail" class="form-control" id="uEmailupdateinput" placeholder="uEmail">
                <span class="help-block"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">deptName</label>
            <div class="col-sm-4">
                <select name="dId" id="deptNameupdate" class="form-control">

                </select>
            </div>
        </div>

        <div class="form-group  text-right">
            <div class="col-sm-offset-2 col-sm-10 ">
                <button type="button" class="btn btn-default" id="quxiaoemp_update">关闭</button>
                <button type="button" class="btn btn-info" id="save_update" >保存</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
