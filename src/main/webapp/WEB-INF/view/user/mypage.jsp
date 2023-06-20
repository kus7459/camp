<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
<script src="https://kit.fontawesome.com/21a6628c62.js"
	crossorigin="anonymous"></script>
	<link rel="stylesheet" href="../css/detail.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div class="w3-content" style="margin-top: 100px">
		<h3>회원아이디</h3>
		<div style="display: flex; align-items: center; margin-bottom: 10dpx;">
			<div class="form-group">
				<table class="w3-table">
					<tr>
						<td>이름</td>
						<td>이름</td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td>생년월일</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>전화번호</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>이메일</td>
					</tr>
				</table>
				<div style="margin-top:10px; text-align:left;">
				<a href="update" style="text-decoration: none; color: #000;">내 정보 변경</a>
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
	</div>
	<div style="width: 90%; margin: 0 auto; margin-bottom: 80px">
		<!-- 등록 게시글 목록 -->
		<div id="etcInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class="fas fa-duotone fa-check"></i>등록 게시글 목록
			</h3>
			<table class="w3-table info-tabl w3-centered">
				<tr>
					<th>제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>좋아요</th>
					<th>조회수</th>
				</tr>
			</table>
		</div>
		<!-- 등록 댓글 목록 -->
		<div id="infoInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class="fas fa-duotone fa-check"></i>등록 댓글 목록
			</h3>
			<table class="w3-table info-tabl w3-centered">
				<tr>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>내용</th>
				</tr>
			</table>
		</div>
		<!-- 캠핑장 찜 목록 -->
		<div id="picInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class="fas fa-duotone fa-check"></i>캠핑장 찜 목록
			</h3>
			<table class="w3-table info-tabl w3-centered">
				<tr>
					<th>캠핑장 이름</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>찜</th>
					<th>조회수</th>
				</tr>
			</table>
		</div>
		<!-- 게시글 좋아요 목록 -->
		<div id="locInner" class="inner">
			<h3 style="margin-bottom: 20px">
				<i class="fas fa-duotone fa-check"></i>게시글 좋아요 목록
			</h3>
			<table class="w3-table info-tabl w3-centered">
				<tr>
					<th>제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>좋아요</th>
					<th>조회수</th>
				</tr>
			</table>
	</div>
</div>
	<script>
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