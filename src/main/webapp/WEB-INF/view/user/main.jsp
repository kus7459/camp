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
<style>
	.on {background-color:#cddc39;}

</style>
	<!-- main -->
	<div id="wrapper">
		<div style="left:0"></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
	</div>
	
    <div class="w3-center" 
    style="padding:15px 0px; font-size:16px; font-weight: bold; 
    cursor: pointer; background-color: WhiteSmoke; color:#333"
    onclick="location.href='../site/search'">
    	캠핑장 더 보기
    </div>
   <!-- 검색, 채팅 -->
   <div class="page page2">
      <div class="campsearch">
         <h3>캠핑장 찾기</h3>
         <div class="searchWrap">
            <form action="search" method="post">
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
                  </tr>
                  <!-- sido ajax -->
                  <tr>
                     <th>입지 구분</th>
                     <td colspan="3">
                        <select class="w3-input w3-border w3-round-large">
							<option>선택하세요.</option>
							<option>산</option>
							<option>숲</option>
							<option>계곡</option>
							<option>강</option>
                            <option>호수</option>
							<option>해변</option>
							<option>섬</option>
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
      <h3>인기 캠핑장 Best 3</h3>
      <div class="popWrap">
         <div class="popImg pImg1"></div>
         <div class="popImg pImg2"></div>
         <div class="popImg pImg3"></div>
      </div>
   </div>
   
   <!-- 테마별, 태그별 캠핑장 찾기 -->
	<div class="page page4 w3-center">
		<h3>테마별, 태그별 캠핑장 찾기</h3>
		<div class="w3-center" style="padding-top:30px">
			<button class="btn btn-white">#봄 꽃여행</button>
			<button class="btn btn-white">#여름 물놀이</button>
			<button class="btn btn-white">#가을 단풍명소</button>
			<button class="btn btn-white">#겨울 눈꽃명소</button>
			<button class="btn btn-white">#반려견 동반</button>
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
               <th>제목</th>
               <th>조회수</th>
            </tr>
            <c:forEach items="${boardlist}" var="b">
            <tr>
            	<td>자유게시판</td>
            	<td>${b.writer}</td>
            	<td>${b.title}</td>
            	<td>${b.readcnt}</td>
            </tr>
            
            </c:forEach>
         </table>
      </div>
      <div>
         <h3>공지사항<a href="" id="more">+</a></h3>
         <table class="w3-table">
            <tr style="background-color: #cddc39;">
               <th>게시판</th>
               <th>작성자</th>
               <th>내용</th>
               <th>조회수</th>
            </tr>
            <c:forEach items="${noticelist}" var="n">
            <tr>
            	<td>공지사항</td>
            	<td>${n.writer}</td>
            	<td>${n.title}</td>
            	<td>${n.readcnt}</td>
            </tr>
            </c:forEach>
         </table>
      </div>
   </div>
   
   <script>
      $(function(){
    	   let winHeight = $(window).height();
           let winWidth = $(window).width();
           $("#wrapper").height(winHeight-80);
           $("#wrapper").width(winWidth);
           $("#wrapper>div").height(winHeight-80);
           $("#wrapper>div").width(winWidth);

            let i =0
            setInterval(function(){
            	let prev = $("#wrapper>div").eq(i);
            	prev.css('left',0).stop().animate({"left":"-100%"})

            	i++
           		if(i==5)i=0;
            	
           		var next = $("#wrapper>div").eq(i);
           		next.css('left',"100%").stop().animate({'left':0})

            },3000)
            
         
            getSido()
        })
        
        $(".btn").click(function(){
            if( $(this).hasClass("on") == true) {
                $(this).removeClass("on")
            } else if ( $(this).hasClass("on") == false) {
                $(this).addClass("on")
            }
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
   
  	function getSido() {  //서버에서 리스트객체를 배열로 직접 전달 받음
  		$.ajax({
  			   url : "${path}/ajax/select",
  			   success : function(arr) {
  				   //arr : 서버에서 전달 받는 리스트 객체를 배열로 인식함
  				   $.each(arr,function(i,item){
  					   // i : 인덱스. 첨자. 0부터시작
  					   //item : 배열의 요소
  					   $("select[name=si]").append(function(){
  						   return "<option>"+item+"</option>"
  					   })
  				   })
  			   }
  		   })
     }
  	function getText(name) { //si
  		let city = $("select[name='si']").val();  //시도 선택값 
  		let gu = $("select[name='gu']").val();    //구군 선택값
  		let disname;
  		let toptext="구군을 선택하세요";
  		let params = "";
  		if (name == "si") { //시도 선택한 경우
  			params = "si=" + city.trim();
  			disname = "gu"; 
  		} else if (name == "gu") { //구군 선택한 경우 
  			params = "si="+city.trim()+"&gu="+gu.trim();
  			disname = "dong";
  			toptext="동리를 선택하세요";		
  		} else { 
  			return ;
  		}
  		$.ajax({
  		  url : "${path}/ajax/select",
  		  type : "POST",    
  		  data : params,  			
  		  success : function(arr) {
  			  $("select[name="+disname+"] option").remove(); //출력 select 태그의 option 제거
  			  $("select[name="+disname+"]").append(function(){
  				  return "<option value=''>"+toptext+"</option>"
  			  })
  			  $.each(arr,function(i,item) {  //서버에서 전송 받은 배열값을 option 객체로 추가
  				  $("select[name="+disname+"]").append(function(){
  					  return "<option>"+item+"</option>"
  				  })
  			  })
  		  }
  	   })				
  	}
 		
    </script>
</body>
</html>