<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="javax.jws.WebParam.Mode"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/bootstrap.min.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/bootstrap-theme.min.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/jquery-ui.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lylich_canbo/css/MyStyle.css"/>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thêm cán bộ</title>
</head><body class="container">
<div class="row">
  <div class="container">
    <div class="row">
      <div class="col-xs-12 col-md-4">
        <label>Họ tên cán bộ</label>
      </div>
      <div class="col-xs-12 col-md-8"> 
      <span>
        <label>${lyLich.tenCanBo }</label>
        </span> </div>
    </div>
    <div class="row">
      <div class="col-xs-12 col-md-4">
        <label>Giới tính</label>
      </div>
      <div class="col-xs-12 col-md-8"> <span>
        <label>
        	${lyLich.gioiTinh == true ? "Nam" : "Nữ"}</label>
        </span> </div>
    </div>
    <div class="row">
      <div class="col-xs-12 col-md-4">
        <label>Ngày sinh</label>
      </div>
      <div class="col-xs-12 col-md-8"> <span>
        <label>${lyLich.ngaySinh }</label>
        </span> </div>
    </div>
    <div class="row">
      <div class="col-xs-12 col-md-4">
        <label>Số chứng minh nhân dân</label>
      </div>
      <div class="col-xs-12 col-md-8"> <span>
        <label>${lyLich.soCmnd }</label>
        </span> </div>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-xs-12 col-md-6">
    <div class="container-fluid">
      <div class="row">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4>
              <label> Thông tin chức vụ cán bộ </label>
            </h4>
          </div>
          <div class="panel-body">
            <div class="container-fluid">
              <div class="row">
                <ul class="nav nav-tabs" role="tablist">
                  <li role="presentation" class="active"><a href="#ban" aria-controls="home" role="tab" data-toggle="tab">Ban</a></li>
                  <li role="presentation"><a href="#donvi" aria-controls="profile" role="tab" data-toggle="tab">Đơn vị</a></li>
                </ul>
              </div>
              <div class="row">
                <div class="tab-content">
                  <table class="table table-hover tab-pane active" role="tabpanel" id="ban">
                    <thead>
                      <tr>
                        <th><label>Tên ban</label></th>
                        <th><label>Tên đơn vị</label></th>
                        <th><label>Tên chức vụ</label></th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="item" items="${bans}">
                      	<tr>
                      		<td>${item.ban.tenBan}</td>
                      		<td>${item.ban.donvi.tenDonVi }</td>
                      		<td>${item.chucvuban.tenChucVu}</td>
                      		<%-- <td>${item.ban.donvi.tenDonVi}</td>
                      		<td>${item.chucvuban.tenChucVu}</td> --%>
                      		<td>
	                      		<a href="/qlcb/canbo/xoachucvuban/${item.id.idcanBo}/${item.id.idban}/${item.chucvuban.maChucVu}">
	                      			<button class="btn btn-default" type="button" >
	                      		 		<span class="glyphicon glyphicon-remove">
	                      		 		Xóa
	                      		 		</span>
	                      		 	</button>
	                    		</a>
                      		</td>
                      	</tr>
                      </c:forEach>
                    </tbody>
                  </table>
                  <table class="table table-hover tab-pane" role="tabpanel" id="donvi">
                    <thead>
                      <tr>
                        <th><label>Tên đơn vị</label></th>
                        <th><label>Tên chức vụ</label></th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="item" items="${donvis}">
                      	<tr>
                      		<td>${item.donvi.tenDonVi }</td>
                      		<td>${item.chucvudonvi.tenChucVu}</td>
                      		<td>
                      		
                      		<a href="/qlcb/canbo/xoachucvudonvi/${item.id.maCanBo}/${item.id.maDonVi}/${item.chucvudonvi.maChucVu}">
                      			<button class="btn btn-default" type="button">
                      				<span class="glyphicon glyphicon-remove">
                      					Xóa
                      				</span>
                      			</button>
                   			</a>
                      		</td>
                      	</tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="col-xs-12 col-md-6">
    <div class="container-fluid">
      <div class="row">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h4>
              <label> Thêm chức vụ cán bộ </label>
            </h4>
          </div>
          <div class="panel-body">
            <div class="container-fluid">
              <div class="row">
                <ul class="nav nav-tabs" role="tablist">
                  <li role="presentation" class="active"><a href="#banForm" aria-controls="home" role="tab" data-toggle="tab">Ban</a></li>
                  <li role="presentation"><a href="#donviForm" aria-controls="profile" role="tab" data-toggle="tab">Đơn vị</a></li>
                </ul>
              </div>
              <div class="row">
                <div class="tab-content">
                 <div class="tab-pane active" role="tabpanel" id="banForm">
                  <form method="post" class="form-horizontal" action="/qlcb/canbo/themchucvuban/${idcanbo}">
                    <div class="form-group">
                        <div class="col-xs-12 col-md-4">
                        	<label>Chọn ban</label>
                        </div>
                        <div class="col-xs-12 col-md-8">
                        	<select class="form-control" id="ban" name="ban">
                        		<c:forEach var="item" items="${banList}" >
                          			<option value="${item.maBan}">${item.donvi.tenDonVi} - ${item.tenBan}</option>
                        		</c:forEach>
                      		</select>
                    	</div>
                   	</div>
                    <div class="form-group">
                      <div class="col-xs-12 col-md-4">
                        <label>Chức vụ</label>
                      </div>
                      <div class="col-xs-12 col-md-8">
                        <select class="form-control" name="chucvu" id="chucvu">
                          <c:forEach var="item" items="${chucVuBanList}">
                            <option value="${item.maChucVu }">${item.tenChucVu}</option>
                          </c:forEach>
                        </select>
                      </div>
                    </div>
                    <button class="btn btn-default" type="submit" id="banpost" name="banpost" style="float:right"> <span class="glyphicon glyphicon-plus"> Thêm </span> </button>
                  </form>
                 </div>
                <div class="tab-pane" role="tabpanel" id="donviForm">
                  <form method="post" class="form-horizontal" action="/qlcb/canbo/themchucvudonvi/${idcanbo}">
                    <div class="form-group">
                      <div class="col-xs-12 col-md-4">
                        <label>Chọn đơn vị</label>
                      </div>
                      <div class="col-xs-12 col-md-8">
                        <select class="form-control" name="donvi">
                          <c:forEach var="item" items="${donViList }">
                            <option value="${item.maDonVi }">${item.tenDonVi} </option>
                          </c:forEach>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-xs-12 col-md-4">
                        <label>Chức vụ</label>
                      </div>
                      <div class="col-xs-12 col-md-8">
                        <select class="form-control" name="chucvu">
                          <c:forEach var="item" items="${chucVuDonViList}">
                            <option value="${item.maChucVu}">${item.tenChucVu }</option>
                          </c:forEach>
                        </select>
                      </div>
                    </div>
                    <button class="btn btn-default" type="submit" name="donvipost" style="float:right"> <span class="glyphicon glyphicon-plus"> Thêm </span> </button>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
<script src="<c:url value="/resources/lylich_canbo/js/jquery-2.2.2.js"/>"></script> 
<script src="<c:url value="/resources/lylich_canbo/js/bootstrap.min.js"/>"></script> 
<script src="<c:url value="/resources/lylich_canbo/js/jquery-ui.js"/>"></script> 
<script src="<c:url value="/resources/lylich_canbo/js/myjs.js"/>"></script> 
<script src="<c:url value="/resources/lylich_canbo/js/create.js"/>"></script>
</body>
</html>