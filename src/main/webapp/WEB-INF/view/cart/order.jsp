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
			<input type="hidden" name="saleid" value="${saleid}">
			<table class="w3-table w3-striped">
				<tr>
					<th>상품</th>
					<th>상품 이름</th>
					<th>상품 가격</th>
					<th>개수</th>
				</tr>
				<c:forEach items="${cartlist}" var="cart">
					<input type="hidden" name="name" value="${cart.name}">
					<input type="hidden" name="pictureUrl" value="${cart.pictureUrl}">
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
					<td colspan="4" class="w3-center">
						<b>총 금액: <fmt:formatNumber value="${sum}" pattern="###,###"/></b>
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
					<th>우편 번호:</th>
					<td>${postcode}</td>
				</tr>
				<tr>
					<th>
						주소:
					</th>
					<td>${address}, ${detailAddress}</td>
				</tr>
			</table>
		</form>
		<div class="w3-center">
			<a href="javascript:kakaopay()" class="btn btn-lime">결제하기</a>
			<a href="javascript:saledelete()" class="btn btn-gray">취소</a>
		</div>
		<form action="saledelete" name="saledeleteform" method="post">
			<input type="hidden" name="saleid" value="${saleid}">
		</form>
	</div>
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
	<script>
		function saledelete() {
			console.log("Aa")
			document.saledeleteform.submit();
		}
	
		let IMP = window.IMP
		IMP.init("imp53355580")		// 가맹점 식별 코드
		
		function kakaopay() {
			$.ajax("kakao", {
				success : function(json) {
					iamPay(json)
				}
			})
		}
		function iamPay(json) {
			IMP.request_pay({
				pg : "kakaopay",		// pg: 상점 구분. 카카오페이를 요청할 것
				pay_method : "card",	// 종류: 카드 결제
				merchant_uid : json.merchant_uid,	// 주문 번호가 들어감(각 상점이 결정함). 
													// 주문별로 유일한 값이 필요. userid-session의 id값으로 결정함
				name : json.name,		// 주문 상품명. ex)사과 외 3건, 
				amount : json.amount,	// 해당 주문의 전체 금액
				// ↓ 주문자 정보
				buyer_email : "miny2351@gmail.com",	//주문자 이메일인데 일단 그냥 내 이메일 넣기
				buyer_name : json.buyer_name, 		// 주문자 이름
				buyer_tel : json.buyer_tel,			// 주문자 전화번호
				buyer_addr : json.buyer_addr,		// 주문자 주소
				buyer_postcode : json.buyer_postcode	// 주문자 우편번호
			}, function(rsp){
				if(rsp.success) {
					let msg = "결제가 완료 되었습니다."
					msg += "\n:고유ID: " + rsp.imp_uid
					msg += "\n:상점ID: " + rsp.merchant_uid
					msg += "\n:결제금액: " + rsp.paid_amount
					alert(msg)
					location.href="salecheck";
				} else {
					alert("결제에 실패했습니다. " + res.error_msg)
				}
			})
		}
	</script>
</body>
</html>