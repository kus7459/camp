<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
</head>
<body>
<div class="w3-content" style="margin-top:100px">
   <h3>회원아이디</h3>
   <div style="display:flex; align-items: center; margin-bottom:10dpx;">   
      <div class="form-group">
            <table class="w3-table">
            <tr>
            	<td>이름</td><td>이름</td>
            </tr>
            <tr>
            	<td>생년월일</td><td>생년월일</td>
            </tr>
            <tr>
            	<td>전화번호</td><td>전화번호</td>
            </tr>
            <tr>
            	<td>이메일</td><td>이메일</td>
            </tr>
            <tr>
            <td colspan="2">
            <a href="update" style="text-decoration: none; color:#000" id="infoa">내 정보 변경</a>
            </td>
            </table>
      </div>
   </div>
</div>
<hr>
</body>
</html>