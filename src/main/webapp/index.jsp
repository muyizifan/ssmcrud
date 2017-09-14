<%--
  Created by IntelliJ IDEA.
  User: tao
  Date: 2017/9/14
  Time: 上午8:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>员工列表</title>
    <%
        request.setAttribute("APP_PATH", request.getContextPath());

    %>
    <!--
    web路径
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题，
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)，需要加上项目名
    http://localhost:3306/crud
    -->
    <%--引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页信息条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    //1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
       $.ajax({
          url:"${APP_PATH}/emps",
          data:"pn=1",
           type:"get",
           success:function (result) {
               //console.log(result)
               //1.解析并显示员工数据
               build_emp_table(result);
               //2.解析并显示分页信息
               build_page_info(result);
               //3.解析显示分页条数据
               build_page_nav(result);
           }
       });
    });
    function build_emp_table(result) {
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {//index代表索引，item代表当前对象
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var genderTd=$("<td></td>").append(item.gender=='M'?'男':'女');
            var emailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.department.deptName);
            /**
             * <button class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
             编辑
             </button>
             */
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-remove"))
                .append("删除");
            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后还是返回原来的元素
           $("<tr></tr>").append(empIdTd)
               .append(empNameTd)
               .append(genderTd)
               .append(emailTd)
               .append(deptNameTd)
               .append(btnTd)
               .appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总共"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"共条记录");
    }
    //解析显示分页条,点击分页要能去下一页
    function build_page_nav(result) {
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        ul.append(firstPageLi).append(prePageLi);
        //1,2,3,4,5
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            ul.append(numLi);
        })
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        ul.append(nextPageLi).append(lastPageLi);
        var navLi=$("<nav></nav>").append(ul);
        $("#page_nav_area").append(navLi);
    }
</script>
</body>
</html>
