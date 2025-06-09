<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위드펫 - 객실상세</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
		'use strict';
		
		// 객실 서비스 중지 요청
		function roomDeleteCheck() {
			let ans = confirm("해당 객실 서비스 중지를 요청하시겠습니까?");
			if(!ans) return false;
			else location.href="roomDeleteCheck?idx=${vo.idx}";
		}
		
		//리뷰 리스트 보여주기
		function modalCheck(idx,hotelIdx,roomIdx,reviewTotCnt,reviewCnt,mid,nickName,roomName,purpose,star,content,hostIp,reviewDate) {
			$("#idx").val(idx);
			$("#hotelIdx").val(hotelIdx);
			$("#roomIdx").val(roomIdx);
			$("#reviewTotCnt").val(reviewTotCnt);
			$("reviewCnt").val(reviewCnt);
			$("#mid").val(mid);
			$("#nickName").val(nickName);
			$("#roomName").val(roomName);
			$("#purpose").val(purpose);
			$("#star").val(star);
			$("#content").val(content);
			$("#hostIp").val(hostIp);
			$("#reviewDate").val(reviewDate);
		}
		
	</script>
	
	<style>
		.room-detail-container {
		  max-width: 800px;
		  margin: 40px auto;
		  padding: 24px;
		  background-color: #ffffff;
		  border-radius: 16px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		  font-family: 'Noto Sans KR', sans-serif;
		  color: #333;
		}
		
		.room-header {
		  display: flex;
		  justify-content: space-between;
		  align-items: baseline;
		  margin-bottom: 20px;
		}
		
		.room-title {
		  font-size: 1.8rem;
		  font-weight: bold;
		}
		
		.room-price {
		  font-size: 1.2rem;
		  color: #009688;
		  font-weight: 600;
		}
		
		.room-slider {
		  width: 100%;
		  max-width: 800px;
		  margin: 0 auto 2rem;
		  border-radius: 12px;
		  overflow: hidden;
		  cursor:pointer;
		}
		
		.room-slider img {
		  width: 100%;
		  height: auto;
		  object-fit: cover;
		  border-radius: 12px;
		}
		.swiper-button-next,
		.swiper-button-prev {
		  color: #888888; 
		}
		.swiper-button-next:hover,
		.swiper-button-prev:hover {
		  color: #666666; 
		}
		.swiper-pagination-bullet {
		  background-color: #cccccc;
		}
		.swiper-pagination-bullet-active {
		  background-color: #666666; 
		}
								
		
		
		.room-info ul {
		  list-style: none;
		  padding: 0;
		  margin: 0 0 30px 0;
		}
		
		.room-info li {
		  padding: 0px;
		  font-size: 0.95rem;
		}
		
		.room-options h4 {
		  margin-bottom: 12px;
		  margin-top: 50px;
		  font-size: 1.2rem;
		  font-weight:bold;
		}
		
		.review-preview-container h4{
			margin-bottom: 0px;
		  margin-top: 50px;
		  font-size: 1.2rem;
		  font-weight:bold;
		}
		
		
		.option-grid {
		  display: grid;
		  grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개씩 */
		  gap: 0px 20px; /* 세로, 가로 간격 */
		}
		
		.option-item {
		  display: flex;
		  align-items: center;
		  gap: 8px;
		  padding: 5px 14px 0px 0px;
		  font-size: 0.95rem;
		}
		
		.option-item img {
		  width: 18px;
		  height: 18px;
		}
		
		.room-owner-actions {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 10px;
		  margin-top: 30px;
		}
		
		/* 공통 버튼 스타일 */
		input[type="button"],
		a.btn-secondary,
		a.btn-tertiary,
		a.btn-danger {
		  padding: 8px 16px;
		  font-size: 0.95rem;
		  border: none;
		  border-radius: 12px;
		  cursor: pointer;
		  transition: background-color 0.2s ease;
		  text-decoration: none;
		  display: inline-block;
		  font-family: 'Noto Sans KR', sans-serif;
		}
		
		/* 객실 정보 수정 */
		a.btn-secondary {
		  background-color: #1976d2;
		  color: #fff;
		}
		
		a.btn-secondary:hover {
		  background-color: #1565c0;
		}
		
		/* 이미지 수정 */
		a.btn-tertiary {
		  background-color: #757575;
		  color: #fff;
		}
		
		a.btn-tertiary:hover {
		  background-color: #616161;
		}
		
		/* 서비스 중지 요청 */
		a.btn-danger {
		  background-color: #e53935;
		  color: #fff;
		}
		
		a.btn-danger:hover {
		  background-color: #c62828;
		}
		
		/* 기존 컨테이너에 아래 여백 추가 */
		.room-detail-container {
		  padding-bottom: 160px;
		}
		
		/* 고정 바 전체 영역 (화면 하단에 고정, 가운데 정렬용) */
		.room-reserve-bar-wrapper {
		  position: fixed;
		  bottom: 0;
		  left: 0;
		  width: 100%;
		  background: transparent;
		  display: flex;
		  justify-content: center;
		  z-index: 1000;
		}
		
		/* 고정 바 본체 (컨테이너 너비에 맞춤) */
		.room-reserve-bar {
		  width: 800px;
		  max-width: 90%;
		  background-color: #ffffff;
		  border-top: 1px solid #ddd;
		  box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.08);
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  padding: 10px 24px;
		  font-family: 'Noto Sans KR', sans-serif;
		  gap: 20px;
		}
		
		/* 왼쪽 예약 정보 */
		.reserve-left {
		  font-size: 0.95rem;
		  color: #444;
		}
		
		.reserve-dates {
		  font-weight: 600;
		  font-size: 0.9rem;
		  margin-bottom: 6px;
		}
		
		.reserve-summary {
		  font-size: 1.5rem;
		  color: #333;
		}
		
		/* 예약 버튼 */
		.reserve-form {
		  flex-shrink: 0;
		}
		
		.btn-reserve {
		  background-color: #009688;
		  color: white;
		  padding: 12px 32px;
		  font-size: 1.1rem;
		  font-weight:bold;
		  border: none;
		  border-radius: 10px;
		  cursor: pointer;
		  transition: background-color 0.2s ease;
		  width: 300px; /* 버튼 길이 조절 가능 */
		}
		
		.btn-reserve:hover {
		  background-color: #00796b;
		}
		
		.modal-backdrop.show {
		  background-color: rgba(0, 0, 0, 0.6); 
		}
		
		/* 리뷰 모달 전체 박스 */
		.review-modal {
		  font-family: 'Arial', sans-serif;
		}
		
		/* 리뷰 하나 박스 */
		.review-box {
		  padding: 15px;
		  margin-bottom: 20px;
		  background-color: #f9f9f9;
		  border-radius: 10px;
		  border: 1px solid #ddd;
		  box-shadow: 0 2px 5px rgba(0,0,0,0.05);
		}
		
		/* 리뷰 사이의 구분선 제거 (이미 박스로 구분되니까) */
		.review-box hr {
		  display: none;
		}
		
		/* 별점 + 날짜 */
		.review-line1 {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		}
		
		/* 별 모양 */
		.stars .star {
		  color: gold;
		  font-size: 18px;
		  margin-right: 2px;
		}
		.stars .star.gray {
		  color: #ccc;
		}
		
		/* 닉네임, 목적, hostIp */
		.review-line2 {
		  display: flex;
		  justify-content: space-between;
		  font-size: 14px;
		  color: #555;
		  margin-top: 5px;
		}
		
		/* 객실 이름 */
		.review-line3 {
		  font-weight: bold;
		  margin-top: 5px;
		  color: #333;
		}
		
		/* 내용 */
		.review-content {
		  margin-top: 8px;
		  line-height: 1.5;
		  white-space: pre-wrap;
		}
		.modal-header {
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  position: relative;
		}
		
		.modal-header .modal-title {
		  flex-grow: 1;
		  text-align: center;
		}
		
		.modal-header .btn-close {
		  position: absolute;
		  right: 1rem;
		}
		
		.room-details-guide {
		  margin-top: 3rem;
		  padding: 1.5rem;
		  background-color: #f9f9f9;
		  border-radius: 12px;
		  line-height: 1.6;
		}
		
		.room-details-guide h4,
		.room-details-guide h5 {
		  margin-top: 1rem;
		  color: #333;
		}
		
		.room-details-guide ul {
		  margin-left: -0.5rem;
		  list-style: disc;
		}
		
		.review-preview-container{
			margin-top: 1rem;
		}
		#allReviewShow {
			text-decoration: none;
   		margin-bottom: 5px;
    	margin-right: 2px;
		}	
		
		.warning-banner {
		  background-color: #f8d7da; /* 붉은 배경 */
		  color: #721c24; /* 붉은색 텍스트 */
		  padding: 15px;
		  border-radius: 8px;
		  font-size: 1rem;
		  font-weight: bold;
		  margin-bottom: 20px;
		  text-align: center;
		}
		
		.warning-banner strong {
		  color: #c82333;
		}
		
		
		
		/* 모달 전체 배경 */
		.image-modal {
		  display: none;
		  position: fixed;
		  z-index: 10000;
		  inset: 0; /* top, right, bottom, left 0 */
		  background-color: rgba(0, 0, 0, 0.3);
		  justify-content: center;
		  align-items: flex-start; /* 스크롤 시 위에서부터 보이게 */
		  overflow-y: auto; 
			}
		
		.image-modal-content {
		  position: relative;
		  background-color: white;
		  margin: auto auto;
		  padding: 3rem 0 1rem 0;
		  width: 90%;
		  max-width: 1000px;
		  height: 100vh; 
		  overflow-y: auto; /* ✅ 내부 스크롤 가능하게 */
		  border-radius: 16px;
		  box-shadow: 0 0 20px rgba(0,0,0,0.6);
		}
		
		/* 닫기 버튼 */
		.image-modal-close {
		  position: absolute;
		  top: 0px;
		  right: 13px;
		  font-size: 28px;
		  font-weight: bold;
		  color: #888;
		  cursor: pointer;
		}
		
		.image-modal-close:hover {
		  color: #000;
		}
		
		/* 이미지 리스트 */
		.modal-images {
		  display: flex;
		  flex-wrap: wrap;
		  justify-content: center;
		  gap: 1.2rem;
		}
		
		/* 이미지 크기: 슬라이드와 동일 */
		.modal-images img {
		  width: 100%;
		  max-width: 48%;
		  height: auto;
		  object-fit: cover;
		  border-radius: 12px;
		  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.6);
		}
		
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="room-detail-container">
  <div class="room-header">
    <h2 class="room-title">${vo.name}</h2>
    <div class="room-price"><fmt:formatNumber value="${vo.price}" type="number" pattern="#,##0" />원 / 1박</div>
  </div>

	<!-- 이미지 슬라이드 -->
  <div class="room-slider swiper">
	  <div class="swiper-wrapper">
	    <!-- 썸네일 먼저 -->
	    <div class="swiper-slide">
	      <img src="${ctp}/roomThumbnail/${vo.thumbnail}" alt="${vo.name}" onclick="openModal()" />
	    </div>
	
	    <!-- 나머지 이미지 -->
	    <c:if test="${!empty vo.images}">
	      <c:set var="roomImages" value="${fn:split(vo.images, '/')}" />
	      <c:forEach var="roomImage" items="${roomImages}">
	        <div class="swiper-slide">
	          <img src="${ctp}/roomImages/${roomImage}" alt="객실 이미지" onclick="openModal()" />
	        </div>
	      </c:forEach>
	    </c:if>
	  </div>
	
	  <!-- 네비게이션 (옵션) -->
	  <div class="swiper-button-next"></div>
	  <div class="swiper-button-prev"></div>
	  <div class="swiper-pagination"></div>
	</div>
	
	<!-- 이미지 모달 -->
	<div id="imageModal" class="image-modal" onclick="closeModal(event)">
	  <div class="image-modal-content">
	    <span class="image-modal-close" onclick="closeModal()">&times;</span>
	    <div class="modal-images">
	      <img src="${ctp}/roomThumbnail/${vo.thumbnail}" alt="썸네일" />
	      <c:if test="${!empty vo.images}">
	        <c:forEach var="img" items="${roomImages}" varStatus="st">
	          <img src="${ctp}/roomImages/${img}" alt="객실 이미지" />
	        </c:forEach>
	      </c:if>
	    </div>
	  </div>
	</div>
	

  <div class="room-info">
    <ul>
      <li>👥 최대 ${vo.maxPeople}인</li>
      <li>🐶 ${vo.petSizeLimit}견까지 동반 가능</li>
      <li>🐾 반려견 최대 ${vo.petCountLimit}마리</li>
    </ul>
  </div>

  <div class="room-options">
	  <h4>🛎️ 시설 / 서비스</h4>
	  <div class="option-grid">
	    <c:forEach items="${roomOptionList}" var="optionVo">
	      <div class="option-item">
	        <img src="${ctp}/images/check.png" alt="체크" />
	        <span>${optionVo.name}</span>
	      </div>
	    </c:forEach>
	  </div>
	</div>

	
	<div class="room-details-guide">
	  <h4>📋기본 정보 및 반려견 동반 안내</h4>
	  <ul>
	    <li>상기 이미지는 실제와 다를 수 있습니다.</li>
	    <li>객실은 취사가 불가하며, 반려견 동반이 가능합니다.</li>
	  </ul>
	  
		<div class="warning-banner">
		  <p><strong>⚠️ 입실 시 반려견의 크기와 수에 따라 추가 요금이 발생합니다!</strong></p>
		  <p>소형견 1마리: 10,000원 / 중형견 1마리: 15,000원 / 대형견 1마리: 20,000원</p>
		</div>
		
	  <h5>■ 객실 제공 서비스 안내</h5>
	  <ul>
	    <li>펫 객실 비품: 방석, 식기, 배변판, 배변시트 3ea, 펫타월 2ea, 접착 테이프, 탈취제, 고정형 목줄(1.5m)</li>
	    <li>펫 플레이그라운드 무료 이용</li>
	    <li>펫플레이그라운드 이용은 보호자와 함께 동반한 반려견만 가능합니다.</li>
	  </ul>
	
	  <h5>■ 반려동물 입실 기준</h5>
	  <ul>
	    <li>반려동물 입실 시 체급 분류가 적용됩니다: 소형 ~10kg / 중형 11~15kg / 중대형 16~25kg / 대형 26~45kg</li>
	    <li>객실 타입별 허용 마리 수가 다를 수 있으며, 중대형견 이상은 추가 요금이 부과될 수 있습니다.</li>
	    <li>반려동물 입실 시, 보호자는 반드시 입실 규정을 준수해야 하며, 맹견, 3개월 이하의 강아지 및 공격성이 강한 견종은 입실이 불가합니다.</li>
	  </ul>
	
	  <h5>■ 반려동물 입실 구비서류</h5>
	  <ul>
	    <li>광견병, 종합백신 접종확인서 (연령별 기준 있음)</li>
	    <li>추가 요금: 소형/중형 3만원, 중대형 4만원, 대형 5만원</li>
	    <li>맹견, 3개월 이하, 공격성 강한 견종 불가</li>
	  </ul>
	
	  <h5>■ 기타 안내</h5>
	  <ul>
	    <li>객실 기본 크기: 132.23㎡ / 최대 9인까지 이용 가능 (객실마다 다를 수 있습니다)</li>
	    <li>기본 구성: 침실, 파우더룸, 거실, 주방, 욕실 등</li>
	    <li>※ 객실 내 취사 및 조리 불가, 일부 객실에는 제한된 조리 시설이 제공될 수 있습니다.</li>
	    <li>※ 객실 내 시설 및 비품은 객실 유형에 따라 다를 수 있습니다.</li>
	  </ul>
	</div>
	
	<!-- 리뷰 미리보기 -->
	<div class="review-preview-container">
		<h4>리뷰</h4>
		<c:if test="${!empty rVos}">
			<a id="allReviewShow" href="#" class="text-end" data-bs-toggle="modal" data-bs-target="#myModal" style="display:block">전체 리뷰 보기</a>
		  <c:forEach var="ReviewVo" items="${rVos}" varStatus="st">
		    <c:if test="${st.index < 2}">
		      <div class="review-box">
		        <!-- 별점 + 날짜 -->
		        <div class="review-line1">
		          <div class="stars">
		            <c:forEach var="i" begin="1" end="${ReviewVo.star}">
		              <span class="star">★</span>
		            </c:forEach>
		            <c:forEach var="i" begin="${ReviewVo.star + 1}" end="5">
		              <span class="star gray">★</span>
		            </c:forEach>
		          </div>
		          <div class="date">${fn:substring(ReviewVo.reviewDate, 0, 10)}</div>
		        </div>
		        <div class="review-line2">
		          <div class="writer">${ReviewVo.nickName} | ${ReviewVo.purpose}</div>
		          <c:if test="${sLevel == 0}">
		            <div class="host-ip">${ReviewVo.hostIp}</div>
		          </c:if>
		        </div>
		        <div class="review-line3">${ReviewVo.roomName}</div>
		        <div class="review-content">${ReviewVo.content}</div>
		      </div>
		    </c:if>
		  </c:forEach>
	  </c:if>
	  <c:if test="${empty rVos}"><div class="mt-2">아직 작성된 리뷰가 없습니다.</div></c:if>
	</div>
	
	<c:if test="${vo.mid == sMid}">
	  <div class="room-owner-actions">
	    <a href="roomUpdate?roomIdx=${vo.idx}" class="btn-secondary">객실 정보 수정</a>
	    <a href="roomImageUpdate?roomIdx=${vo.idx}" class="btn-tertiary">객실 이미지 수정</a>
	    <c:if test="${vo.status != '서비스중지요청'}">
	      <a href="javascript:roomDeleteCheck()" class="btn-danger">객실 서비스 중지 요청</a>
	    </c:if>
	  </div>
	</c:if>
	
	<!-- 예약 고정 바 (컨테이너 내부에 위치) -->
	<div class="room-reserve-bar-wrapper">
	  <div class="room-reserve-bar">
	    <div class="reserve-left">
	      <div class="reserve-dates">${fn:substring(checkinDate,5,10)}~${fn:substring(checkoutDate,5,10)}</div>
	      <div class="reserve-summary">
	        <strong><fmt:formatNumber value="${vo.price * nights}" type="number" pattern="#,##0" />원</strong>
	      </div>
	    </div>
	    <form action="${ctp}/reservation/reservationForm" method="get" class="reserve-form">
	      <input type="hidden" name="roomIdx" value="${vo.idx}" />
	      <input type="hidden" name="searchString" value="${searchString}" />
	      <input type="hidden" name="checkinDate" value="${checkinDate}" />
	      <input type="hidden" name="checkoutDate" value="${checkoutDate}" />
	      <input type="hidden" name="guestCount" value="${guestCount}" />
	      <input type="hidden" name="petCount" value="${petCount}" />
	      <input type="hidden" name="nights" value="${nights}" />
	      <input type="submit" value="예약하기" class="btn-reserve" />
	    </form>
	  </div>
	</div>
	
	
	<!-- 모달창으로 리뷰 띄우기 -->
	<div class="modal modal-lg" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content review-modal">
	      <div class="modal-header">
				  <h3 class="modal-title" id="exampleModalLabel">리뷰</h3>
				  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
	
	      <div class="modal-body">
	        <c:forEach var="ReviewVo" items="${rVos}">
	          <div class="review-box">
	            <!-- 1줄: 별점 + 날짜 -->
	            <div class="review-line1">
	              <div class="stars">
	                <c:forEach var="i" begin="1" end="${ReviewVo.star}">
	                  <span class="star">★</span>
	                </c:forEach>
	                <c:forEach var="i" begin="${ReviewVo.star + 1}" end="5">
	                  <span class="star gray">★</span>
	                </c:forEach>
	              </div>
	              <div class="date">${fn:substring(ReviewVo.reviewDate, 0, 10)}</div>
	            </div>
	
	            <!-- 2줄: 닉네임 | 목적    hostIp (관리자만) -->
	            <div class="review-line2">
	              <div class="writer">${ReviewVo.nickName} | ${ReviewVo.purpose}</div>
	              <c:if test="${sLevel == 0}">
	                <div class="host-ip">${ReviewVo.hostIp}</div>
	              </c:if>
	            </div>
	
	            <!-- 3줄: 객실 이름 -->
	            <div class="review-line3">${ReviewVo.roomName}</div>
	
	            <!-- 4줄: 내용 -->
	            <div class="review-content">${ReviewVo.content}</div>
	
	            <hr />
	          </div>
	        </c:forEach>
	      </div>
	    </div>
	  </div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
	new Swiper('.room-slider', {
	  loop: true,
	  pagination: {
	    el: '.swiper-pagination',
	    clickable: true
	  },
	  navigation: {
	    nextEl: '.swiper-button-next',
	    prevEl: '.swiper-button-prev'
	  },
	  autoplay: {
	    delay: 5000,
	    disableOnInteraction: false
	  }
	});
	
	// 모달 관련 요소들 선택
	const modal = document.getElementById('imageModal');
	const closeModalBtn = document.querySelector('.image-modal-close');

	// 모달 열기 함수
	function openModal() {
	  modal.style.display = 'flex';  // 모달을 보이게 설정
	}

	// 모달 닫기 함수
	function closeModal(event) {
	  if (event) {
	    // 모달 외부를 클릭하면 닫히도록
	    if (event.target === modal) {
	      modal.style.display = 'none';
	    }
	  } else {
	    modal.style.display = 'none';  // 닫기 버튼 클릭 시 모달 닫기
	  }
	}

	// 닫기 버튼 클릭 시 모달 닫기
	closeModalBtn.addEventListener('click', closeModal);
	
</script>
</body>
</html>