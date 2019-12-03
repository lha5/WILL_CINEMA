<h1>WILL_CINEMA</h1>
<h3>2조 팀 프로젝트</h3>
<p>팀원 - 김창일, 박찬일, 이승욱, 이태길, 이혜안, 조윤규</p>
<p><a href="http://itwillbs12.cafe24.com">WILL CINEMA 홈페이지</a></p>

<p>
  <img src="https://user-images.githubusercontent.com/55972804/70032008-e3b6da80-15ef-11ea-92ac-82d990c042bb.png" alt="메인_화면">
</p>

<h2>1. 프로젝트 소개</h2>
<b>영화 예매 사이트</b>
<p>JSP와 MVC 패턴을 적용시킨 영화 예매 및 상품 구매를 서비스하는 웹사이트</p>
<p롯데시네마 홈페이지를 참고하여 개발하였음</p>

<h2>2. 사이트 주요 기능</h2>
<ul>
  <li>#회원제 #포인트적립</li>
  <li>#영화검색 #영화예매</li>
  <li>#상품구매 #내역조회</li>
  <li>#CRUD #1:1문의 #공지사항 #자주묻는질문</li>
  <li>#jQuery #Ajax #비동기처리</li>
  <li>#각종_라이브러리</li>
</ul>

<h2>3. 개발 환경 및 기술 스택</h2>
<ol>
  <li>
    개발 환경
    <ul>
      <li>Windows10</li>
      <li>Chrome</li>
    </ul>
  </li>
  <li>
    사용 기술
    <ul>  
      <li>JDK1.8</li>
      <li>JSP2.3/Servlet3.1</li>
      <li>SQL - MySQL5.7</li>
      <li>JavaScript</li>
      <li>jQuery & Ajax</li>
      <li>HTML5</li>
      <li>CSS3</li>
    </ul>
  </li>
  <li>
    개발에 사용한 툴 및 기타
    <ul>
      <li>Eclipse neon.3</li>
      <li>MySQL Workbench 6.3 CE</li>
      <li>Apache Tomcat 8.5</li>
      <li>PuTTY 및 FileZilla Client</li>
    </ul>
  </li>
</ol>

<h2>4. 데이터베이스 설계 및 구조</h2>
<img alt="DB_Diagram" src="https://user-images.githubusercontent.com/55972804/70036126-7c9d2400-15f7-11ea-9cdb-a05df42b24e7.png">
<p>예매(book)와 회원(member) 테이블을 중심으로 유기적인 관계를 갖도록 설계하였음</p>

<h2>5. 각자가 맡은 기능 구현 파트</h2>
<ul>
  <li>김창일 - 컨트롤러 작성 및 배포, 이벤트 게시판 작성, 영화 예매 기능 작성</li>
  <li>박찬일 - 매점 게시판, 소셜로그인(네이버 아이디로 로그인), 영화관 지점 등록, 영화 예매 일부 기능, 매점 구매 시 문자 메시지 발송 기능</li>
  <li>이승욱 - 공지사항 게시판, 영화 등록(영화 게시판), 영화 예매 시 안내 메일 발송 기능</li>
  <li>이태길 - 회원 로그인 및 수정/탈퇴, 영화관 지점 페이지에 배너 클릭 시 동영상 팝업창 띄우기, 지도 API 사용, 메인 화면 구성, 자주 묻는 질문 게시판</li>
  <li>이혜안 - DB 설계 및 생성, 회원 가입 및 마이페이지, 프론트엔드 전반(CSS, JavaScript 등), 결제 모듈 추가, summernote와 우편API 사용, 코드 취합 및 테스트</li>
  <li>조윤규 - 1:1문의 게시판, 리뷰 작성, 비회원 조회 </li>
</ul>

<h2>6. 추가로 구현 하고 싶은 기능</h2>
<p>시간 제약으로 인해 조금씩 빠진 기능들 - 포인트 사용, 메일 및 문자 메시지 발송을 예매 및 구매시 둘 다 적용시키는 것</p>
<p>비회원 로그인은 가능하지만, 예매/구매 및 내역 열람 불가</p>
<p>구글 아이디 또는 카카오 아이디로 로그인하기</p>


<h2>7. 개선 사항</h2>
<p>사용자 페이지는 괜찮으나, 관리자 페이지의 CSS 적용이 아쉬움</p>
<p>웹 페이지 자체가 약간 정적인 느낌이라서, 동적인 느낌을 살리고 싶음</p>
<p>불필요한 코드나 중복되는 코드등이 간혹 있어서 낭비되는 느낌이 있음</p>
