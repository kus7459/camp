<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>상품 결제</title>
</head>
<body>
<style>
		* {margin: 0; padding: 0;}
	    a {text-decoration: none; color: #333}
	    ol, ul {list-style: none}
	
	    .btn-lime {background-color:#cddc39}
	   
	    .btn-gray {background-color:#dedede}
		.btn-white {background-color: #fff;}
		
		header {position: relative;
	    		height:150px; 
	    		background-color:#cddc39;}
		header>h3 {position:absolute;
			bottom: 5px;
			left: 5%;
			font-weight: bold;}
		h4 {font-weight: bold;}
		table tr {line-height: 3rem}
	</style>
	<header>
		<h3>상품 결제 전 확인</h3>
	</header>
	<div style="width:90%; margin: 0 auto; padding:60px 0px">
		<form method="post" action="order" name="orderform">
			<table class="w3-table w3-striped">
				<tr>
					<th>상품</th>
					<th>상품 이름</th>
					<th>상품 가격</th>
					<th>개수</th>
				</tr>
				<c:forEach items="${cartlist}" var="cart">
					<tr id="del${cart.itemid}">
						<td style="width:10%">
							<img src="../img/${cart.pictureUrl}" style="width:90%">
						</td>
						<td>
							<b style="color:#333">${cart.name}</b>
						</td>
						<td><fmt:formatNumber value="${cart.price}" pattern="###,###"/></td>
						<td>${cart.quantity}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="3" class="w3-center">
						<b>총 금액: <fmt:formatNumber value="${total}" pattern="###,###"/></b>
					</td>
				</tr>
			</table>
			<h4 style="padding-top:30px;">주문자 정보</h4>
			<table class="w3-table">
				<tr>
					<th style="width:20%">이름</th>
					<td>${user.name}</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${user.tel}</td>
				</tr>
				<tr>
					<th>주소</th>
				</tr>
				<tr>
					<td style="display:flex">
						<input type="text" id="postcode" name="postcode" placeholder="우편 번호"  class="form-control"></td>
					<td>&emsp;
						<input type="button" onclick="execDaumPostcode()" class="btn btn-gray" value="우편번호 찾기">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" id="address" name="address" value="" placeholder="주소" class="form-control">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" name="detailAddress" placeholder="상세주소" class="form-control">
					</td>
				</tr>
				<tr class="w3-center">
					<td><a href="javascript:chk()" class="btn btn-lime">다음</a></td>
					<td><a href="../user/mypage?id=${user.id}" class="btn btn-gray">취소</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>