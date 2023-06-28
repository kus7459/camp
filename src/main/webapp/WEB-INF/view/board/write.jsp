<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
</head>
<body>
<br><br><br><br><br>
<form:form modelAttribute="board" action="write" enctype="multipart/form-data" name="f">
	<table class="w3-table" style="width:90%; margin: 0 auto">
		<tr>
			<th>작성자</th>
			<td><form:input path="writer" readonly="true" 
				class="w3-input" value="${loginUser.id}" />
				<font color="red"><form:errors path="writer"/></font>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th><td><form:input path="pass" class="w3-input"/>
			<font color="red"><form:errors path="pass"/></font></td>
		</tr>
		<tr>
			<th>제목</th><td><form:input path="title" class="w3-input"/>
			<font color="red"><form:errors path="title"/></font></td>
		</tr>
		<tr>
			<th>내용</th><td><form:textarea path="content" rows="15" cols="80"/>
			<font color="red"><form:errors path="content"/></font></td>
		</tr>
		<script>CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload"})</script>
		<tr>
			<th>첨부파일</th><td><input type="file" name="file1"></td>
		</tr>
		<tr>
			<td colspan="2" class="w3-center">
				<c:if test="${boardid == '3'}"> 
					비밀글<input type="checkbox" name="secret" value="1"/>
				</c:if>	
				<br>
				<a href="javascript:document.f.submit()">[게시글등록]</a>			
				<a href="list?boardid=${boardid }">[게시글목록]</a>
			</td>
		</tr>					
	</table>
</form:form>

</body>
</html>