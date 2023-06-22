<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

</head>
<body>
	<div class="w3-content" style="max-width: 600px;padding-top:100px">
		<h3 class="w3-center">아이디 찾기</h3>
		<form action="id" method="post">
			<table class="w3-table">
				<tr>
               <td colspan="3">
               		<input type="text" name="email" id="email"
                  class="form-control" placeholder="email형식으로 입력해주세요.">
               </td>
            </tr>
				<tr>
					<td colspan="3"><input type="text" name="tel"
						placeholder="-을 포함한 전화번호 10자리 또는 11자리" class="form-control">
					</td>
				</tr>
				<tr>
					<td colspan="3"><div style="margin-bottom:50px; margin-top:25px;text-align:center">
					<input type="submit" value="아이디 찾기" class="btn btn-dark" 
					style="background-color:#cddc39;color:black;"></div></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>