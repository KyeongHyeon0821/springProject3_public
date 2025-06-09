<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위드펫 - 호텔검색</title>
	<link rel="icon" href="${ctp}/images/favicon.ico" type="image/x-icon">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
		'use strict';
		// 호텔 찜 추가하기
		function hotelLikeOk(hotelIdx) {
			let mid = '${sMid}';
			if(mid == "") {
				Swal.fire({
	        icon: 'info',
	        title: "로그인 후 이용해주세요.",
	        confirmButtonText: '확인'
	      })
				return false;
			}
			
			$.ajax({
				url : "hotelLikeOk",
				type : "post",
				data : {
					mid : mid,
					hotelIdx : hotelIdx
				},
				success : function(res) {
					if(res == "1") {
						$("#likeImg" + hotelIdx).attr("src", "${ctp}/images/heartRed.png");
						$("#likeFn" + hotelIdx).attr("href", "javascript:hotelLikeNo(" + hotelIdx + ")");
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() { alert("에러"); }
			});
		}
		
		// 호텔 찜 취소하기
		function hotelLikeNo(hotelIdx) {
			let mid = '${sMid}';
			if(mid == "") {
				Swal.fire({
	        icon: 'info',
	        title: "로그인 후 이용해주세요.",
	        confirmButtonText: '확인'
	      })
				return false;
			}
			
			$.ajax({
				url : "hotelLikeNo",
				type : "post",
				data : {
					mid : mid,
					hotelIdx, hotelIdx
				},
				success : function(res) {
					if(res == "1") {
						$("#likeImg" + hotelIdx).attr("src", "${ctp}/images/heartBlack.png");
						$("#likeFn" + hotelIdx).attr("href", "javascript:hotelLikeOk(" + hotelIdx + ")");
					}
					else {
						alert("다시 시도해주세요.");
					}
				},
				error : function() { alert("에러"); }
			});
		}
		
		
		// 호텔 검색
		function hotelSearch() {
			let searchString = $("#searchString").val().trim();
			let checkinDate = $("#checkinDate").val();
			let checkoutDate = $("#checkoutDate").val();
			let guestCount = $("#guestCount").val();
			let petCount = $("#petCount").val();
			
			if(searchString == "") {
				alert("지역이나 숙소명을 입력하세요");
				$("#searchString").focus();
				return false;
			}
			else {
				return true;
			}
		}
		
		// 체크인 체크아웃 날짜 처리
		window.addEventListener('DOMContentLoaded', function () {
			var size = ${vosSize};
			if(size < 6) $('#hotelMoreBtn').hide();
			
		  const checkinInput = document.getElementById('checkinDate');
		  const checkoutInput = document.getElementById('checkoutDate');
		
		  // 오늘 날짜로 체크인 최소 설정
		  const today = new Date().toISOString().split('T')[0];
		  checkinInput.min = today;
		
		  // 체크인 값이 이미 있는 경우 초기 처리
		  if (checkinInput.value) {
		    checkoutInput.disabled = false;
		    checkoutInput.min = checkinInput.value;
		
		    // 체크아웃 날짜가 체크인보다 빠른 경우 초기화
		    if (checkoutInput.value && checkoutInput.value < checkinInput.value) {
		      checkoutInput.value = '';
		    }
		  } else {
		    checkoutInput.disabled = true;
		  }

		  // 체크인 날짜가 변경되면
		  checkinInput.addEventListener('change', function () {
		    if (checkinInput.value) {
		      checkoutInput.disabled = false;
		      checkoutInput.min = checkinInput.value;
		      checkoutInput.value = '';
		    } else {
		      checkoutInput.disabled = true;
		      checkoutInput.value = '';
		    }
		  });
		});
		
		
		
		let startIndexNo = 6;
		// 호텔 더보기
		function moreHotels() {
			let searchString = '${searchString}';
			let checkinDate = '${checkinDate}';
			let checkoutDate = '${checkoutDate}';
			let guestCount = '${guestCount}';
			let petCount = '${petCount}';
			
			$.ajax({
				url : "hotelMore",
				type : "post",
				data : {
					startIndexNo : startIndexNo,
					checkinDate : checkinDate,
					checkoutDate : checkoutDate,
					guestCount : guestCount,
					petCount : petCount,
					searchString : searchString
				},
				success : function(res) {
					startIndexNo += 6;
					$("#hotel-list-container").append(res);
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
		
	</script>
	<style>
		body {
		  background-color: #f1f1f1; /* 연회색 배경 */
		  margin: 0;
		}
		
		.con {
			background-color: #ffffff;
			max-width: 1000px;
			margin: 0px auto;
			padding-bottom: 10px;
		}
		
		.hotel-list-container {
		  background-color: #ffffff;  /* 컨테이너는 흰색 */
		  padding: 20px;
		  border-radius: 12px;
		  max-width: 1000px;
		  margin: 0px auto;
		  display: grid;
		  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
		  gap: 24px;
		}
		
		/* 호텔 카드 전체 */
		.hotel-card {
		  display: flex;
		  flex-direction: column;
		  justify-content: space-between;
		  height: 400px; /* 카드 높이 고정 */
		  border: 1px solid #eee;
		  border-radius: 8px;
		  overflow: hidden;
		}
		
		/* 이미지 영역 */
		.hotel-image img {
		  width: 100%;
		  height: 200px;
		  object-fit: cover;
		}
		
		/* 카드 본문 */
		.hotel-details {
		  display: flex;
		  flex-direction: column;
		  flex-grow: 1; /* 남는 공간 채우기 */
		  padding: 12px;
		  box-sizing: border-box;
		  position:relative;
		}
		
		/* 호텔 이름 + 하트 정렬 */
		.hotel-header {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  position: relative;
		}
		
		/* 호텔 이름 */
		.hotel-name {
			padding-right: 28px;
		  flex: 1;
		}
		
		.hotel-name a {
		  font-size: 18px;
		  font-weight: 700;
		  color: #333;
		  text-decoration: none;
		  line-height: 1.4;
		  display: -webkit-box;
		  -webkit-line-clamp: 2; /* 최대 2줄로 표시 */
		  -webkit-box-orient: vertical;
		  overflow: hidden;
		  text-overflow: ellipsis;
		  word-break: break-word;
		}
		
		.hotel-name a:hover {
		  color: #0077cc;
		}
		
		
		/* 가격을 항상 맨 아래로 밀기 */
		.hotel-minPrice {
		  margin-top: auto; /* 핵심: 남는 공간을 밀어냄 */
		  font-weight: bold;
		  font-size: 20px;
		  color: #222;
		  text-align:end;
		}
		.hotel-time {
			text-align:end;
			font-size: 13px;
			color:#555;
		}
		
		.heart-icon {
		  position: absolute;
		  top: 14px;
		  right: 0;
		  width: 18px;
		  height: 18px;
		}
		
	  .hotel-search-container {
	  	position: fixed;
  		top: 120px;
		  background-color: white;
		  padding: 30px;
		  border-top-left-radius: 3px;
			border-top-right-radius: 3px;
		  border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
		  width: 100%;
		  left: 50%;
 			transform: translateX(-50%);
		  max-width: 1400px;
		  margin: 0 auto 40px; 
		  z-index: 1000;
		}
		
		.hotel-search-form {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 20px;
		  justify-content: center;
		  align-items: center; 
		}
		
		.search-field {
		  flex: 1 1 180px;
		  display: flex;
		  flex-direction: column;
		  align-items: flex-start;
		  min-width: 150px;
		}
		
		.search-field.large {
		  flex: 2 1 260px;
		}
		
		.search-field.small {
		  flex: 0 1 100px;
		}
		
		.search-field label {
		  font-size: 14px;
		  color: #555;
		  margin-bottom: 6px;
		}
		
		.search-field input {
		  width: 100%;
		  padding: 12px;
		  border: 1px solid #ddd;
		  border-radius: 10px;
		  font-size: 16px;
		}
		
		.search-button {
		  height: 50px;
		  padding: 0 25px;
		  background-color: #4da764;
		  color: #fff;
		  border: none;
		  border-radius: 10px;
		  font-size: 16px;
		  font-weight: bold;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		  align-self: center;
		  margin-top: 24px;
		}
		
		.search-button:hover {
		  background-color: #3e8f52;
		}
		.hotel-star {
			font-size: 14px;
		  color: #222;
		}
		/* 평점 (검정색) */
		.hotel-star-rating {
		  font-size: 14px;
		  color: #222;
		  margin-bottom: 6px;
		  font-weight:bold;
		}
		.modal-backdrop.show {
		  background-color: rgba(0, 0, 0, 0.2); /* 더 밝은 배경 */
		}
		.hotel-hotel {
			color: #555;
			font-size:12px;
		}
		.hotel-time-minPrice {
			position:absolute;
			right:12px;
			bottom:12px;
		}
		
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<div class="hotel-search-container" id="hotel-search-container" style="display:none">
  <form method="get" action="${ctp}/hotel/hotelList" onsubmit="return hotelSearch()" class="hotel-search-form">
    <div class="search-field large">
      <label>지역 또는 숙소명</label>
      <input id="searchString" type="text" name="searchString" placeholder="지역이나 숙소명을 입력하세요" value="${searchString}" />
    </div>

    <div class="search-field">
      <label>체크인</label>
      <input type="date" id="checkinDate" name="checkinDate" value="${checkinDate}" />
    </div>

    <div class="search-field">
      <label>체크아웃</label>
      <input type="date" id="checkoutDate" name="checkoutDate" value="${checkoutDate}" />
    </div>

    <div class="search-field small">
      <label>인원</label>
      <input type="number" id="guestCount" name="guestCount" min="1" max="10" value="${guestCount}" />
    </div>

    <div class="search-field small">
      <label>반려견</label>
      <input type="number" id="petCount" name="petCount" min="1" max="5" value="${petCount}" />
    </div>

    <button type="submit" class="search-button">검색</button>
  </form>
</div>

<div class="con">
	<img src="${ctp}/images/dogImage.png" width="100%"/>
	<div class="hotel-list-container" id="hotel-list-container">
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
	  
	</div>
	<c:if test="${empty vos}">
		<div class="text-center mb-5">검색 조건에 맞는 호텔이 없습니다. 조건을 변경하거나 다른 날짜를 시도해 보세요.</div>
	</c:if>
		
	<div class="text-center">
	<button id="hotelMoreBtn" class="btn btn-secondary" onclick="moreHotels()">더보기</button>
</div>
</div>
</body>
</html>