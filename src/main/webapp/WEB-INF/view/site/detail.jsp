<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/detail.css">
<script src="https://kit.fontawesome.com/21a6628c62.js" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>캠핑장 상세 정보</title></head>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div style="width:90%; margin: 0 auto; padding-bottom:60px">
		<div class="wrap">
			<div class="mainImg">
			
			</div>
			<div class="info">
				<h3>(이름) 캠핑장</h3>	
				<table class="w3-table w3-bordered" 
					style="border-top: 2px solid #cddc39; border-bottom: 2px solid #cddc39;">
					<tr>
					<th>주소</th>
						<td>인천 서구 정진로 500 (오류동)</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>032-567-7847</td>
					</tr>
					<tr>
						<th>캠핑장 환경</th>
						<td>강,도심 / 지자체</td>
					</tr>
					<tr>
						<th>캠핑장 유형</th>
						<td>일반 야영장, 카라반</td>
					</tr>
					<tr>
						<th>운영 기간</th>
						<td>봄, 여름, 가을, 겨울</td>
					</tr>
					<tr>
						<th>운영 일</th>
						<td>평일, 주말</td>
					</tr>
					<tr>
						<th>홈페이지</th>
						<td><a href="http://www.gocamping.or.kr" target="_blank">www.gocamping.or.kr</a></td>
					</tr>
				</table>
				<div style="margin-top:15px">
					<button class="btn btn-white"><i class="glyphicon glyphicon-thumbs-up" style="color:blue"></i> <b>추천</b></button>
					<button class="btn btn-white"><i class="fa fa-heart" style="color:red"></i> <b>찜하기</b></button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 상세 안내 -->
	<div class="faci">
		<h3 style="margin-bottom:45px">부대시설</h3>
		<div class="faciWrap">
			<div>
				<i class='fas fa-wifi' id="wifi"></i>
				<p>와이파이</p>
			</div>
			<div>
				<i class='far fa-lightbulb' id="light"></i>
				<p>전기</p>
			</div>
			<div>
				<i class='fas fa-shopping-cart' id="shop"></i>	
				<p>마트,편의점</p>
			</div>
			<div>
				<i class='fas fa-tint' id="tint"></i>
				<p>온수</p>
			</div>
			<div>
				<i class='fas fa-route' id="route"></i>
				<p>산책로</p>
			</div>
			<div>
				<i class='fas fa-swimming-pool' id="pool"></i>
				<p>수영장</p>
			</div>
			<div>
				<i class='fas fa-dog' id="dog"></i>
				<p>반려동물</p>
			</div>
		</div>
	</div>
	
	<div class="w3-center btnWrap" style="border-bottom: 1px solid #cddc39">
		<div id="etc" class="debtn" 
			onclick="javascript:btn_div('etcInner','etc')">기타 주요시설</div>
		<div id="info" class="debtn"
			onclick="javascript:btn_div('infoInner','info')">이용 안내</div>
		<div id="pic" class="debtn"
			 onclick="javascript:btn_div('picInner','pic')">전경 사진</div>
		<div id="loc" class="debtn"
			 onclick="javascript:btn_div('locInner','loc')">위치 안내</div>
	</div>
	<div style="width:90%; margin: 0 auto; margin-bottom:80px">
		<!-- 기타 주요시설 -->
		<div id="etcInner" class="inner">
			<h3 style="margin-bottom:20px"><i class="fas fa-duotone fa-check"></i> 기타 주요 시설 안내</h3>
			<table class="w3-table w3-bordered" 
					style="border-top: 2px solid #cddc39; border-bottom: 2px solid #cddc39;">
				<tr>
					<th>주요시설</th>
					<td>자동차 야영장 사이트</td>
				</tr>
				<tr>
					<th>기타 정보</th>
					<td>개인 트레일러 입장 가능, 반려동물 동반 불가능</td>
				</tr>
				<tr>
					<th>기타 부대시설</th>
					<td>바다 사이드 쪽은 카라반, 트레일러 입장 금지</td>
				</tr>
				<tr>
					<th>바닥 형태(단위: 면)</th>
					<td>파쇄석 (30)</td>
				</tr>
				<tr>
					<th>캠핑 장비 대여</th>
					<td>텐트, 릴선, 화로대, 난방기구, 식기, 침낭</td>
				</tr>
				<tr>
					<th>화로대</th>
					<td>게뱔</td>
				</tr>
				<tr>
					<th>안전 시설 현황</th>
					<td>소화기(20) 방화수(1)</td>
				</tr>
			</table>
		</div>	
		<!-- 이용 안내 -->
		<div id="infoInner" class="inner">
			<h3 style="margin-bottom:20px"><i class="far fa-calendar-alt"></i> 이용 안내</h3>
			<table class="w3-table info-tabl w3-centered">
				<tr style="background-color:#cddc39;">
					<th rowspan="2" style="vertical-align: middle;">구분</th>
					<th colspan="2">비수기</th>
					<th colspan="2">성수기</th>
				</tr>
				<tr>
					<th>주중</th>
					<th>주말</th>
					<th>주중</th>
					<th>주말</th>
				</tr>
				<tr>
					<th>오토캠핑</th>
					<td>25,000 ~ 30,000</td>
					<td>0</td>
					<td>35,000 ~ 40,000</td>
					<td>0</td>
				</tr>
			</table>
		</div>
		<!-- 전경 사진 -->
		<div id="picInner" class="inner">
		<!-- Work Section -->
			<div id="work">
			  <h3><i class='far fa-image'></i> 전경 사진</h3>
			 <!-- <p class="w3-center w3-large">What we've done for people</p> --> 
			
			  <div class="w3-row-padding" style="margin-top:30px">
			    <div class="w3-col l3 m6">
			      <img src="../img/main_1.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A microphone">
			    </div>
			    <div class="w3-col l3 m6">
			      <img src="../img/main_2.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A phone">
			    </div>
			    <div class="w3-col l3 m6">
			      <img src="../img/main_3.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A drone">
			    </div>
			    <div class="w3-col l3 m6">
			      <img src="../img/main_4.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="Soundbox">
			    </div>
			  </div>
			
			  <div class="w3-row-padding w3-section">
			    <div class="w3-col l3 m6">
			      <img src="../img/main_5.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A tablet">
			    </div>
			    <div class="w3-col l3 m6">
			      <img src="../img/main_4.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A camera">
			    </div>
			    <div class="w3-col l3 m6">
			      <img src="../img/main_1.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A typewriter">
			    </div>
			    <div class="w3-col l3 m6">
			      <img src="../img/main_2.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A tableturner">
			    </div>
			  </div>
			</div>

		</div>
		<!-- 위치 정보 -->
		<div id="locInner" class="inner w3-center">
			<h4>(이름) 캠핑장</h4>
			<p style="margin-bottom:15px">인천 서구 정진로 500 (오류동)</p>
		<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3161.1745599682176!2d126.62549048507076!3d37.598050550217614!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c80682f83e31d%3A0x6adacb4d5ad65309!2z7J247LKc6rSR7Jet7IucIOyEnOq1rCDsmKTrpZjrj5kgNTAwLTE!5e0!3m2!1sko!2skr!4v1687094043898!5m2!1sko!2skr" 
		width="100%" height="450" style="border:0;" allowfullscreen="" 
		loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
		</div>
	</div>

	<script>
		$(function(){
			$("#etcInner").show();
			$("#etcInner").siblings().hide();
			$("#etc").addClass("select");
		})
		
		function btn_div(id, tab) {
			$(".inner").each(function(){
				$(this).hide();
			})
			$(".debtn").each(function(){
				$(this).removeClass("select")
			})
			$("#"+id).show();
			$("#"+tab).addClass("select")
		}
	
	</script>
</body>
</html>