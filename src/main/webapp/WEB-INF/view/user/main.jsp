<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../css/main.css">
<script src="https://kit.fontawesome.com/21a6628c62.js" crossorigin="anonymous"></script>
<title>GOOD Camping 홈페이지</title>
</head>
<body>
   <!-- main -->
   <div class="animation_canvas">
        <div class="slider_panel">
            <img src="../img/main_1.jpg" alt="" class="slider_image">
            <img src="../img/main_2.jpg" alt="" class="slider_image">
            <img src="../img/main_3.jpg" alt="" class="slider_image">
            <img src="../img/main_4.jpg" alt="" class="slider_image">
            <img src="../img/main_5.jpg" alt="" class="slider_image">
        </div>
    </div>
   <div class="slider_text_panel">
        <div class="slider_text">
            <h1>사막 이미지</h1>
            <p>더운 사막</p>
        </div>
        <div class="slider_text">
            <h1>수국 이미지</h1>
            <p>물에서 자라는 수생식물</p>
        </div>
        <div class="slider_text">
            <h1>해파리 이미지</h1>
            <p>해파리는 독이 있다</p>
        </div>
        <div class="slider_text">
            <h1>코알라 이미지</h1>
            <p>코알라는 유칼리나무잎만 먹는다</p>
        </div>
        <div class="slider_text">
            <h1>등대 이미지</h1>
            <p>이건 그냥 등대 이미지</p>
        </div>
    </div>
        <div class="control_panel">
        <div class="control_button"></div>
        <div class="control_button"></div>
        <div class="control_button"></div>
        <div class="control_button"></div>
        <div class="control_button"></div>
    </div>
    
   <!-- 검색, 채팅 -->
   <div class="page page2">
      <div class="campsearch">
         <h3>캠핑장 찾기</h3>
         <div class="searchWrap">
            <form action="campsearch" method="post">
               <table class="w3-table">
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
                  <tr>
                     <th>가격대</th>
                     <td colspan="3">
                        <select class="w3-input w3-border w3-round-large">
                           <option>선택하세요</option>
                           <option>전체</option>
                           <option>2만원 이하</option>
                           <option>2만원 ~ 5만원</option>
                           <option>5만원 ~ 8만원</option>
                           <option>8만원 이상</option>
                        </select>
                     </td>
                  </tr>
               </table>
               <div class="w3-center" style="padding-top:20px">
                  <input type="submit" value="검색하기" class="btn btn-white">
                  <input type="button" value="상세검색"   class="btn w3-light-grey">
               </div>
            </form>
         </div>
      </div>
      <div class="chat">
         <h3>채팅</h3>         
         <div class="chatting">
         </div>
         <div class="chatInput">
            <input type="text" 
            class="w3-input w3-border w3-round-large">
            <button class="btn btn-lime">전송</button>
         </div>
      </div>
   </div>
   <!-- 인기 캠핑장 -->
   <div class="page3 w3-center">
      <h3>회원들이 추천한 인기 캠핑장</h3>
      <div class="popWrap">
         <div class="popImg pImg1"></div>
         <div class="popImg pImg2"></div>
         <div class="popImg pImg3"></div>
      </div>
      <input type="button" value="인기 캠핑장 더보기" class="btn btn-white">
   </div>
   
   <!-- 테마별, 태그별 캠핑장 찾기 -->
	<div class="page page4 w3-center">
		<h3>테마별, 태그별 캠핑장 찾기</h3>
		<div class="w3-center" style="padding-top:30px">
			<button class="btn btn-white" onclick="change_btn(event)">#봄 꽃여행</button>
			<button class="btn btn-white" onclick="change_btn(event)">#여름 물놀이</button>
			<button class="btn btn-white" onclick="change_btn(event)">#가을 단풍명소</button>
			<button class="btn btn-white" onclick="change_btn(event)">#겨울 눈꽃명소</button>
			<button class="btn btn-white" onclick="change_btn(event)">#반려견 동반</button>
		</div>
		<div class="w3-center" style="padding:20px 0px">
			<button class="btn btn-white">#일출명소</button>
			<button class="btn btn-white">#일몰명소</button>
			<button class="btn btn-white">#스키</button>
			<button class="btn btn-white">#낚시</button>
			<button class="btn btn-white">#산책로</button>
		</div>
		<div class="w3-center" style="padding-top:20px">
			<input type="submit" value="검색하기" class="btn btn-lime">
			<input type="button" value="상세검색" class="btn w3-light-grey">
		</div>
   </div>
   
   <!-- 게시물 -->
   <div class="page page5">
      <div>
         <h3>인기 게시물</h3>
         <table class="w3-table">
            <tr style="background-color: #cddc39;">
               <th>게시판</th>
               <th>작성자</th>
               <th>내용</th>
               <th>조회수</th>
            </tr>
         </table>
      </div>
      <div>
         <h3>자유 게시판<a href="" id="more">+</a></h3>
         <table class="w3-table">
            <tr style="background-color: #cddc39;">
               <th>게시판</th>
               <th>작성자</th>
               <th>내용</th>
               <th>조회수</th>
            </tr>
         </table>
      </div>
   </div>
   
   <script>
      $(function(){
            $(".control_button").each(function(index){
                $(this).attr("idx",index);  // 인덱스 추가
            }).click(function(){
                let index = $(this).attr("idx");    // idx 속성값 
                moveSlider(index);      // -> index 0~4
            })
        
            $(".slider_text").css("left",-300).each(function(index){
                $(this).attr("idx",index);
            });
            moveSlider(0);  // index 0으로 시작 첫번째 이미지부터 보여줌
            let idx = 0;
            let inc = 1;
            setInterval(function(){
                if(idx >=4 ) {
                    inc = -1;
                }
                if(idx <=0) {
                    inc =1;
                }
                idx += inc;
                moveSlider(idx);
            },2000)
            
            getSido()
        })
        
        function moveSlider(index) {
             let winWidth = document.body.offsetWidth;
         let moveLeft = -(index *winWidth);       // 0~2400까지
            $(".slider_panel").animate({left:moveLeft},'slow'); 
            $(".control_button[idx ="+index +"]").addClass("select");    // 파란 점으로 표시
            $(".control_button[idx!="+index+"]").removeClass("select");
                // idx에 해당하는 글자부분 보여주고
            $(".slider_text[idx="+index+"]").show().animate({
                left : 0
            },'slow')
                // idx에 해당하지 않는 부분 숨기고
            $(".slider_text[idx!="+index+"]").hide('slow',function(){
                $(this).css("left",-300);
            })
        }
   
      // 지역 선택
      function getSido() { // 서버에서 문자열로 전달 받기
         $.ajax({
            url : "${path}/ajax/select",
            success : function(data) {
               console.log(data) // data : [서울특별시, ... 제주특별자치도], 문자열. 배열 아님.
               // data를 배열로 만들어서 처리.      [ 다음부터 ] 앞까지 , 로 분리   => arr: 배열
               let arr = data.substring(data.indexOf("[") + 1,
                     data.indexOf("]")).split(",");
               $.each(arr, function(i, item) {
                  $("select[name=si]").append(function() {
                     return "<option>" + item + "</option>"
                  })
               })
            }
         })
      }
      function getText(name) { //si : 시도 선택, gu:구군 선택
         let city = $("select[name='si']").val();
         let gun = $("select[name='gu']").val();
         let disname;
         let toptext = "구, 군 선택";
         let params = "";

         if (name == "si") { // 시, 도를 선택한 경우
            params = "si=" + city.trim(); // city(시,도)만 넣어주고
            disname = "gu";
         } else if (name == "gu") { // 구, 군을 선택한 경우
            params = "si=" + city.trim() + "&gu=" + gun.trim(); // si와 gu를 같이 넣어주고 
            disname = "dong"; // select 영역은 dong, 
            toptext = "동, 리 선택";
         } else { // 다 아니면 아무것도 하지 마
            return;
         }
         $.ajax({
            url : "${path}/ajax/select",
            type : "POST",
            data : params,
            success : function(arr) {
               $("select[name=" + disname + "] option").remove(); // 시를 선택했으면 출력 select 태그의 option 객체를 제거해라. 
               $("select[name=" + disname + "]").append(function() { // append가 돼서 제거를 안 하면 계속 출력 됨
                  return "<option value=''>" + toptext + "</option>"
               })
               $.each(arr, function(i, item) { // 서버에서 전송 받은 배열값을 option 객체에 추가
                  $("select[name=" + disname + "]").append(function() {
                     return "<option>" + item + "</option>"
                  })
               })
            }
         })
      }
 		
    </script>
</body>
</html>