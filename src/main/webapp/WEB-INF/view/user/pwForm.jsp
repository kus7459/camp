<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

</head>
<body>
	<div class="w3-content" style="max-width: 600px; padding-top: 100px">
		<h3 class="w3-center">비밀번호 찾기</h3>
		<form action="pw" method="post">
			<table class="w3-table">
				<tr>
					<td colspan="3" width="60%"><input type="text" name="id"
						placeholder="ID를 입력해주세요" class="form-control"></td>
				</tr>
				<tr>
					<td width="48%"><input type="text" name="email" id="email"
						class="form-control" placeholder="email"></td>
					<td width="4%">@</td>
					<td width="48%"><select class="form-control" name="com"
						id="com">
							<option value="">주소를 선택하세요</option>
							<option value="naver.com">naver.com</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
					</select></td>
				</tr>
				<tr>
					<td colspan="3"><input type="text" name="tel"
						placeholder="-을 포함한 전화번호 10자리 또는 11자리" class="form-control">
					</td>
				</tr>
				<tr>
					<td colspan="3"><div
							style="margin-bottom: 50px; margin-top: 25px; text-align: center">
							<input type="submit" value="비밀번호 찾기" class="btn btn-dark"
								style="background-color: #cddc39; color: black;">
						</div></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>