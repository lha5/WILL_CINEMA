
<%@page import="com.member.db.MemberDAOImpl"%>
<%@page import="com.member.db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복 체크</title>
    
    <style type="text/css">
        #wrap {
            width: 490px;
            text-align :center;
            margin: 0 auto 0 auto;
        }
        
        #chk{
            text-align :center;
        }
        
        #useBtn{
             visibility:hidden;
        }
 
   </style>
	<script type="text/javascript">
   		 function result(){
   		
   		   opener.document.upForm.id.value  = document.willfr.userid.value;
   		    window.close();	 
   		 }

	</script>
</head>
<body>

	<%
		String id = request.getParameter("userid"); 
		MemberDAO mdao = new MemberDAOImpl();
		// JoinIdCheck(id) -> 결과 리턴  0 / 1
         int check = mdao.JoinIdCheck(id);	 	
		// 0 중복된 아이디가 없음 -> 해당 아이디를 사용 유도 / 사용확인 버튼 
		// 1 중복된 아이디가 있음 -> 아이디 변경 유도
		// 각각의 동작을 페이지에 출력
		
		if(check == 1){
			%>
			<script type="text/javascript">
			alert(" 가입 불가능 아이디 입니다.");
		</script>
			
		<% 
		}else{ // check == 0
		%>	
		<script type="text/javascript">
		alert(" 가입 가능 아이디 입니다. ");
		</script>
		     
		   
		   
		   <%
		
		}
		
		// 아이디 입력 선택 
	%>
  <hr>
<div id="wrap">
    <br>
    <b><font size="4" color="gray">아이디 중복체크</font></b>
    <hr size="1" width="460">
    <br>
    <div id="chk">
         <form action="joinIdCheck.jsp" name="willfr" method="post">
      <input type="text" name="userid" value="<%=id%>"> 
      <input type="submit" value="중복확인">
    </form>
         <input type="button" value="아이디 사용하기" onclick="result();">
    	<input type="button" value="취소" onclick="window.close()">
    </div>
</div>    













</body>
</html>