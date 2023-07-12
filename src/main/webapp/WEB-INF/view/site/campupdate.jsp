<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/detail.css">
<title>캠핑장 업데이트</title>

</head>
<body>
<div style="width: 90%; margin: 0 auto; padding-bottom: 60px; padding-top:60px">
		<div class="wrap">
			<div class="mainImg">
				<c:if test="${camp.firstImageUrl != null}">
					<img src="${camp.firstImageUrl}" style="width: 90%">
				</c:if>
				<c:if test="${camp.firstImageUrl == ''}">
					<img src="${path}/img/campimg.jpg" width="590px" height="393px">
				</c:if>
			</div>
			<div class="info">
				<h3>${camp.facltNm}</h3>
				<form method="post" action="campupdate" name="f">
				<table class="w3-table w3-bordered"
					style="border-top: 2px solid #cddc39; border-bottom: 2px solid #cddc39;">
					<tr>
						<th>주소</th>
						<td><input type="text" class="form-control" id="addr1"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" class="form-control" id="tel"></td>
					</tr>
					<tr>
						<th>캠핑장 환경</th>
						<td><input type="text" class="form-control" id="lctCl" style="width:40%" placeholder="입지구분">/
						<input type="text" class="form-control" id="facltDivNm" style="width:40%" placeholder="사업주체.구분"></td>
					</tr>
					<tr>
						<th>캠핑장 유형</th>
						<td><input type="text" class="form-control" id="induty"></td>
					</tr>
					<tr>
						<th>운영 기간</th>
						<td><input type="text" class="form-control" id="operPdCl"></td>
					</tr>
					<tr>
						<th>운영 일</th>
						<td><input type="text" class="form-control" id="operDeCl"></td>
					</tr>
					<tr>
						<th>홈페이지</th>
						<td><input type="text" class="form-control" id="homepage"></td>
					</tr>
				</table>
				<div style="margin-top: 15px">
						<button type="submit" class="btn btn-white">
							<i class='fas fa-tools'></i>
							 <b>캠핑장 수정</b>
						</button>
				</div>
				</form>
		</div>
	</div>
</div>
			
</body>
</html>