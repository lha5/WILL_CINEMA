<%@page import="com.admin.service.event.db.AdminEventDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.event_cwrap {
    	width: 980px;
    	margin: 0 auto;
   		padding: 55px 0 50px;
	}
	.event_list {
    	margin-left: -60px;
    	width: 1000px;
	}
	
	.event_list li{
		position: relative;
	    float: left;
	    width: 230px;
	    height: 234px;
	    margin: 0 0 30px 20px;
	    border: 1px solid #dedede;
	    background: #fff;
	    box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	}
	
	li {
		float: left;
		border: solid black 1px;
		width: 228px;
		height: 229px;
		list-style: none;
		margin: 0px 0px 30px 20px;
	}
	li>p {
		margin-top: 4px;
		text-align: center;
		font-size: 0.8em;
	}
	
	li>img {
		width: 228px;
		height: 129px;
	}
	
	.btn_view a{
		clear: both;
		display: block;
		width: 100%;
		height: 40px;
		padding: 8px 0;
		background: #efefef;
		border: 1px solid #dedede;
		text-align: center;
		font-size: 14px;
		color: #231f20;
		font-weight: bold;
		box-sizing: border-box; /* -webkit-box-sizing:border-box; */
		-moz-box-sizing: border-box;
	}
	
	.btn_view span {
    	padding-bottom: 6px;
	}
	
	a {
    	text-decoration: none;
    	color: #555;
	}
</style>

<script type="text/javascript">
	function moreRead(){
/* 		alert(123);
		var listLen=$('.event_list li').length+1;
		var startCnt=$('#startCnt').val(listLen);
		alert(startCnt.val()); */
		var viewCnt=4;
		var listLen=$('.event_list li').length;
		var startCnt=$('#startCnt').val(listLen).val();
		var item=$('#item').val();
		$.getJSON({
			url:"./EventMore.ae",
			type:"post",
			data:{startCnt:startCnt,viewCnt:viewCnt, item:item},
			/* dataType:"json", */
			success:function(data){
					$.each(data,function(index,item){
						alert(index);
						/* var image=item.image.split(',');
						alert(image[index].val()); */
						alert(item.num);
						/* $('.event_list').append("<li><a href='./EventDetail.ae?eventId="+item.num+"'>"
								+"<img src='./upload/"+image[0]+"'></a>"
								+"<p>"+item.f_date+'~'+item.e_date+"</p></li>"); */
					});
				},
			error:function(request,status,error){
				alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
               }
		});
	}
</script>
</head>
<%
	List eventList = (List)request.getAttribute("eventList");
	String item=request.getParameter("item");
	String keyward=(String)request.getAttribute("keyward");
	if(keyward==null){
		keyward="";
	}
%>
<body>
	<!-- 
		CSS li줄바꿈 처리
		li{float:left;width:100px;height:100px;background:#000;color:#fff;}
		li:nth-of-type(4n-3){background:red;display:block;content:"";clear:left;}
	 -->
	 <input type="hidden" id="startCnt" value="0">
	 <input type="hidden" id="viewCnt" value="4">
	 <input type="hidden" id="item" value="<%=item%>">
	<div class="event_cwrap">
		<div>
			<h2>
			<%if(item.equals("movie") ){%>
				영화
			<%}else if(item.equals("preview") ){%>
				시사회/무대인사
			<%}else if(item.equals("nevnet") ){%>
				윌시 NOW
			<%}else if(item.equals("collabo") ){%>
				제휴할인
			<%} %>
			</h2>
			<form action="./EventConSearch.ae?item=<%=item %>" method="post">
			<input type="text" name="keyward" value="<%=keyward%>">
			<input type="submit" value="검색">
			</form>
		</div>
		<ul class="event_list">
			<%
			if(eventList.size()!=0){
				for(int i=0; i<eventList.size(); i++){ //카테고리 리스트
					AdminEventDTO aedto=(AdminEventDTO)eventList.get(i);
			%>
			<li>
				<a href="./EventDetail.ae?eventId=<%=aedto.getNum() %>" >
					<img src="./upload/<%=aedto.getImage().split(",")[0]%>">
				</a>
				<p><%=aedto.getF_date()%>~<%=aedto.getE_date()%></p>
			</il>
			<%	}
			}else{%>
				진행되는 이벤트가 없습니다.
			<%}%>
		</ul>
		<div class="btn_view">
				<a href="javascript:void(0);" onclick="moreRead();"><span>더보기</span></a>
		</div>
		<br>
		<a href="./EventSummary.ae">이벤트 목록</a>
	</div>
</body>
</html>