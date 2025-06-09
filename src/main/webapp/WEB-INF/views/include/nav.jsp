<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/linkMain.css"/>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />

<style>
  ul, li {
    list-style: none;
    padding: 0;
    margin: 0;
  }

  .nav-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 40px 10px;
    max-width: 1400px;
    margin: 0 auto;
  }

  .logo img {
    width: 110px;
    vertical-align: middle;
    margin-left: 50px;
  }

  .nav-links {
    display: flex;
    gap: 24px;
    align-items: center;
  }

  .nav-links li {
    text-align: center;
  }

  .nav-links li a {
    text-decoration: none;
    color: #000000;
    font-weight: 500;
    font-size: 17px;
    padding: 8px 10px;
    border-radius: 12px;
    transition: background-color 0.2s ease;
  }

  .nav-links li a:hover {
    background-color: #f3f3f3;
  }

  ul.nav-links {
    margin-bottom: 0 !important;
  }

  .dropdown {
    position: relative;
  }

  .dropdown-content {
    display: none;
    position: absolute;
    background-color: #ffffff;
    min-width: 140px;
    box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
    z-index: 1000;
    padding: 8px 0;
    border-radius: 10px;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
  }

  .dropdown-content a {
    color: #333;
    padding: 10px 16px;
    text-decoration: none;
    display: block;
    font-size: 13px;
  }

  .dropdown-content a:hover {
    background-color: #f2f2f2;
  }

  .dropdown:hover .dropdown-content {
    display: block;
  }
	  #scrollTopBtn {
	  display: none;
	  position: fixed;
	  bottom: 40px;
	  right: 40px;
	  z-index: 1000;
	  background-color: gray !important;
	  color: white;
	  border: none;
	  padding: 10px 15px;
	  border-radius: 50%;
	  font-size: 18px;
	  cursor: pointer;
	  box-shadow: 0 2px 8px rgba(0,0,0,0.3);
	  transition: background-color 0.3s ease;
	}
	
	#scrollTopBtn:hover {
	  background-color: #555 !important;
	}
</style>
<script>
		'use strict';
		
	  // 실시간 채팅창 열기
	  function chatEndUserCheck() {
		  window.open("${ctp}/webSocket/chatEndUserWin","chatWin","width=300px,height=380px");
	  }
</script>

<body>
<nav>
  <div class="nav-container">
    <!-- 로고 -->
    <div class="logo">
      <a href="${ctp}/"><img src="${ctp}/images/logo.png" alt="로고"></a>
    </div>

    <!-- 네비 메뉴 -->
    <ul class="nav-links">
      <li><a href="${ctp}/">홈</a></li>

      <c:if test="${sLevel == 0 || sLevel == 1}">
        <li><a href="${ctp}/hotel/hotelInput">숙소 등록</a></li>
      </c:if>

      <li><a href="${ctp}/hotel/hotelList">전체 숙소</a></li>

      <c:if test="${empty sessionScope.sLogin}">
        <li><a href="${ctp}/member/memberLogin">로그인</a></li>
      </c:if>

      <c:if test="${sMid == 'admin'}">
        <li><a href="${ctp}/admin/adminMain">관리자</a></li>
      </c:if>

      <c:if test="${not empty sessionScope.sLogin}">
        <li><a href="${ctp}/member/memberLogout">로그아웃</a></li>
        <li><a href="${ctp}/member/memberMyPage">마이페이지</a></li>
      </c:if>

      <li class="dropdown">
        <a href="#">커뮤니티</a>
        <div class="dropdown-content">
          <a href="${ctp}/board/list">자유게시판</a>
          <a href="${ctp}/photogallery/photogalleryList">포토갤러리</a>
        </div>
      </li>

      <li class="dropdown">
      	<a class="nav-link dropbtn" href="#" role="button">고객센터</a>
	      <div class="dropdown-content">
	        <!-- 관리자 메뉴 -->
	        <c:if test="${sLevel eq 0}">
	          <a href="${ctp}/admin/inquiry/adInquiryList">1:1문의</a>
	          <a href="${ctp}/faq/adFaqList">FAQ</a>
	          <a href="${ctp}/qna/qnaList">Q&A</a>
	          <a href="${ctp}/admin/liveChat/adminChat" target="_blank">실시간채팅</a>
	        </c:if>
	        <!-- 일반/사업자회원 메뉴 -->
	        <c:if test="${sLevel ne 0}">
	          <a href="${ctp}/inquiry/inquiryList">1:1문의</a>
	          <a href="${ctp}/faq/faqList">FAQ</a>
	          <a href="${ctp}/qna/qnaList">Q&A</a>
	          <c:if test="${not empty sessionScope.sLogin}">
	         	 <a href="javascript:chatEndUserCheck()">실시간채팅</a>
	          </c:if>
	        </c:if>
	      </div>
     </li>
    </ul>
  </div>
</nav>
<!-- Top 버튼 -->
<button id="scrollTopBtn" style="display:none; position:fixed; bottom:40px; right:40px; z-index:1000; background-color:#333; color:#fff; border:none; padding:10px 15px; border-radius:50%; font-size:16px; cursor:pointer;">
  ↑
</button>
<script>
  const scrollBtn = document.getElementById("scrollTopBtn");

  // 스크롤 이벤트 감지
  window.onscroll = function () {
    if (document.body.scrollTop > 150 || document.documentElement.scrollTop > 150) {
      scrollBtn.style.display = "block";
    } else {
      scrollBtn.style.display = "none";
    }
  };

  // 클릭 시 스크롤 맨 위로
  scrollBtn.addEventListener("click", function () {
    window.scrollTo({ top: 0, behavior: "smooth" });
  });
</script>
</body>
