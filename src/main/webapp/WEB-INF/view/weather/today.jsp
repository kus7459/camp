<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>날씨</title>
</head>
<body>
<style>
 	* {margin: 0; padding: 0;}
    a {text-decoration: none;}
    ol, ul {list-style: none}
    header {position: relative;
    		height:150px; 
    		background-color:#cddc39;}
	header>h3 {position:absolute;
		bottom: 5px;
		left: 5%;
		font-weight: bold;}
	.wrap {display:flex;
		width:90%;
		margin-left:10%;
		justify-content: space-between;
		margin-bottom: 60px}
	.titleWrap {display:flex;
		width:90%;
		margin-left:10%;
		margin-top:50px;
		justify-content: space-between;}	
	
	.whole {width:38%;
		background-color: lightSkyBlue;
		border-radius: 15px;
		padding: 15px 0px}
	.wholeImg {width: 60%;
			margin-left: 20%}
	.weeked {width:50%}
	
	.whole_bar {display:flex;
		margin-bottom: 20px;
		margin-left: 15px}
	.whole_bar li {
		background-color: #fff;
		padding: 7px 15px 5px 15px;}
	
	.whole_bar li.on {background-color: deepSkyBlue  }
	.weeked>img {width:75%}
	
	
	.searchWrap {width:90%;
		margin-left:10%;
		margin-bottom: 60px
	}
	
	.btn-lime {background-color: #cddc39}
</style>
	<header>
		<h3>날씨 보기</h3>
	</header>
	<div class="searchWrap">
		<h3 style="font-weight: bold; margin-bottom:15px">날씨 찾아보기</h3>
		<table class="w3-table" style="width:90%">
			<tr>
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
				<td>
					<button class="btn btn-lime" onclick="getXy('si','gu')">검색</button>
				</td>
			</tr>
		</table>
		<div id="result">
		
		</div>
	</div>
	<script>
	$(function(){
		getSido();
	})
	function getSido() {  //서버에서 리스트객체를 배열로 직접 전달 받음
		$.ajax({
			   url : "${path}/ajax2/select",
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
		  url : "${path}/ajax2/select",
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
	function getXy(){
		let siname = $("select[name='si']").val();  //시도 선택값 
		let gunname = $("select[name='gu']").val();    //구군 선택값
		let dongname = $("select[name='dong']").val();
		let params = "si="+siname+"&gu="+gunname+"&dong="+dongname;
		let html;
		$.ajax({
			url : "${path}/ajax2/selectXy",
			type : "POST",
			data : params,
			success : function(data) {
				let obj = JSON.parse(data);
				let dangi = obj[0].dangi
				let rain = obj[1].rain
				let temp = obj[2].temp
	
				for(i=0; i<=5; i++) {
					let r = rain[i]
					for(j=3; j<=7; j++) {
						let p = "wf"+j+"Am"
						console.log(r[p])
					}
				}
				
				let date = new Date();
				let mon = date.getMonth() + 1;
				let day = date.getDate();
				
				let html = "<table><tr>";
				html += "<td><b>오늘</b><p>"+mon+"-"+(day+3)+"</p></td>"	// 날짜
				html+= "<td>"+rain[0].wf3Am+"</td>"						// 오전
				html+= "<td>"+rain[0].wf3Pm+"</td>"						// 오후
				html+= "<td>"+"<b style='color:skyblue'>"+temp[0].taMin3+"</b>"
				html+= "/ <b style='color:red'>"+temp[0].taMax3+"</b>"+"</td>"						// 최저 최고
				html+= "<td></td>"
				html+= "<td></td>"
				html+= "<td></td>"
				html+= "<td></td>"
				html+="</tr></table>"
				
				$("#result").html(html);
			}
		})
		
	}
	</script>
</body>
</html>