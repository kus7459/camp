<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/search.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>캠핑장 찾기</title>
</head>
<body>
	<header>
		<h3>캠핑장 검색하기</h3>
	</header>
	<div class="w3-bar w3-black">
		<div style="width:90%; margin: 0 auto">
			<button class="w3-bar-item w3-button w3-padding btn-lime" id="deBtn">상세 검색하기</button>
			<button class="w3-bar-item w3-button w3-padding" id="theBtn">테마별 검색하기</button>
		</div>
	</div>
	<div style="border-bottom: 2px solid #cddc39;" class="wrap">
		<div class="campsearch">
			<div class="searchWrap">
				<form action="campsearch" method="post">
               <table class="w3-table" style="margin-bottom:10px">
                  <tr>
                     <th>지역</th>
                     <td id="si">
                        <select name="si" onchange="getText('si')" class="w3-input w3-border w3-round-large">
                           <option value="">시,도 선택</option>
                        </select>
                     </td>
                     <td id="gi">
                        <select name="gu" onchange="getText('gu')" class="w3-input w3-border w3-round-large">
                           <option value="">구,군 선택</option>
                        </select>
                     </td>
                     <td id="dong">
                        <select name="dong" class="w3-input w3-border w3-round-large">
                           <option value="">동,리 선택</option>
                        </select>
                     </td>
                  </tr>
                  <!-- sido ajax -->
                  <tr>
                     <th>입지 구분</th>
                     <td colspan="3">
                        <select class="w3-input w3-border w3-round-large">
                           <option>선택하세요.</option>
                           <option>산, 숲</option>
                           <option>계곡, 강, 호수</option>
                           <option>해변, 섬</option>
                           <option>도심</option>
                        </select>
                     </td>
                  </tr>
                  <tr>
                     <th>주요 시설</th>
                     <td colspan="3">
                        <select class="w3-input w3-border w3-round-large">
                           <option>선택하세요.</option>
                           <option>일반 야영장</option>
                           <option>자동차 야영장</option>
                           <option>카라반</option>
                           <option>글램핑</option>
                        </select>
                     </td>
                  </tr>
                  <tr>
                     <th>바닥 형태</th>
                     	<td colspan="3">
							<select class="w3-input w3-border w3-round-large">
	                           <option>선택하세요.</option>
	                           <option>잔디</option>
	                           <option>데크</option>
	                           <option>파쇄석</option>
	                           <option>자갈</option>
	                           <option>흙</option>
							</select>
						</td>
					</tr>
				</table>
				<table class="w3-table" id="toggleTable">
               		<tr style="line-height:3rem">
               			<th>운영형태</th>
               			<td>
               				<input type="checkbox" name=""> 지자체&emsp;
               				<input type="checkbox" name=""> 국립공원&emsp;
               				<input type="checkbox" name=""> 자연휴양림&emsp;
               				<input type="checkbox" name=""> 국민 여가&emsp;
               				<input type="checkbox" name=""> 민간&emsp;
               			</td>
               		</tr>
               		<tr style="line-height:3rem">
               			<th style="width:20%">테마</th>
               			<td>
               				<input type="checkbox" name=""> 일출명소&emsp;
               				<input type="checkbox" name=""> 일몰명소&emsp;
               				<input type="checkbox" name=""> 수상레저&emsp;
               				<input type="checkbox" name=""> 항공레저&emsp;
               				<input type="checkbox" name=""> 스키&emsp;
               				<input type="checkbox" name=""> 낚시&emsp;
               				<input type="checkbox" name=""> 액티비티&emsp;
               				<input type="checkbox" name=""> 봄 꽃여행&emsp;
               				<input type="checkbox" name=""> 여름 물놀이&emsp;
               				<input type="checkbox" name=""> 가을 단풍명소&emsp;
               				<input type="checkbox" name=""> 겨울 눈꽃명소&emsp;
               				<input type="checkbox" name=""> 걷기길&emsp;
               			</td>
               		</tr>
               		<tr style="line-height:3rem">
               			<th style="width:20%">부대시설</th>
               			<td>
               				<input type="checkbox" name=""> 전기&emsp;
               				<input type="checkbox" name=""> 무선 인터넷&emsp;
               				<input type="checkbox" name=""> 장작 판매&emsp;
               				<input type="checkbox" name=""> 온수&emsp;
               				<input type="checkbox" name=""> 트렘폴린&emsp;
               				<input type="checkbox" name=""> 물놀이장&emsp;
               				<input type="checkbox" name=""> 놀이터&emsp;
               				<input type="checkbox" name=""> 산책로&emsp;
               				<input type="checkbox" name=""> 운동장&emsp;
               				<input type="checkbox" name=""> 운동 시설&emsp;
               				<input type="checkbox" name=""> 마트, 편의점&emsp;
               			</td>
               		</tr>
               		<tr style="line-height:3rem">
               			<th style="width:20%">기타정보</th>
               			<td>
               				<input type="checkbox" name=""> 개인 카라반 가능&emsp;
               				<input type="checkbox" name=""> 반려동물 동반 가능&emsp;
               			</td>
               		</tr>
				</table>
				<div class="w3-center" style="padding-top:20px">
					<input type="submit" value="검색하기" class="btn btn-lime">
					<input type="button" value="상세검색"   class="btn w3-light-grey" id="deSearch">
				</div>
            </form>
         </div>
	</div>
	<!-- 테마,태그별 검색 -->
   <!-- 테마별, 태그별 캠핑장 찾기 -->
	<div class="page page4 w3-center">
		<h3>테마별, 태그별 캠핑장 찾기</h3>
		<div class="w3-center" style="padding-top:30px">
			<button class="btn btn-white">#봄 꽃여행</button>
			<button class="btn btn-white">#여름 물놀이</button>
			<button class="btn btn-white">#가을 단풍명소</button>
			<button class="btn btn-white">#겨울 눈꽃명소</button>
			<button class="btn btn-white">#걷기길</button>
			<button class="btn btn-white">#일출명소</button>
			<button class="btn btn-white">#일몰명소</button>
		</div>
		<div class="w3-center" style="padding:20px 0px">
			<button class="btn btn-white">#스키</button>
			<button class="btn btn-white">#낚시</button>
			<button class="btn btn-white">#수상레저</button>
			<button class="btn btn-white">#액티비티</button>
			
			<button class="btn btn-white">#반려견 동반</button>
			
			<button class="btn btn-white">#농촌체험</button>
			<button class="btn btn-white">#해수욕</button>
			<button class="btn btn-white">#어린이 놀이시설</button>
		</div>
		<div class="w3-center" style="padding-top:20px">
			<input type="submit" value="검색하기" class="btn btn-lime">
		</div>
   </div>
</div>
<!-- 리스트 보여주기 -->
<div class="campAll" style="width:90%; margin:0 auto; margin-top:50px">
	<h3>캠핑장 목록</h3>
	<div class="listWrap">
		<div class="thumbImg">
			<img src="${path}/img/main_1.jpg">
			<ul class="imgli">
				<li style="margin-right:5px">
					<button class="btn btn-white">
						<i class="glyphicon glyphicon-thumbs-up" style="color:blue"></i> <b>추천</b>
					</button>
				</li>
				<li>
					<button class="btn btn-white">
						<i class="fa fa-heart" style="color:red"></i> <b>찜하기</b>
					</button>
				</li>
			</ul>
		</div>
		<div class="campInfo">
			<h4><a href="${path}/site/detail?">[인천 000 │ 캠핑장 이름]</a></h4>
			<b>일몰과 바다 전망이 ... 한줄 소개 넣고</b>
			<p>솔섬오토캠핑장은 별주부전 테마파크가 있는 사천시 비토섬 인근 해안에 위치하고 있는 캠핑장이다. 바닥은 파쇄석으로 되어... 상세 소개 넣고</p>
			<ul class="infoli">
				<li>
					<i class='fas fa-map-marked-alt' id="infoIcon"></i>
					&emsp;경남 사천시 서포면 토끼로 어쩌고 주소 넣고
				</li>
				<li>
					<i class='fas fa-phone-volume' id="infoIcon"></i>
					&emsp;055-854-0404 전화번호 넣고
				</li>
			</ul>
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
	</div>
</div>
<script>
	$("#toggleTable").hide();
	$("#deSearch").click(function(){
		$("#toggleTable").slideToggle();
	})
	
	$(".page4").hide();
	$("#deBtn").click(function(){
		$(".campsearch").show();
		$(".page4").hide();
		$(this).addClass("btn-lime")
		$(this).siblings().removeClass("btn-lime")
	})
	$("#theBtn").click(function(){
		$(".page4").show();
		$(".campsearch").hide();
		$(this).addClass("btn-lime")
		$(this).siblings().removeClass("btn-lime")
	})
	
	$(".btn").click(function(){
		if($(this).hasClass("on") == true) {
			$(this).removeClass("on")
		} else if ( $(this).hasClass("on") == false) {
			$(this).addClass("on")
		}
	})
</script>
</body>
</html>