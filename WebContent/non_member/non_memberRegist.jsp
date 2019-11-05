<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>

<html>

  <head>

    <title>강의평가 웹 사이트</title>

  <body>

    <div class="container mt-3" style="max-width: 560px;">

      <form method="post" action="./userRegisterAction.jsp">

        <div class="form-group">

          <label>이름</label>

          <input type="text" name="name" class="form-control">

        </div>

        <div class="form-group">

          <label>생년월일</label>

          <input type="text" name="birth" class="form-control">

        </div>

        <div class="form-group">

          <label>이메일</label>

          <input type="email" name="email" class="form-control">

        </div>

        <button type="submit" class="btn btn-primary">회원가입</button>

      </form>

    </div>
  </body>

</html>