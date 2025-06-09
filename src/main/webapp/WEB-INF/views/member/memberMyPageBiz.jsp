<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberMyPageBiz.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <style>
    body {
      background-color: #f9fefb;
      font-family: 'Arial', sans-serif;
      font-size: 1.1rem;
    }
    .my-page-header {
      text-align: center;
      font-weight: bold;
      font-size: 2rem;
      margin-bottom: 30px;
      color: #2e7d32;
    }
    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 25px 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      margin-bottom: 20px;
    }
    .section-title {
      font-size: 1.4rem;
      font-weight: bold;
      color: #2e7d32;
      margin-bottom: 15px;
    }
    .btn-section {
      margin-top: 15px;
    }
    .btn-section a {
      margin-right: 10px;
      font-size: 1rem;
    }
    .link-list a {
      display: block;
      padding: 10px 0;
      color: #333;
      text-decoration: none;
      border-bottom: 1px solid #eee;
      font-size: 1.1rem;
    }
    .link-list a:hover {
      color: #2e7d32;
      font-weight: bold;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<h3 class="text-center mb-4">
<img src="${ctp}/images/logo.png" width="150px"/><br/>
  <div class="my-page-header">마이페이지</div>
</h3>
<div class="section-box">
  <h3><p><b>${sNickName}</b>님, 환영합니다! 🏨</p></h3>
  <p>회원 등급 : <span style="color: green">${strLevel}</span></p>
  <p>사업자 등록번호 : <span style="color: #555">${mVo.businessNo}</span></p>
  <div class="btn-section">
    <a href="${ctp}/member/pwdCheck/u" class="btn btn-sm btn-outline-success">회원정보 수정</a>
    <a href="${ctp}/member/pwdCheck/p" class="btn btn-sm btn-outline-primary">비밀번호 변경</a>
  </div>
</div>

<div class="section-box">
  <div class="section-title">내 호텔 관리</div>
  <div class="link-list">
    <a href="${ctp}/hotel/hotelInput">호텔 등록하기</a>
    <a href="${ctp}/hotel/myHotelList">등록된 호텔 목록 보기</a>
    <a href="#">예약 내역 관리</a>
  </div>
</div>

</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
