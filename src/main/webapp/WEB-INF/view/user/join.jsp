<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿캠핑 회원가입</title>
</head>
<body>
<style>
   table tr:nth-child(5) select {text-align: center}
</style>
   <div class="w3-content" style="max-width: 600px;padding-top:100px">
      <h2 class="w3-center">회원가입</h2>
      <form:form modelAttribute="user" method="post" action="join" 
      		name="f" onsubmit="return inchk(this)">
      	<spring:hasBindErrors name="user">
			<font color="red" class="w3-center" style="display:block">
				<c:forEach items="${errors.globalErrors}" var="error">
					<spring:message code="${error.code}" />
					<br>
				</c:forEach>
			</font>
		</spring:hasBindErrors>
         <input type="hidden" name="chkid" value="1" id="chkid">
         <table class="w3-table">
            <tr>
               <td colspan="3"><form:input path="id" 
                  placeholder="ID를 입력해주세요" class="form-control"/>
                  <font color="red"><form:errors path="id" /></font></td>
            </tr>
            <tr>
               <td colspan="3"><form:password path="pass"
                  placeholder="비밀번호 8~16자 숫자,영어 포함" class="form-control"/>
                  <font color="red"><form:errors path="pass" /></font></td>
            </tr>
            <tr>
               <td colspan="3"><input type="password" name="chgpass" 
               class="form-control" placeholder="비밀번호 재입력"></td>
            </tr>
            <tr>
               <td colspan="3">
               	<form:input path="name" placeholder="이름" class="form-control"/>
                  <font color="red"><form:errors path="name" /></font></td>
            </tr>
            <tr>
               <td colspan="3">
					<form:input path="birth" placeholder="생년월일" class="form-control"/>
                  <font color="red"><form:errors path="birth" /></font>
               </td>
            </tr>
            <tr>
               <td colspan="3">
               <form:input path="tel" placeholder="-을 포함한 전화번호 10자리 또는 11자리" class="form-control"/>
                  <font color="red"><form:errors path="tel" /></font>
               </td>
            </tr>
            <tr>
               <td colspan="3">성별 &nbsp; 
               <input type="radio" name="gender" value="1" checked>남 &nbsp; 
               <input type="radio" name="gender" value="2">여
            </tr>
            <tr>
               <td colspan="3">
               		<form:input path="email"
                  class="form-control" placeholder="email형식으로 입력해주세요."/>
                  <font color="red"><form:errors path="email" /></font>
               </td>
            </tr>
         </table>
         <div class="w3-center" style="margin-top: 20px; margin-bottom:50px">
            <button type="submit" style="background-color:#cddc39;color:black;" class="btn btn-dark" id="jobutton">회원가입</button>
            <button type="reset" style="background-color:#dedede" class="btn btn-outline-dark">다시 작성</button>
         </div>
      </form:form>
   </div>
<script>
	function inchk(f) {
		if(f.pass.value != f.chgpass.value) {
			alert("비밀번호와 비밀번호 재입력이 다릅니다.");
			f.chgpass.value="";
			f.chgpass.focus();
			return false;
		}
		return true;
	}
</script>
</body>
</html>