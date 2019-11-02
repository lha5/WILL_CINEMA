<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../../include/header.jsp" %>
<%
 if(!id.equals("admin")){
	response.sendRedirect("./MemberLogin.me");
}  
%>


<fieldset>
<legend>FAQ쓰기</legend>
<form action="./FAQWriteAction.af" method="post" enctype="multipart/form-data" >
<table>
<tr>
<td>작성자
<input type="text" name="name" value="<%=id%>">
비밀번호 :<input type="text" name="pass" value="">
</td>
<tr>
<td>카테고리
<select name="category">
<option value="영화관이용">영화관이용</option>
<option value="회원">회원</option>
<option value="이용안내">사이트 이용 안내</option>
<option value="이벤트">이벤트</option>
<option value="매점">매점</option>
<option value="할인혜택">할인혜택</option>
</select>
</td>
</tr>

<tr>
<td>제목</td>
<td colspan="2">
<input type="text" name="subject"></td>
</tr>

<tr>
<td>FAQ내용</td>
<td colspan="2">
<textarea name="content" rows="10" cols="20">내용입력</textarea></td>
</tr>

<tr>
<td>이미지</td>
<td colspan="2">
<input type="file" name="image"></td>
</tr>
				
<tr><td colspan="5">
<input type="submit" value="FAQ쓰기">
</td>
</tr>
</table>
</form>
</fieldset>
<%@ include file="../../include/footer.jsp" %>

</body>
</html>