<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberMyPage.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
<script>
  function confirmAndAlert() {
    const confirmed = confirm("정말 이 반려견 정보를 목록에서 지우시겠어요?\n언제든 다시 등록할 수 있어요!");
    if (confirmed) {
      alert("등록이 취소되었습니다.");
      return true;
    }
    return false;
  }
</script>
<style>
  body {
    background-color: #f9fefb;
    font-family: 'Arial', sans-serif;
    font-size: 1.1rem;
    width: 100%;
  }

  .my-container {
	max-width: 1200px;
	margin: 0 auto;
	overflow-x: visible;
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
    margin-bottom: 30px;
  }

  .section-box ul {
    padding-left: 20px;
    list-style: none;
  }

  .section-box ul li {
    margin-bottom: 10px;
    font-size: 1.1rem;
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

  .dog-card-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
  }

  .dog-card {
    width: 300px;
    background-color: #dff7ec;
    padding: 20px;
    border: 1px solid #a5d6b1;
    border-radius: 12px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    text-align: center;
    transition: all 0.2s ease-in-out;
    min-height: 400px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .dog-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	border-color: #4caf50;
    background-color: #e7fbee;
  }
  .dog-card img {
    width: 120px;
    height: 120px;
    object-fit: cover;
    border-radius: 10px;
    margin: 0 auto 20px auto;
    display: block;
  }

  .dog-card ul {
    padding: 0;
    font-size: 0.95rem;
    text-align: left;
    margin-bottom: 25px;
  }

  .dog-card ul li {
    margin-bottom: 6px;
  }
  
  footer {
	position: relative;
	left: 50%;
	right: 50%;
	margin-left: -50vw;
	margin-right: -50vw;
	width: 100vw;
	max-width: 100vw;
  }
  
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="my-container">
<h3 class="text-center mb-4">
<img src="${ctp}/images/logo.png" width="150px"/><br/>
  <div class="my-page-header">마이페이지</div>
  </h3>

  <div class="section-box">
    <h3><p><b>${sNickName}</b>님, 안녕하세요! &#128154;</p></h3>
    <p>회원 등급 : <span style="color: green">${strLevel}</span></p>
    <div class="btn-section">
	  <a href="${ctp}/member/pwdCheck/u" class="btn btn-sm btn-outline-success">회원정보 수정</a>
	  <a href="${ctp}/member/pwdCheck/p" class="btn btn-sm btn-outline-primary">비밀번호 변경</a>
	</div>
  </div>

  <div class="section-box">
    <div class="section-title">활동 내역</div>
    <div class="link-list">
      <a href="${ctp}/member/myReservation">예약 내역 조회 및 관리</a>
      <a href="${ctp}/room/roomUseList">리뷰 등록</a>
      <a href="${ctp}/review/memberReview">내 리뷰보기</a>
      <a href="${ctp}/coupon/couponForm">쿠폰</a>
      <a href="#">찜 목록</a>
      <a href="#">1:1 문의 내역</a>
    </div>
  </div>

  <!-- 반려견 정보 영역 -->
  <div class="section-box">
  <div class="section-title">&#128054; 반려견 정보</div>
  <c:choose>
    <c:when test="${empty dogList}">
      <p>등록된 반려견이 없습니다.</p>
      <a href="${ctp}/pet/register" class="btn btn-outline-success">반려견 등록하기</a>
    </c:when>
    <c:otherwise>
      <div class="dog-card-container">
        <c:forEach var="dogVo" items="${dogList}">
          <div class="dog-card" style="background-color: #f4fff8;">
            <img src="${ctp}/images/${dogVo.photo}" width="150" height="150" style="border-radius: 10px; margin-bottom: 10px;">
            <ul>
              <li>이름 : ${dogVo.petName}</li>
              <li>견종 : ${dogVo.breed}</li>
              <li>성별 : ${dogVo.petGender}</li>
              <li>나이 : ${dogVo.petAge}살</li>
              <li>몸무게 : ${dogVo.weight}kg</li>
              <li>특이사항 : ${dogVo.memo}</li>
            </ul>
            <div class="btn-section">
              <a href="${ctp}/pet/update?petIdx=${dogVo.petIdx}" class="btn btn-sm btn-outline-secondary">정보수정</a>
              <a href="${ctp}/pet/deletePet?petIdx=${dogVo.petIdx}" onclick="return confirmAndAlert();" class="btn btn-sm btn-outline-danger" style="margin-left: 4px;">등록취소</a>
            </div>
          </div>
        </c:forEach>
      </div>
      <c:if test="${fn:length(dogList) < 3}">
		<div style="text-align: center; margin-top: 30px;">
		  <a href="${ctp}/pet/register" class="btn btn-outline-success">반려견 추가 등록</a>
		</div>
	  </c:if>
	  <c:if test="${fn:length(dogList) >= 3}">
  		<p style="text-align: center; color: #2e7d32; margin-top: 40px;">반려견은 <b>최대 3마리</b>까지 등록할 수 있어요.</p>
	  </c:if>
    </c:otherwise>
  </c:choose>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>