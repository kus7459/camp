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
		background-color: lightSkyBlue  ;
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
</style>
	<header>
		<h3>날씨 보기</h3>
	</header>
	<div class="titleWrap">
		<h3 style="font-weight: bold; margin-bottom:15px; width: 38%">현재 전국 날씨</h3>
		<h3 style="font-weight: bold; margin-bottom:15px; width: 50%">주간 날씨</h3>
	</div>
	<div class="wrap">
		<div class="whole">
			<ul class="whole_bar">
				<li style="border-radius: 25px 0px 0px 25px" class="libtn on">현재</li>
				<li class="libtn">오전</li>
				<li style="border-radius: 0px 25px 25px 0px" class="libtn">오후</li>
			</ul>
			<img alt="날씨" src="../img/whole.png" class="wholeImg">
		</div>
		<div class="weeked">
			<img alt="주간 날씨" src="../img/weeked.png">
			<img alt="주간 날씨" src="../img/weeked2.png">
		</div>
	</div>
	<div class="searchWrap">
		<h3 style="font-weight: bold; margin-bottom:15px">다른 지역 날씨 찾아보기</h3>
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
			</tr>
		</table>
	</div>
</body>
</html>