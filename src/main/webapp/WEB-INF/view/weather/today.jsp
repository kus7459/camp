<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날씨</title>
</head>
<body>
<style>
 	* {margin: 0; padding: 0;}
    a {text-decoration: none;}
    ol, ul {list-style: none}
    header {position: relative;
    		height:150px; 
    		background-color:#cddc39;}
	header>h3 {position:absolute;
		bottom: 5px;
		left: 5%;
		font-weight: bold;}
</style>
<header>
	<h3>날씨 보기</h3>
	<div>
		<p><b>서울 특별시 ~ 위치</b> 날씨</p>
	</div>
</header>
</body>
</html>