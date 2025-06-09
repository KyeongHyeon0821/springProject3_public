<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script>
	var size = ${vosSize};
	if(size<6) $('#hotelMoreBtn').hide();
</script>

<c:forEach var="vo" items="${vos}">
  <div class="hotel-card" data-idx="${vo.idx}">
    <div class="hotel-image">
      <img src="${ctp}/hotelThumbnail/s_${vo.thumbnail}" alt="${vo.name}">
    </div>
    <div class="hotel-details">
      <div class="hotel-header">
        <h3 class="hotel-name">
          <a href="${ctp}/hotel/hotelDetail?idx=${vo.idx}&searchString=${searchString}&checkinDate=${checkinDate}&checkoutDate=${checkoutDate}&guestCount=${guestCount}&petCount=${petCount}">${vo.name}</a>
        </h3>
        <!-- 찜 아이콘 -->
        <c:set var="isLiked" value="false" />
        <c:forEach var="likedIdx" items="${likedHotelListIdx}">
          <c:if test="${likedIdx == vo.idx}">
            <c:set var="isLiked" value="true" />
          </c:if>
        </c:forEach>
        <c:choose>
          <c:when test="${isLiked}">
            <a id="likeFn${vo.idx}" href="javascript:hotelLikeNo(${vo.idx})">
              <img id="likeImg${vo.idx}" src="${ctp}/images/heartRed.png" class="heart-icon" />
            </a>
          </c:when>
          <c:otherwise>
            <a id="likeFn${vo.idx}" href="javascript:hotelLikeOk(${vo.idx})">
              <img id="likeImg${vo.idx}" src="${ctp}/images/heartBlack.png" class="heart-icon" />
            </a>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="hotel-star"><span class="hotel-star-rating">★ ${vo.averageStar}</span> (<fmt:formatNumber value="${vo.reviewCnt}" type="number" pattern="#,##0" />)</div>
      <div class="hotel-hotel">호텔</div>
      <div class="hotel-time-minPrice">
     	  <div class="hotel-time">숙박 15:00~</div>
      	<div class="hotel-minPrice"><fmt:formatNumber value="${vo.minPrice}" type="number" pattern="#,##0" />원~</div>
      </div>
    </div>
  </div>
</c:forEach>
  
  