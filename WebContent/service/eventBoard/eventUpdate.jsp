<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- jqueryui.com의 jquery파일(인터넷 사용 가능일때)-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script type="text/javascript">
/* 달력 한글 출력 코드 */
$.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    showMonthAfterYear: true,
    yearSuffix: '년'
});

$( function() {

    var dateFormat = "yy-mm-dd",

      from = $( "#from" )
        .datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 2
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 2
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });

    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
      return date;
    }
  } );
  
	function checkValue(){
	  var form = document.fr;
	  
	  if (!form.subject.value) {
			alert("제목을 입력하세요.");
			document.fr.subject.focus();
			return false;
	  }
	  
	  if (!form.from.value) {
			alert("시작 날짜를 선택하세요.");
			document.fr.from.focus();
			return false;
	  }
	  
	  if (!form.to.value) {
			alert("끝 날짜를 선택하세요.");
			document.fr.to.focus();
			return false;
	  }
}
</script>
</head>
<body>
<%
	AdminEventDTO aedto=(AdminEventDTO)request.getAttribute("aedto");
%>
<h1>이벤트 수정 페이지</h1>
<fieldset>
	<form action="./EventUpdateAction.ae" method="post" name="fr" onsubmit="return checkValue();" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=aedto.getNum()%>">
		<input type="hidden" name="file2" value="<%=aedto.getImage()%>">
		<table border="1">
			<tr>
				<td>카테고리</td> 
				<td><select name="category">
						<option value="movie"
						<%if(aedto.getCategory().equals("movie")){%>
					selected
				<%} %>>영화</option>
						<option value="preview"
						<%if(aedto.getCategory().equals("preview")){%>
					selected
				<%} %>>시사회/무대인사</option>
						<option value="nevent"
						<%if(aedto.getCategory().equals("nevent")){%>
					selected
				<%} %>>윌시NOW</option>
						<option value="collabo"
						<%if(aedto.getCategory().equals("collabo")){%>
					selected
				<%} %>>제휴 할인</option>
				</select></td>
			<tr>
			<tr>
				<td>제목</td><td><input type="text" name="subject" value="<%=aedto.getSubject()%>"></td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><input type="text" name="fDate" id="from" value="<%=aedto.getF_date()%>">
				 ~ <input type="text" name="eDate" id="to" value="<%=aedto.getE_date()%>">
				 </td>
			</tr><!-- 날짜 선택 드롭박스 -->
			<tr>
				<td>썸네일 이미지</td><td><input type="file" name="img1"></td>
			</tr>
			<tr>
				<td>본문 이미지 1</td><td><input type="file" name="img2"></td>
			</tr>
			<tr>
				<td>본문 이미지 2</td><td><input type="file" name="img3"></td>
			</tr>
			<tr>
				<td>본문 이미지 3</td><td><input type="file" name="img4"></td>
			</tr>
		</table>
		<input type="submit" value="이벤트 수정"> <input type="reset" value="취소">
	</form>
	<a href="./EventSummary.ae">이벤트 목록</a>
</fieldset>
</body>
</html>