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
      <form action="join" method="post" name="f"
         onsubmit="return input_check(this)">
         <input type="hidden" name="chkid" value="1" id="chkid">
         <table class="w3-table">
            <tr>
               <td colspan="2" width="60%"><input type="text" name="id" 
                  placeholder="ID를 입력해주세요" class="form-control"></td>
               <td width="40%"><button type="button" onclick="idchk()"
                     class="btn btn-dark" style="width: 100%;background-color:#cddc39;color:black;">중복확인</button></td>
            </tr>
            <tr>
               <td colspan="3"><input type="password" name="pass"
                  placeholder="비밀번호 8~16자 숫자,영어 포함" class="form-control"></td>
            </tr>
            <tr>
               <td colspan="3"><input type="password" name="chkpass"
                  placeholder="비밀번호 재확인" class="form-control"></td>
            </tr>
            <tr>
               <td colspan="3"><input type="text" name="name"
                  placeholder="이름" class="form-control"></td>
            </tr>
            <tr>
               <td width="33%">
                  <select class="form-control" name="year">
                       <option value="">태어난 년도</option>
                     <c:forEach var="i" begin="1980" end="2010">
                        <option value="${i}">${i}</option>
                     </c:forEach>
                  </select>
               </td>
               <td width="33%">
                  <select class="form-control" name="month">
                     <option value="">태어난 월</option>
                     <c:forEach var="i" begin="1" end="12">
                        <c:if test="${i<10}">
                           <option value="0${i}">0${i}</option>
                        </c:if>
                        <c:if test="${i>=10}">
                           <option value="${i}">${i}</option>
                        </c:if>
                     </c:forEach>
                  </select>
               </td>
               <td width="34%">
                  <select class="form-control" name="day">
                     <option value="">태어난 일</option>
                     <c:forEach var="i" begin="1" end="31">
                        <c:if test="${i<10}">
                           <option value="0${i}">0${i}</option>
                        </c:if>
                        <c:if test="${i>=10}">
                           <option value="${i}">${i}</option>
                        </c:if>
                     </c:forEach>
                  </select>               
               </td>
            </tr>
            <tr>
               <td colspan="3"><input type="text" name="tel"
                  placeholder="-을 포함한 전화번호 10자리 또는 11자리" class="form-control">
               </td>
            </tr>
            <tr>
               <td colspan="3">성별 &nbsp; 
               <input type="radio" name="gender" value="1">남 &nbsp; 
               <input type="radio" name="gender" value="2">여
            </tr>
            <tr>
               <td width="40%"><input type="text" name="email" id="email" 
                  class="form-control" placeholder="email"></td>
               <td width="4%">@</td>
               <td width="40%"><select class="form-control" name ="com" id="com">
                     <option value="">주소를 선택하세요</option>
                     <option value="naver.com">naver.com</option>
                     <option value="nate.com">nate.com</option>
                     <option value="gmail.com">gmail.com</option>
               </select></td>               
            </tr>
         </table>
         <div class="w3-center" style="margin-top: 20px; margin-bottom:50px">
            <button type="submit" style="background-color:#cddc39;color:black;" class="btn btn-dark" id="jobutton">회원가입</button>
            <button type="reset" style="background-color:#dedede" class="btn btn-outline-dark">다시 작성</button>
         </div>
      </form>
   </div>
   <script>  
      function input_check(f) {
         if (f.id.value.trim() == "") {
            alert("아이디가 입력되지 않았습니다.");
            f.id.focus();
            return false;
         }
         if (f.pass.value.trim() == "") {
            alert("비밀번호가 입력되지 않았습니다.");
            f.pass.focus();
            return false;
         }
         if (f.chkpass.value.trim() == "") {
            alert("비밀번호를 다시 입력해주세요.");
            f.chkpass.focus();
            return false;
         }
         if (f.name.value.trim() == "") {
            alert("이름이 입력되지 않았습니다.");
            f.name.focus();
            return false;
         }
         if (f.year.value.trim() == "") {
            alert("생년월일이 입력되지 않았습니다.");
            f.year.focus();
            return false;
         }
         if (f.day.value.trim() == "") {
            alert("생년월일이 입력되지 않았습니다.");
            f.day.focus();
            return false;
         }
         if (f.tel.value.trim() == "") {
            alert("전화번호가 입력되지 않았습니다.");
            f.tel.focus();
            return false;
         }
         if (f.gender.value.trim() == "") {
            alert("성별을 선택해주세요.");
            return false;
         }
         if (f.email.value.trim() == "") {
            alert("이메일을 입력해주세요.");
            f.email.focus();
            return false;
         }
         if (f.chkid.value.trim() == "1") {
             alert("아이디 중복확인 해주세요.");
             f.emailchk.focus();
             return false;
          }
         if (f.pass.value.trim() != f.chkpass.value.trim() ) {
             alert("비밀번호가 일치하지 않았습니다.");
             f.chkpass.focus();
             return false;
          }
         return true;
      }
      function win_open(page) {
         let op = "width=500, height=400, left=50, top=150";
         open(page, "", op)
      }
      function idchk() {
         if (document.f.id.value == "") {
            alert("아이디를 입력하세요");
            f.id.focus();
         }else{
           document.getElementById("chkid").value = "2";
            let op = "width=350, height=350, left=50, top=150"
               open("idchk?id="+document.f.id.value,"",op)
            }
      }
   </script>
</body>
</html>