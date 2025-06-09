<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adCouponContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <style>
		  /* 전체 레이아웃 컨테이너 */
		.container {
		  max-width: 1100px;
		  margin: 0 auto;
		  padding: 40px 20px;
		  background-color: #fff;
		  border-radius: 12px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		}
		
		/* 본문 내용 wrapper */
		.form-container {
		  display: flex;
		  flex-direction: column;
		  gap: 20px;
		  max-width: 600px; /* ✅ 추가: 쿠폰 상세보기 내용만 줄이기 */
		  margin: 0 auto;   /* 가운데 정렬 */
		}
		
		/* 항목 간 여백 및 정렬 */
		.mb-3 {
		  display: flex;
		  flex-direction: column;
		}
		
		/* 제목 */
		h2 {
		  font-size: 1.75rem;
		  font-weight: bold;
		  color: #333;
		}
		
		/* 라벨 */
		.form-label {
		  font-weight: 600;
		  color: #444;
		  margin-bottom: 6px;
		}
		
		/* 텍스트 출력용 (읽기 전용 느낌) */
		.form-control-plaintext {
		  padding: 10px 14px;
		  background-color: #f8f9fa;
		  border: 1px solid #dee2e6;
		  border-radius: 8px;
		  color: #333;
		  max-width: 100%;       /* ✅ 전체 박스 안에서만 */
		  width: 100%;           /* ✅ 내용 너비를 꽉 채움 */
		  box-sizing: border-box;
		}
		
		/* 이미지 */
		img {
		  border-radius: 8px;
		  border: 1px solid #ddd;
		}
		
		/* 반응형 (선택 사항) */
		@media (max-width: 576px) {
		  .container {
		    padding: 20px 12px;
		  }
		  h2 {
		    font-size: 1.4rem;
		  }
		}
		
		/* 테이블 헤더 스타일 */
		th {
		  text-align: center;
		  vertical-align: middle;
		  background-color: #eee !important;
		}

  </style>
  <script>
    'use strict';
  
    // QR코드 모달로 보기
    function qrCodeView(qrcode) {
			$(".modal-body #imgSrc").attr("src","${ctp}/resources/data/couponQrcode/"+qrcode);
    }
    
    // 쿠폰 사용처리
    function couponCheck(userCouponCode) {
    	let ans = confirm("현재 쿠폰사용자를 사용완료처리 하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "${ctp}/admin/adUserCouponCodeUsed",
    		type : "post",
    		data : {userCouponCode : userCouponCode},
    		success:function(res) {
    			if(res != "0") {
    				alert("쿠폰이 정상적으로 사용처리 되었습니다.");
    				location.reload();
    			}
    			else alert("쿠폰 사용 처리 불가~");
    		},
    		error : function() { alert("전송오류!"); }
    	});
    }
  </script>
</head>
<body>
<p><br/></p>
<!-- 쿠폰 상세 정보 -->
<div class="container">
  <h2 class="text-center mb-4">쿠폰 정보 상세보기</h2>

  <div class="form-container">

    <!-- 쿠폰타입 -->
    <div class="mb-3">
      <label class="form-label">쿠폰타입</label>
      <p class="form-control-plaintext">
        <c:if test="${vo.couponType == 'R'}">예약쿠폰</c:if>
        <c:if test="${vo.couponType == 'E'}">이벤트쿠폰</c:if>
      </p>
    </div>

    <!-- 쿠폰이름 -->
    <div class="mb-3">
      <label class="form-label">발행쿠폰이름</label>
      <p class="form-control-plaintext">${vo.couponName}</p>
    </div>

    <!-- 할인형태 -->
    <div class="mb-3">
      <label class="form-label">할인형태</label>
      <p class="form-control-plaintext">
        <c:if test="${vo.discountType == 'P'}">퍼센트 (%)</c:if>
        <c:if test="${vo.discountType == 'A'}">현금 (원)</c:if>
      </p>
    </div>

    <!-- 할인값 -->
    <div class="mb-3">
      <c:if test="${vo.discountType == 'P'}">
        <label class="form-label">할인율</label>
        <p class="form-control-plaintext">${vo.discountValue} %</p>
      </c:if>
      <c:if test="${vo.discountType == 'A'}">
        <label class="form-label">할인액</label>
        <p class="form-control-plaintext"><fmt:formatNumber value="${vo.discountValue}" type="number" pattern="#,##0" /> 원</p>
      </c:if>
    </div>

    <!-- 발행일 -->
    <div class="mb-3">
      <label class="form-label">쿠폰발행일</label>
      <p class="form-control-plaintext">${fn:substring(vo.issueDate,0,10)}</p>
    </div>

    <!-- 만료일 -->
    <div class="mb-3">
      <label class="form-label">쿠폰만료일</label>
      <p class="form-control-plaintext">${fn:substring(vo.expiryDate,0,10)}</p>
    </div>

    <!-- 쿠폰 활성화 -->
    <div class="mb-3">
      <label class="form-label">쿠폰활성화</label>
      <p class="form-control-plaintext">
        <c:if test="${vo.isActive == '0'}">비활성화</c:if>
        <c:if test="${vo.isActive == '1'}">활성화</c:if>
      </p>
    </div>

    <!-- 안내사진 -->
		<div class="mb-3">
		  <label class="form-label">안내사진</label><br/>
		  <img src="${ctp}/coupon/${vo.photo}" style="width: 40%;" />
		</div>

  </div>
  
  
  <hr class="board-secondary"/>

  <!-- 쿠폰 발급 내역 테이블 (유지) -->
  <div>
    <h4>쿠폰 발급 내역</h4>
    <table class="table table-hover text-center">
      <tr class="table-secondary">
        <th>번호</th>
        <th>쿠폰번호</th>
        <th>발급자 아이디</th>
        <th>발급 메일주소</th>
        <th>쿠폰 발급일자</th>
        <th>쿠폰사용여부</th>
        <th>쿠폰사용날짜</th>
        <th>QR코드</th>
        <th>비고</th>
      </tr>
      <c:forEach var="cvo" items="${vos}" varStatus="st">
        <tr>
          <td>${st.count}</td>
          <td>${cvo.userCouponCode}</td>
          <td>${cvo.mid}</td>
          <td>${cvo.email}</td>
          <td>${fn:substring(cvo.userIssueDate,0,16)}</td>
          <td>
            <c:if test="${cvo.isUse == '미사용'}"><span class="badge bg-success">${cvo.isUse}</span></c:if>
            <c:if test="${cvo.isUse != '미사용'}"><span class="badge bg-warning">${cvo.isUse}</span></c:if>
          </td>
          <td>
            <c:if test="${cvo.isUse == '미사용'}">미사용</c:if>
            <c:if test="${cvo.isUse != '미사용'}">${fn:substring(cvo.usedDate,0,16)}</c:if>
          </td>
          <td>
            <a href="#" onclick="qrCodeView('${cvo.couponQrcode}')" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#myCouponModal">상세보기</a>
          </td>
          <td>
            <input type="button" value="사용처리" onclick="couponCheck('${cvo.userCouponCode}')" class="btn btn-primary btn-sm"/>
          </td>
        </tr>
      </c:forEach>
    </table>
  </div>

  <!-- 돌아가기 버튼 -->
  <div class="text-center">
    <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adCouponList';" class="btn btn-info"/>
  </div>
</div>

<!-- The Modal -->
<div class="modal fade" id="myCouponModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-sm">
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 id="title"><span>발행된 QR코드 이미지</span></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <img id="imgSrc" width="470px" /><br/>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<p><br/></p>
</body>
</html>