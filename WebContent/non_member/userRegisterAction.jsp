<%@page import="com.member.db.NonMemberDAO"%>
<%@page import="com.member.db.NonMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="util.SHA256"%>

<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	String name = null;

	String birth = null;

	String email = null;

	if(session.getAttribute("name") != null) {

		name = (String) session.getAttribute("name");

	}

	if(session.getAttribute("birth") != null) {

		birth = (String) session.getAttribute("birth");

	}

	if(session.getAttribute("email") != null) {

		email = (String) session.getAttribute("email");

	}

	if (name == null || birth == null || email == null) {
		
		System.out.println(" name : "+name);
		System.out.println(" birth : "+birth);
		System.out.println(" email : "+email);
		System.out.println(" email_hash : "+SHA256.getSHA256(email));

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('입력이 안 된 사항이 있습니다.');");

		script.println("history.back();");

		script.println("</script>");

		script.close();

	} else {
		
		System.out.println(" name : "+name);
		System.out.println(" birth : "+birth);
		System.out.println(" email : "+email);
		System.out.println(" email_hash : "+SHA256.getSHA256(email));
		
		NonMemberDAO userDAO = new NonMemberDAO();
		
		int result = userDAO.join(new NonMemberDTO(name, birth, email, SHA256.getSHA256(email), 0));

		if (result == -1) {

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('이미 존재하는 아이디입니다.');");

			script.println("history.back();");

			script.println("</script>");

			script.close();

		} else {

			session.setAttribute("name", name);

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("location.href = 'emailSendAction.jsp';");

			script.println("</script>");

			script.close();

		}

	}

%>