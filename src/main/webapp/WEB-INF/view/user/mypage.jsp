<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/21a6628c62.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>내 정보</title>
</head>
<body>
<style>
	.btnWrap {display: flex;    
   		flex-direction: row;
        justify-content: center;
        margin: 50px 0px}
   
    .debtn {padding:10px 40px;
    	background-color: #cddc39;
    	cursor: pointer;
    	border: 1px solid #cddc39;
    	border-bottom:none}
    	
    .select {
    	background-color: #fff;
    }
    .info-table>tr, .info-table>td, .info-table>th {border: 1px solid #dedede;
		text-align: center}
	.btn-lime {background-color: #cddc39}
	.btn-gray {background-color: #d3d3d3}
	header {position: relative;
    		height:150px; 
    		background-color:#cddc39;}
	header>h3 {position:absolute;
		bottom: 5px;
		left: 5%;
		font-weight: bold;}
</style>
	<header>
		<h3>내 정보</h3>
	</header>
	<div style="width:90%; margin: 0 auto; padding:50px 0px">
		<div>
			<div class="form-group">
				<table class="w3-table-all" style="width:100%">
					<tr>
						<th>아이디</th>
						<td>${user.id }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${user.name}</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd"/></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${user.tel}</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${user.email}</td>
					</tr>
				</table>
				<div style="margin-top:10px; text-align:left;">
				<c:if test="${loginUser.id != 'admin'}">
					<a href="deleteForm?id=${user.id}" class="btn btn-gray" style="float:right; color:#000"">회원 탈퇴</a>
				</c:if>
				<c:if test="${loginUser.id == 'admin'}">
					<a href="../admin/list" class="btn btn-gray" style="float:right; color:#000">회원 목록</a>
				</c:if>
				<a href="update?id=${user.id}" style="text-decoration: none; color: #000; float:right; margin-right:10px"
					class="btn btn-lime">내 정보 변경</a>
				</div>
			</div>
		</div>
	</div>
	<div class="w3-center btnWrap" style="border-bottom: 1px solid #cddc39">
		<div id="etc" class="debtn"
			onclick="javascript:btn_div('etcInner','etc')">등록 게시글</div>
		<div id="info" class="debtn"
			onclick="javascript:btn_div('infoInner','info')">등록 댓글</div>
		<div id="pic" class="debtn"
			onclick="javascript:btn_div('picInner','pic')">캠핌장 찜</div>
		<div id="loc" class="debtn"
			onclick="javascript:btn_div('locInner','loc')">게시글 좋아요</div>
		<div id="cart" class="debtn"
			onclick="javascript:btn_div('cartInner','cart')">장바구니</div>
	</div>
	<div style="width: 90%; margin: 0 auto; margin-bottom: 80px">
		<!-- 등록 게시글 목록 -->
		<div id="etcInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class='far fa-file-alt'></i> 등록 게시글 목록
			</h3>
			<table class="w3-table info-table w3-centered">
				<tr>
					<th>제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>좋아요</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${boardlist}" var="b">
					<tr>
						<td>${b.title}</td>
						<td>${b.writer}</td>
						<td>${b.regdate}</td>
						<td></td>
						<td>${b.readcnt}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 등록 댓글 목록 -->
		<div id="infoInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class='far fa-comment-dots'></i> 등록 댓글 목록
			</h3>
			<table class="w3-table info-table w3-centered">
				<tr>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>내용</th>
				</tr>
				<c:forEach items="${commentlist}" var="com">
					<tr>
						<td>${com.writer}</td>
						<td>${com.regdate}</td>
						<td>${com.content}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 캠핑장 찜 목록 -->
		<div id="picInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class="fa fa-heart"></i> 캠핑장 찜 목록
			</h3>
			<table class="w3-table info-tabl w3-centered">
				<tr>
					<th>캠핑장 이름</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>찜</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${camplist}" var="cam">
					<tr>
						<td>${cam.facltNm}</td>
						<td>${cam.tel}</td>
						<td>${cam.addr1}</td>
						<td>${cam.regdate}</td>
						<td>${cam.content}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 게시글 좋아요 목록 -->
		<div id="locInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class="glyphicon glyphicon-thumbs-up"></i> 게시글 좋아요 목록
			</h3>
			<table class="w3-table info-table w3-centered">
				<tr>
					<th>좋아요</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${goodlist}" var="g">
					<tr>
						<td>${g.goodtype}</td>
				</c:forEach>
				<c:forEach items="${boardlist}" var="b">
						<td>${g.title}</td>
						<td>${b.writer}</td>
						<td>${b.readcnt}</td>
						<td>${b.regdate}</td>
					</tr>
				</c:forEach>
				
			</table>
		</div>
		<!-- 게시글 좋아요 목록 -->
		<div id="cartInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class='fas fa-shopping-cart'></i> 장바구니
			</h3>
			<table class="w3-table info-table w3-centered">
				<tr>
					<th>목록</th>
					<th>상품 이름</th>
					<th>상품 가격</th>
					<th>구매 수량</th>
					<th>주문하기</th>
					<th>삭제</th>
				</tr>
				<form action="../cart/delete" name="deleteform" method="GET">
					<input type="hidden" name="id" value="">
				</form>
				<form action="../cart/saleitem" name="saleform" method="post">
					<input type="hidden" name="id" value="">
					<input type="hidden" name="userid" value="${user.id}">
				</form>
				<c:forEach items="${cartlist}" var="cart">
					<tr id="del${cart.itemid}">
						<td style="width:10%">
							<img src="../img/${cart.pictureUrl}" style="width:90%">
						</td>
						<td><a href="../shop/detail?id=${cart.itemid}">
								<b style="color:#333">${cart.name}</b>
							</a>
						</td>
						<td><fmt:formatNumber value="${cart.price}" pattern="###,###"/></td>
						<td>${cart.quantity}</td>
						<td><button class="btn btn-lime"
							onclick="javascript:salelist('${cart.itemid}','${user.id}')">주문하기</button></td>
						<td>
							<button value="${cart.itemid}" class="btn btn-gray"
								onclick="javascript:deletecart(${cart.itemid})" id="btn-del">삭제</button>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<th colspan="6">
						총 구매 금액: <fmt:formatNumber value="${total}" pattern="###,###"/>원
						&emsp; <button class="btn btn-lime" onclick="javascript:allsale('${user.id}')">전체 주문하기</button>
					</th>
				</tr>
			</table>
		</div>
	</div>
	<script>
		function allsale(userid) {
			document.saleform.id.value=0;
			document.saleform.submit();
		}
		function salelist(itemid, userid) {
			document.saleform.id.value=itemid;
			document.saleform.submit();
		}
		function deletecart(itemid) {
			document.deleteform.id.value=itemid;
			document.deleteform.submit();
		}
		$(function() {
			$("#etcInner").show();
			$("#etcInner").siblings().hide();
			$("#etc").addClass("select");
		})

		function btn_div(id, tab) {
			$(".inner").each(function() {
				$(this).hide();
			})
			$(".debtn").each(function() {
				$(this).removeClass("select")
			})
			$("#" + id).show();
			$("#" + tab).addClass("select")
		}
	</script>
	<hr>
</body>
</html>