<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>

<html>

  <head>

    <title>강의평가 웹 사이트</title>

    <meta charset="UTF-8">

  </head>

  <body>
  
      <%
      	request.setCharacterEncoding("UTF-8");
      %>

            <div class="dropdown-menu" aria-labelledby="dropdown">

              <a class="dropdown-item" href="non_memberlogin.jsp">로그인</a>

              <a class="dropdown-item" href="non_memberRegist.jsp">회원가입</a>

              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>

            </div>

          </li>

        </ul>
        
      </div>

    </nav>

    <div class="container mt-3" style="max-width: 560px;">

      <form method="post" action="../NonMemberLoginAction.me">

        <div class="form-group">

          <label>이름</label>

          <input type="text" name="name" class="form-control">

        </div>

        <div class="form-group">

          <label>이메일</label>

          <input type="text" name="email" class="form-control">

        </div>

        <button type="submit" class="btn btn-primary">로그인</button>

      </form>

    </div>
  </body>

</html>