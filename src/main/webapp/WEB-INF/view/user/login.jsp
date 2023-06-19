<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿캠핑 로그인</title>
</head>
<body>
<div class="w3-padding-64">
	<div class="w3-padding-64">
		<form action="login" method="post" name="f" onsubmit="return input_check(this)">
			<div class="w3-container w3-content">
				<h2 style="text-align:center;">Good Camping</h2>
				<p style="text-align:center;">굿캠핑에 오신 걸 환영합니다.</p>
				<div class="form-group" style="width:70%; margin:0 auto">
					<label for="user">ID</label>
					<input type="text" class="form-control" id="user" name="id" style="height:50px;">
					<br>
					<label for="pwd">Password</label>
					<input type="password" class="form-control" id="pwd" name="pass" style="height:50px;">
				</div>
				<div style="width:70%; text-align: right; margin: 0 auto; margin-top:20px">
					<button type="button" onclick="location.href='idForm'" style="background-color:#dedede;margin-right:10px;margin-left:5px;" class="btn btn-outline-dark">아이디 찾기</button>
					<button type="button" onclick="location.href='pwForm'" style="background-color:#dedede" class="btn btn-outline-dark">비밀번호 찾기</button>
				</div>
				<div style="width:70%; text-align: center; margin: 0 auto; margin-top:30px">
				<hr>
					<button type="submit" class="btn btn-dark" 
					style="background-color:#cddc39;color:black;width: 660px; height: 50px; font-size: 20px;">로그인</button>
				</div>
				<div style="width:70%; text-align: center; margin: 0 auto; margin-top:30px">
				<hr>
				<a href="#"><img height="50" src="http://static.nid.naver.com./oauth/small_g_in.PNG" style="margin-right:10px;margin-left:5px;"></a>
				<a href="#"><img height="50" src="http://static.nid.naver.com./oauth/small_g_in.PNG"></a>
				</div>
			</div>
		</form>
	</div>
</div>
<script>
	function input_check(f) {
		if(f.id.value.trim() == ""){
			alert("아이디가 입력되지 않았습니다.");
			f.id.focus();
			return false;
		}
		if(f.pass.value.trim() == ""){
			alert("비밀번호가 입력되지 않았습니다.");
			f.pass.focus();
			return false;
		}
		return true;
	}
</script>
</body>
</html>