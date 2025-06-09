<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>위드펫 - 내 쿠폰</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <style>
    .detail-container {
      max-width: 800px;
      margin: 0 auto;
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    .detail-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }
    .detail-label {
      width: 30%;
      font-weight: bold;
      color: #555;
    }
    .detail-value {
      width: 65%;
      color: #333;
    }
    .coupon-image img {
      width: 40%;
      border-radius: 8px;
    }
    .text-center {
      text-align: center;
    }
    .btn-custom {
      padding: 10px 25px;
      background-color: #6c757d;
      color: white;
      border: none;
      border-radius: 8px;
      transition: background-color 0.3s;
    }
    .btn-custom:hover {
      background-color: #5a6268;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">쿠폰 정보 상세보기</h2>

  <div class="detail-container">

    <div class="detail-row">
      <div class="detail-label">쿠폰 타입</div>
      <div class="detail-value">
        <c:choose>
          <c:when test="${vo.couponType == 'R'}">예약쿠폰</c:when>
          <c:when test="${vo.couponType == 'E'}">이벤트쿠폰</c:when>
          <c:otherwise>알 수 없음</c:otherwise>
        </c:choose>
      </div>
    </div>

    <div class="detail-row">
      <div class="detail-label">쿠폰 이름</div>
      <div class="detail-value">${vo.couponName}</div>
    </div>

    <div class="detail-row">
      <div class="detail-label">할인 형태</div>
      <div class="detail-value">
        <c:choose>
          <c:when test="${vo.discountType == 'P'}">퍼센트(%)</c:when>
          <c:when test="${vo.discountType == 'A'}">금액(원)</c:when>
          <c:otherwise>없음</c:otherwise>
        </c:choose>
      </div>
    </div>

    <c:if test="${vo.discountType == 'P'}">
      <div class="detail-row">
        <div class="detail-label">할인율</div>
        <div class="detail-value">${vo.discountValue}%</div>
      </div>
    </c:if>

    <c:if test="${vo.discountType == 'A'}">
      <div class="detail-row">
        <div class="detail-label">할인액</div>
        <div class="detail-value">${vo.discountValue}원</div>
      </div>
    </c:if>

    <div class="detail-row">
      <div class="detail-label">발행일</div>
      <div class="detail-value">${fn:substring(vo.issueDate,0,10)}</div>
    </div>

    <div class="detail-row">
      <div class="detail-label">만료일</div>
      <div class="detail-value">${fn:substring(vo.expiryDate,0,10)}</div>
    </div>

    <div class="detail-row">
      <div class="detail-label">쿠폰 상태</div>
      <div class="detail-value">
        <c:choose>
          <c:when test="${vo.isActive == '1'}">활성화</c:when>
          <c:otherwise>비활성화</c:otherwise>
        </c:choose>
      </div>
    </div>

    <div class="detail-row">
      <div class="detail-label">안내 사진</div>
      <div class="detail-value coupon-image">
        <img src="${ctp}/coupon/${vo.photo}" alt="쿠폰 이미지"/>
      </div>
    </div>

    <div class="text-center mt-4">
      <button type="button" class="btn-custom" onclick="location.href='${ctp}/coupon/couponForm';">돌아가기</button>
    </div>

  </div>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
