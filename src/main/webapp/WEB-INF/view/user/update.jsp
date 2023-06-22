<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿캠핑 개인정보 수정</title>
</head>
<body>
	<div class="w3-content" style="max-width: 600px; padding-top: 100px">
		<h3 class="w3-center">개인정보 수정</h3>
		<form action="update" method="post">
			<table class="w3-table">
				<tr>
					<td colspan="3"><input type="text" name="name"
						placeholder="이름" class="form-control"></td>
				</tr>
				<tr>
					<td width="33%"><select class="form-control" name="year">
							<option value="">태어난 년도</option>
							<c:forEach var="i" begin="1980" end="2010">
								<option value="${i}">${i}</option>
							</c:forEach>
					</select></td>
					<td width="33%"><select class="form-control" name="month">
							<option value="">태어난 월</option>
							<c:forEach var="i" begin="1" end="12">
								<c:if test="${i<10}">
									<option value="0${i}">0${i}</option>
								</c:if>
								<c:if test="${i>=10}">
									<option value="${i}">${i}</option>
								</c:if>
							</c:forEach>
					</select></td>
					<td width="34%"><select class="form-control" name="day">
							<option value="">태어난 일</option>
							<c:forEach var="i" begin="1" end="31">
								<c:if test="${i<10}">
									<option value="0${i}">0${i}</option>
								</c:if>
								<c:if test="${i>=10}">
									<option value="${i}">${i}</option>
								</c:if>
							</c:forEach>
					</select></td>
				</tr>
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
					<td colspan="3"><h6 style="text-align:right;"><a href="mypwForm">비밀번호 변경</a></h6></td>
				</tr>
				<tr>
					<td colspan="3"><div
							style="margin-bottom: 50px; text-align: center">
							<input type="submit" value="수정" class="btn btn-dark"
								style="background-color: #cddc39; color: black; width:100px	">
								<input type="button" value="회원탈퇴" class="btn btn-dark"
								style="background-color: #cddc39; color: black; width:100px" onclick="location.href='deleteForm'">
						</div></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>