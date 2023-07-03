<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<div style="width: 90%; margin: 0 auto">
			<button class="w3-bar-item w3-button w3-padding btn-lime" id="deBtn">상세
				검색하기</button>
			<button class="w3-bar-item w3-button w3-padding" id="theBtn">테마별
				검색하기</button>
		</div>
	</div>
	<div style="border-bottom: 2px solid #cddc39;" class="wrap">
		<div class="campsearch">
			<div class="searchWrap">
				<form action="search" method="post" name="f">
					<input type="hidden" name="pageNum" value="1">
					<input type="hidden" name="sort" value="${params.sort}">
					
					<input type="hidden" name="themelist" value="${params.themelist}">
					<input type="hidden" name="addlist" value="${params.addlist}">
					<input type="hidden" name="carav" value="${params.carav}">
					<input type="hidden" name="pet" value="${params.pet}">
					<script type="text/javascript">
					</script>
					<table class="w3-table" style="margin-bottom: 10px">
						<tr>
							<th>지역</th>
							<td id="si"><select name="si" onchange="getText('si')"
								class="w3-input w3-border w3-round-large">
									<option value="">시,도 선택</option>
							</select></td>
							<td id="gi"><select name="gu" onchange="getText('gu')"
								class="w3-input w3-border w3-round-large">
									<option value="">구,군 선택</option>
							</select></td>
						</tr>
						<!-- sido ajax -->
						<tr>
							<th>입지 구분</th>
							<td colspan="3"><select
								class="w3-input w3-border w3-round-large" name="loc">
									<option value="">선택하세요.</option>
									<option>산,숲</option>
									<option>계곡,강,호수</option>
									<option>해변,섬</option>
									<option>도심</option>
							</select> <script>
								f.loc.value = "${param.loc}";
							</script></td>
						</tr>
						<tr>
							<th>주요 시설</th>
							<td colspan="3"><select
								class="w3-input w3-border w3-round-large" name="csite">
									<option value="">선택하세요.</option>
									<option>일반야영장</option>
									<option>자동차야영장</option>
									<option>카라반</option>
									<option>글램핑</option>
							</select> <script>
								f.csite.value = "${param.csite}";
							</script></td>
						</tr>
						<tr>
							<th>바닥 형태</th>
							<td colspan="3"><select
								class="w3-input w3-border w3-round-large" name="bot">
									<option value="">선택하세요.</option>
									<option>잔디</option>
									<option>파쇄석</option>
									<option>데크</option>
									<option>자갈</option>
									<option>흙</option>
							</select> <script>
								f.bot.value = "${param.bot}";
							</script></td>
						</tr>
					</table>
					<table class="w3-table" id="toggleTable">
						<tr style="line-height: 3rem">
							<th>운영형태</th>
							<td><input type="checkbox" name="oper" value="지자체"> 지자체&emsp; <input
								type="checkbox" name="oper" value="국립공원"> 국립공원&emsp; <input
								type="checkbox" name="oper" value="자연휴양림"> 자연휴양림&emsp; <input
								type="checkbox" name="oper" value="국민여가" > 국민 여가&emsp; <input
								type="checkbox" name="oper" value="민간" <c:if test="${fn:contains(params.operlist,'민간')}">checked</c:if>> 민간&emsp;</td>
						</tr>
						<tr style="line-height: 3rem">
							<th style="width: 20%">테마</th>
							<td><input type="checkbox" name="theme" value="일출명소"> 일출명소&emsp;
								<input type="checkbox" name="theme" value="일몰명소"> 일몰명소&emsp; <input
								type="checkbox" name="theme" value="수상레저"> 수상레저&emsp; <input
								type="checkbox" name="theme" value="항공레저"> 항공레저&emsp; <input
								type="checkbox" name="theme" value="스키"> 스키&emsp; <input
								type="checkbox" name="theme" value="낚시"> 낚시&emsp; <input
								type="checkbox" name="theme" value="액티비티"> 액티비티&emsp; <input
								type="checkbox" name="theme" value="봄꽃여행"> 봄 꽃여행&emsp; <input
								type="checkbox" name="theme" value="여름물놀이"> 여름 물놀이&emsp; <input
								type="checkbox" name="theme" value="가을단풍명소"> 가을 단풍명소&emsp; <input
								type="checkbox" name="theme" value="겨울눈꽃명소"> 겨울 눈꽃명소&emsp; <input
								type="checkbox" name="theme" value="걷기길"> 걷기길&emsp;</td>
						</tr>
						<tr style="line-height: 3rem">
							<th style="width: 20%">부대시설</th>
							<td><input type="checkbox" name="add" value="전기"> 전기&emsp; <input
								type="checkbox" name="add" value="무선인터넷"> 무선 인터넷&emsp; <input
								type="checkbox" name="add" value="장작판매"> 장작 판매&emsp; <input
								type="checkbox" name="add" value="온수"> 온수&emsp; <input
								type="checkbox" name="add" value="트램폴린"> 트렘폴린&emsp; <input
								type="checkbox" name="add" value="물놀이장"> 물놀이장&emsp; <input
								type="checkbox" name="add" value="놀이터"> 놀이터&emsp; <input
								type="checkbox" name="add" value="산책로"> 산책로&emsp; <input
								type="checkbox" name="add" value="운동장"> 운동장&emsp; <input
								type="checkbox" name="add" value="운동시설"> 운동 시설&emsp; <input
								type="checkbox" name="add" value="마트.편의점"> 마트, 편의점&emsp;</td>
						</tr>
						<tr style="line-height: 3rem">
							<th style="width: 20%">기타정보</th>
							<td><input type="checkbox" name="etc" value="카라반"> 개인 카라반
								가능&emsp; <input type="checkbox" name="etc" value="반려동물"> 반려동물 동반
								가능&emsp;</td>
						</tr>
					</table>
					<div class="w3-center" style="padding-top: 20px">
						<input type="submit" value="검색하기" class="btn btn-lime"> <input
							type="button" value="상세검색" class="btn w3-light-grey"
							id="deSearch">
					</div>
				</form>
			</div>
		</div>
		<!-- 테마,태그별 검색 -->
		<!-- 테마별, 태그별 캠핑장 찾기 -->
		<form action="search2" method="post" name="f2">
		<input type="hidden" value="${themelist}" name="themelist">
		<input type="hidden" value="${aroundlist}" name="aroundlist">
		<input type="hidden" name="pageNum" value="1">
		<input type="hidden" name="sort" value="${params.sort}">
		<div class="page page4 w3-center">
			<h3>테마별, 태그별 캠핑장 찾기</h3>
			<div class="w3-center" style="padding-top: 30px">
				<button type="button" class="btn btn-white 	<c:if test="${fn:contains(themelist,'봄꽃여행')}">on</c:if>" onclick="func(this)" value="봄꽃여행">#봄꽃 여행</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="여름물놀이">#여름 물놀이</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="가을단풍명소">#가을 단풍명소</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="겨울눈꽃명소">#겨울 눈꽃명소</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="걷기길">#걷기길</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="일출명소">#일출명소</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="일몰명소">#일몰명소</button>
			</div>
			<div class="w3-center" style="padding: 20px 0px">
				<button type="button" class="btn btn-white" onclick="func(this)" value="스키">#스키</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="낚시">#낚시</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="수상레저">#수상레저</button>
				<button type="button" class="btn btn-white" onclick="func(this)" value="액티비티">#액티비티</button>

				<button type="button" class="btn btn-white" onclick="func(this)" value="반려동물">#반려동물 동반</button>

				<button type="button" class="btn btn-white" onclick="func2(this)" value="농어촌체험시설">#농촌체험</button>
				<button type="button" class="btn btn-white" onclick="func2(this)" value="해수욕">#해수욕</button>
				<button type="button" class="btn btn-white" onclick="func2(this)" value="어린이놀이시설">#어린이 놀이시설</button>
			</div>
			<div class="w3-center" style="padding-top: 20px">
				<input type="submit" value="검색하기" class="btn btn-lime">
			</div>
		</div>
		</form>
	</div>
	<!-- 리스트 보여주기 -->
	<div class="campAll"
		style="width: 90%; margin: 0 auto; margin-top: 50px">
		<h3>캠핑장 목록(${listcount}건)</h3>
		<hr>
		<div>
			<select id="sort" name="sortselect">
			<c:if test="${params.sort == null || params.sort == ''}">
				<option value="기본순">기본순</option>
				<option value="조회순">조회순</option>
				<option value="추천순">추천순</option>
			</c:if>
			<c:if test="${params.sort == '기본순' }">
				<option value="기본순">기본순</option>
				<option value="조회순">조회순</option>
				<option value="추천순">추천순</option>
			</c:if>
			<c:if test="${params.sort == '조회순' }">
				<option value="조회순">조회순</option>
				<option value="기본순">기본순</option>
				<option value="추천순">추천순</option>
			</c:if>
			<c:if test="${params.sort == '추천순' }">
				<option value="추천순">추천순</option>
				<option value="기본순">기본순</option>
				<option value="조회순">조회순</option>
			</c:if>
			</select>
		</div>
		<hr>
		<c:if test="${empty camplist}">
			<div class="w3-center" style="margin-bottom:20px">
			검색 결과과 없습니다.
			</div>
		</c:if>
		<c:if test="${!empty camplist}">
		<c:forEach var="c" items="${camplist}">
			<div class="listWrap">
				<div class="thumbImg">
					<c:if test="${c.firstImageUrl != null}">
						<img src="${c.firstImageUrl}">
					</c:if>
					<c:if test="${c.firstImageUrl == ''}">
						<img src="${path}/img/campimg.jpg" width="279px" height="186px">
					</c:if>
					<ul class="imgli">
						<li style="margin-right: 5px">
							<button class="btn btn-white">
								<i class="glyphicon glyphicon-thumbs-up" style="color: blue"></i>
								<b>추천</b>
							</button>
						</li>
						<li>
								<i class="fa fa-heart" style="color: red;"></i> <b>찜 ${c.lovecnt}&nbsp;&nbsp;</b>
						</li>
						<li>
							<b>조회수 : ${c.cnt}</b>	
						</li>
					</ul>
				</div>
				<div class="campInfo">
					<h4>
						<a href="${path}/site/detail?contentId=${c.contentId}">[${c.doNm} ${c.sigunguNm} │
							${c.facltNm}]</a>
					</h4>
					<b>${c.lineIntro}</b>
					<p>${c.intro}</p>
					<ul class="infoli">
						<li><i class='fas fa-map-marked-alt' id="infoIcon"></i>
							&emsp;${c.addr1}</li>
						<li><i class='fas fa-phone-volume' id="infoIcon"></i>
							&emsp;${c.tel}</li>
					</ul>
					<c:if test="${c.sbrsCl != null }">
						<div class="faciWrap">
							<c:if test="${fn:contains(c.sbrsCl,'무선인터넷')}">
								<div>
									<i class='fas fa-wifi' id="wifi"></i>
									<p>와이파이</p>
								</div>
							</c:if>
							<c:if test="${fn:contains(c.sbrsCl,'전기')}">
								<div>
									<i class='far fa-lightbulb' id="light"></i>
									<p>전기</p>
								</div>
							</c:if>
							<c:if test="${fn:contains(c.sbrsCl,'마트.편의점')}">
								<div>
									<i class='fas fa-shopping-cart' id="shop"></i>
									<p>마트,편의점</p>
								</div>
							</c:if>
							<c:if test="${fn:contains(c.sbrsCl,'온수')}">
								<div>
									<i class='fas fa-tint' id="tint"></i>
									<p>온수</p>
								</div>
							</c:if>
							<c:if test="${fn:contains(c.sbrsCl,'산책로')}">
								<div>
									<i class='fas fa-route' id="route"></i>
									<p>산책로</p>
								</div>
							</c:if>
							<c:if test="${fn:contains(c.sbrsCl,'물놀이장')}">
								<div>
									<i class='fas fa-swimming-pool' id="pool"></i>
									<p>수영장</p>
								</div>
							</c:if>
							<c:if test="${c.animalCmgCl !='불가능'}">
								<div>
									<i class='fas fa-dog' id="dog"></i>
									<p>반려동물</p>
								</div>
							</c:if>
						</div>
					</c:if>
				</div>
			</div>
		</c:forEach>
		<tr><td colspan="6" class="w3-center">
			<c:if test="${pageNum > 1 }">
				<a href="javascript:listpage('${pageNum-1}','${search}')">[이전]</a>
			</c:if>
			<c:if test="${pageNum <=1 }">[이전]</c:if>
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a==pageNum }">[${a}]</c:if>
				<c:if test="${a != pageNum }">
				<a href="javascript:listpage('${a}','${search}')">[${a}]</a></c:if>
			</c:forEach>
			<c:if test="${pageNum < maxpage }">
				<a href="javascript:listpage('${pageNum+1 }','${search}')">[다음]</a>
			</c:if>
			<c:if test="${pageNum >= maxpage}">[다음]</c:if>	
			</td></tr>
		</c:if>
	</div>
	<script>
		$("#toggleTable").hide();
		$("#deSearch").click(function() {
			$("#toggleTable").slideToggle();
		})

		$(".page4").hide();
		$(function(){
			if(${search} == 2){
				$(".page4").show();
				$(".campsearch").hide();
				$("#theBtn").addClass("btn-lime")
				$("#theBtn").siblings().removeClass("btn-lime")
			}
			if(${search} == 1){
				$(".page4").hide();
				$(".campsearch").show();
				$("#deBtn").addClass("btn-lime")
				$("#deBtn").siblings().removeClass("btn-lime")
			}
		})
		$("#deBtn").click(function() {
			$(".campsearch").show();
			$(".page4").hide();
			$(this).addClass("btn-lime")
			$(this).siblings().removeClass("btn-lime")
		})
		$("#theBtn").click(function() {
			$(".page4").show();
			$(".campsearch").hide();
			$(this).addClass("btn-lime")
			$(this).siblings().removeClass("btn-lime")
		})

		$(".btn").click(function() {
			if ($(this).hasClass("on") == true) {
				$(this).removeClass("on")
			} else if ($(this).hasClass("on") == false) {
				$(this).addClass("on")
			}
		})	
		let theme = "";
		if(${themelist !=null}){
			theme = '${themelist}';
			console.log(theme)
		}
		let around ="";
		function func(val){
			if(!theme.includes(val.value)){
				theme += val.value+","
			}else if(theme.includes(val.value)){
				theme = theme.replace(val.value,'')
			}
			document.f2.themelist.value=theme
			console.log(theme)
		}
		function func2(val){
			if(!around.includes(val.value)){
				around += val.value+","
			}else if(around.includes(val.value)){
				around = around.replace(val.value+",",'')
			}
			document.f2.aroundlist.value=around
			console.log(around)
		}
		function listpage(page,search){
			if(search == 1){
				document.f.pageNum.value=page;
				document.f.submit();
			}
			if(search == 2){
				document.f2.pageNum.value=page;
				document.f2.submit();
			}
		}
		$("#sort").change(function(){
			if(${search}==1){
				if($(this).val() == '조회순'){
					document.f.sort.value='조회순';
					document.f.submit();
				}
				if($(this).val() == '기본순'){
					document.f.sort.value='';
					document.f.submit();
				}
				if($(this).val() == '추천순'){
					document.f.sort.value='추천순';
					document.f.submit();
				}
			}
			if(${search}==2){
				if($(this).val() == '조회순'){
					document.f2.sort.value='조회순';
					document.f2.submit();
				}
				if($(this).val() == '기본순'){
					document.f2.sort.value='';
					document.f2.submit();
				}
				if($(this).val() == '추천순'){
					document.f2.sort.value='추천순';
				}
			}
		})
	</script>
</body>
</html>