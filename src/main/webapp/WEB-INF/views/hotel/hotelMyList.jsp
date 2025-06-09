<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>hotelMyList.jsp</title>
  <link rel="icon" href="${ctp}/images/favicon.ico" type="image/x-icon">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
  <style>
    body {
      background-color: #f9fefb;
    }
    .hotel-list-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      gap: 24px;
      padding: 20px;
      max-width: 1000px;
      margin: 0 auto;
    }
    .hotel-card {
      border: 1px solid #eee;
      border-radius: 8px;
      overflow: hidden;
      height: 400px;
      display: flex;
      flex-direction: column;
    }
    .hotel-image img {
      width: 100%;
      height: 200px;
      object-fit: cover;
    }
    .hotel-details {
      flex-grow: 1;
      padding: 12px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .hotel-name a {
      font-size: 18px;
      font-weight: bold;
      color: #333;
      text-decoration: none;
    }
    .hotel-name a:hover {
      color: #0077cc;
    }
    .hotel-star {
      font-size: 14px;
      color: #222;
    }
    .hotel-star-rating {
      font-weight: bold;
    }
    .hotel-type {
      font-size: 13px;
      color: #777;
    }
    .hotel-minPrice {
      font-weight: bold;
      font-size: 18px;
      color: #222;
      text-align: right;
      margin-top: 10px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div style="max-width: 1000px; margin: 40px auto 20px; text-align: center;">
  <h2 style="font-weight: bold; color: #2e7d32;">등록한 호텔 목록</h2>
  <p style="color: #666;">위드펫에 등록한 숙소들을 한눈에 확인하세요 🏨</p>
</div>

<div class="hotel-list-container">
  <c:forEach var="vo" items="${hotelList}">
    <div class="hotel-card">
      <div class="hotel-image">
        <img src="${ctp}/hotelThumbnail/s_${vo.thumbnail}" alt="${vo.name}">
      </div>
      <div class="hotel-details">
        <div class="hotel-name">
          <a href="${ctp}/hotel/hotelMyDetail?idx=${vo.idx}">${vo.name}</a>
        </div>
        <div class="hotel-star">
          <span class="hotel-star-rating">★ ${vo.averageStar}</span> (<fmt:formatNumber value="${vo.reviewCnt}" type="number" pattern="#,##0" />)
        </div>
        <div class="hotel-type">호텔</div>
        <div class="hotel-minPrice">
          <fmt:formatNumber value="${vo.minPrice}" type="number" pattern="#,##0" />원~
        </div>
      </div>
    </div>
  </c:forEach>
</div>

<c:if test="${empty hotelList}">
  <div class="text-center mb-5">등록된 호텔이 없습니다.</div>
</c:if>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
