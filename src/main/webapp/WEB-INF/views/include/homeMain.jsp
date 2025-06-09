<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>homeMain.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<link rel="stylesheet" type="text/css" href="${ctp}/css/linkMain.css?v=2.0"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&family=Montserrat:wght@600&display=swap" rel="stylesheet">
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<style>
		body {
		  font-family: 'Noto Sans KR', sans-serif !important;
		}
		
		.section-header h2, .hero-heading, .product-title {
		  font-family: 'Montserrat', sans-serif !important;
		  font-weight: 600;
		}
		
		ul, li {
			text-decoration: none;
			list-style: none;
		}
				
		body.modal-open {
	 		padding-right: 0 !important;
		}
		
		.nav-container {
		     display: flex; /* flex로 설정 */
		     justify-content: space-between; /* 항목 간 간격을 고르게 배치 */
		     align-items: center; /* 세로로 중앙 정렬 */
		     padding: 20px;
		     max-width: 1200px;
		     margin: 0 auto;
		   }
    
	    .nav-links a {
		  font-size: 18px;
		  font-weight: 500;
		}
		

		/* Style The Dropdown Button */
		.dropbtn {
		  color: black;
		  padding: 16px;
		  font-size: 16px;
		  border: none;
		  cursor: pointer;
		}
		
		/* The container <div> - needed to position the dropdown content */
		.dropdown {
		  position: relative;
		  display: inline-block;
		}
		
		/* Dropdown Content (Hidden by Default) */
		.dropdown-content {
		  display: none;
		  position: absolute;
		  background-color: #f9f9f9;
		  min-width: 160px;
		  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		  z-index: 1;
		}
		
		/* Links inside the dropdown */
		.dropdown-content a {
		  color: black;
		  padding: 12px 16px;
		  text-decoration: none;
		  display: block;
		}
		
		/* Change color of dropdown links on hover */
		.dropdown-content a:hover {background-color: #f1f1f1}
		
		/* Show the dropdown menu on hover */
		.dropdown:hover .dropdown-content {
		  display: block;
		}
		
		/* Change the background color of the dropdown button when the dropdown content is shown */
		.dropdown:hover .dropbtn {
		  background-color: #eee;
		}
		
		.hero-section {
		  background: url("${ctp}/images/background.png") no-repeat center center/cover;
		  padding: 80px 20px;
		  text-align: center;
		  color: #fff;
		}
		
		.hero-heading {
		  font-size: 2.0rem;
		  font-weight: bold;
		  max-width: 1200px;
		  text-align: start;
		  margin: 0 auto 30px;
		}
		
		.hotel-search-container {
		  background-color: rgba(255, 255, 255, 0.95);
		  padding: 30px;
		  border-radius: 16px;
		  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
		  max-width: 1200px;
		  margin: 0 auto;
		}
		
		.hotel-search-form {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 20px;
		  justify-content: center;
		  align-items: center; 
		  padding-top: 20px; 
		  padding-bottom: 10px; 
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
		  margin-top:24px;
		}
		
		.search-button:hover {
		  background-color: #3e8f52;
		}
		.section-header h2 {
		  color: #2e7d32 !important;
		}
		.benefit-icon {
		  background-color: #81c784 !important;  /* 초록색 */
		}
		
		.product-card {
		  position: relative;
		  padding: 20px;
		  background-color: #fff;
		  border-radius: 12px;
		  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
		  min-height: 500px;
		}
		.product-image img {
		  border-radius: 12px;
		  width: 100%;
		  height: auto;
		  object-fit: cover;
		}
		.product-info {
		  padding-bottom: 100px;
		  min-height: 200px;
		}
		.product-price {
		  position: absolute;
		  bottom: 20px;
		  left: 40px;
		  right: 20px;
		  margin-top: 20px;
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<section class="hero-section">
  <h2 class="hero-heading">위드펫, 반려견 동반 여행을 위한 최적의 선택!</h2>

  <div class="hotel-search-container">
    <form method="get" action="${ctp}/hotel/hotelList" onsubmit="return hotelSearch()" class="hotel-search-form">
      
      <div class="search-field large">
        <label>지역 또는 숙소명</label>
        <input id="searchString" type="text" name="searchString" placeholder="지역이나 숙소명을 입력하세요" required />
      </div>

      <div class="search-field">
        <label>체크인</label>
        <input type="date" id="checkinDate" name="checkinDate" value="${checkinDate}" required />
      </div>

      <div class="search-field">
        <label>체크아웃</label>
        <input type="date" id="checkoutDate" name="checkoutDate" value="${checkoutDate}" required />
      </div>

      <div class="search-field small">
        <label>인원</label>
        <input type="number" id="guestCount" name="guestCount" min="1" max="10" value="${guestCount}" required />
      </div>

      <div class="search-field small">
        <label>반려견</label>
        <input type="number" id="petCount" name="petCount" min="1" max="5" value="${petCount}" required />
      </div>

      <button type="submit" class="search-button">검색</button>

    </form>
  </div>
</section>

<section class="featured">
  <div class="container">
    <div class="section-header">
      <h2>New Arrivals</h2>
      <p>새로운 감성 숙소, 지금 바로 만나보세요.</p>
    </div>
    <div class="product-grid">
	  <c:forEach var="hotel" items="${recentHotels}" varStatus="status">
	    <div class="product-card">
	      <div class="product-image">
	        <img src="${ctp}/data/hotelThumbnail/${empty hotel.thumbnail ? 'default.png' : hotel.thumbnail}" alt="${hotel.name}" />
	      </div>
	      <div class="product-info">
	        <span class="product-tag">NEW</span>
	        <h3 class="product-title">${hotel.name}</h3>
	        <p class="mb-3">${hotel.address}</p>
	        <div class="product-price">
	          <span class="price">₩&nbsp;<fmt:formatNumber value="${hotel.minPrice}" type="number" groupingUsed="true" /></span>
	          <a href="${ctp}/hotel/hotelDetail?idx=${hotel.idx}" class="add-to-cart btn btn-success" 
	             style="font-size: 1em; width: 80px; border-radius: 10%; display:inline-block; text-align:center; text-decoration: none;">
	            보기
	          </a>
	        </div>
	      </div>
	    </div>
	  </c:forEach>
  </div>
 </div>
</section>

<section class="featured">
  <div class="container">
    <div class="section-header">
      <h2>Top Rated Hotels</h2>
      <p>고객들이 가장 만족한 호텔을 만나보세요!</p>
    </div>
    <div class="product-grid">
      <c:forEach var="hotel" items="${topRatedHotels}">
        <div class="product-card">
          <div class="product-image">
            <img src="${ctp}/data/hotelThumbnail/${empty hotel.thumbnail ? 'default.png' : hotel.thumbnail}" alt="${hotel.name}" />
          </div>
          <div class="product-info">
            <span class="product-tag">⭐ ${hotel.averageStar}</span>
            <h3 class="product-title">${hotel.name}</h3>
            <p class="mb-3">${hotel.address}</p>
            <div class="product-price">
              <span class="price">₩&nbsp;<fmt:formatNumber value="${hotel.minPrice}" type="number" groupingUsed="true" /></span>
              <a href="${ctp}/hotel/hotelDetail?idx=${hotel.idx}" class="add-to-cart btn btn-success"
                 style="font-size: 1em; width: 80px; border-radius: 10%; display:inline-block; text-align:center; text-decoration: none;">
                보기
              </a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</section>

<section class="reviews">
  <div class="container">
    <div class="section-header">
      <h2>Reviews</h2>
      <p>내맘에 쏙 드는 체험</p>
    </div>
	<div class="reviews-grid">
	  <c:forEach var="r" items="${latestReviews}">
	    <div class="review-card">
	      <div class="review-quote">"</div>
	      <div class="stars">
	        <c:forEach begin="1" end="${r.star}">★</c:forEach>
	      </div>
	      <p class="review-text">
	        ${fn:substring(r.content, 0, 50)}
	      </p>
	      <div class="review-author">
	        <div class="author-info">
	          <h4>${r.nickName}</h4>
	          <p>
	            <a href="${ctp}/hotel/hotelDetail?idx=${r.hotelIdx}" style="text-decoration:none;">
	              ${r.hotelName}
	            </a>
	          </p>
	        </div>
	      </div>
	    </div>
	  </c:forEach>
	</div>
  </div>
</section>

<section class="benefits">
  <div class="container">
    <div class="section-header">
      <h2>Member Benefits</h2>
      <p>반려동물과 함께하는 꿈같은 숙박을 회원가로 할인받으세요.</p>
    </div>
    <div class="benefits-grid">
      <div class="benefit-card">
        <div class="benefit-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
          </svg>
        </div>
        <h3 class="benefit-title">럭셔리 호텔을 더 저렴하게</h3>
        <p style="word-break: keep-all;">수준은 높게, 가격은 저렴하게 즐길 수 있는 호텔을 만나보세요.</p>
      </div>
      <div class="benefit-card">
        <div class="benefit-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
          </svg>
        </div>
        <h3 class="benefit-title">리워드 혜택</h3>
        <p>위드펫 리워드로 10박 숙박 시 리워드 1박</p>
      </div>
      <div class="benefit-card">
        <div class="benefit-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
            <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
            <line x1="12" y1="22.08" x2="12" y2="12"></line>
          </svg>
        </div>
        <h3 class="benefit-title">호텔링 체험</h3>
        <p style="word-break: keep-all;">호텔에서 제공하는 반려동물 호텔링 서비스도 체험해보세요.</p>
      </div>
      <div class="benefit-card">
        <div class="benefit-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
            <polyline points="22 4 12 14.01 9 11.01"></polyline>
          </svg>
        </div>
        <h3 class="benefit-title">멋진 후기를 남겨보세요!</h3>
        <p>월마다 멋진 리뷰를 추첨하여 할인쿠폰을 제공합니다.</p>
      </div>
    </div>
  </div>
</section>

<%-- <section class="collections">
  <div class="container">
    <div class="section-header">
      <h2>나에게 꼭 맞는 추천 숙소리스트</h2>
      <p>현재 월 기준 평균 요금</p>
    </div>
    <div class="collections-grid">
      <div class="collection-item">
        <div class="collection-bg" style="background-image: url('${ctp}/images/hotel5.jpg')"></div>
        <div class="collection-overlay">
          <h3 class="collection-title">호텔이름1</h3>
          <p>강릉,한국</p>
          <a href="#" class="collection-link">￦65,347 →</a>
        </div>
      </div>
      <div class="collection-item">
        <div class="collection-bg" style="background-image: url('${ctp}/images/hotel6.jpg')"></div>
        <div class="collection-overlay">
          <h3 class="collection-title">호텔이름2</h3>
          <p>속초,한국</p>
          <a href="#" class="collection-link">￦44,917 →</a>
        </div>
      </div>
      <div class="collection-item">
        <div class="collection-bg" style="background-image: url('${ctp}/images/hotel7.jpg')"></div>
        <div class="collection-overlay">
          <h3 class="collection-title">호텔이름3</h3>
          <p>부산,한국</p>
          <a href="#" class="collection-link">￦69,373 →</a>
        </div>
      </div>
    </div>
  </div>
</section> --%>

<script>
	'use strict';
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
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>