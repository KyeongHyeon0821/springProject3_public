<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>쿠폰 수정</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    .form-container {
      max-width: 800px;
      margin: 0 auto;
      padding: 2rem;
      background-color: #f9f9f9;
      border-radius: 1rem;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .form-title {
      text-align: center;
      margin-bottom: 2rem;
      font-size: 1.8rem;
      font-weight: bold;
    }
    .form-group {
      margin-bottom: 1.5rem;
    }
    .form-label {
      font-weight: 600;
      margin-bottom: 0.5rem;
      display: block;
    }
    .form-input,
    .form-select {
      width: 100%;
    }
    .form-button {
      display: flex;
      justify-content: center;
      gap: 1rem;
    }
    img.preview-img {
      max-width: 35%;
      margin-bottom: 1rem;
    }
  </style>
  <script>
    'use strict';
    
    function discountTypeCheck(discountType) {
      if(discountType === 'P') {
        document.getElementById("discountPercentGroup").style.display = 'block';
        document.getElementById("discountAmountGroup").style.display = 'none';
      } else {
        document.getElementById("discountPercentGroup").style.display = 'none';
        document.getElementById("discountAmountGroup").style.display = 'block';
      }
    }

    function fCheck() {
      const couponName = document.getElementById("couponName").value.trim();
      if (couponName === "") {
        alert("쿠폰 이름을 적어주세요");
        document.getElementById("couponName").focus();
        return false;
      }

      const fileInput = document.getElementById("fName");
      if (fileInput.value !== "") {
        const ext = fileInput.value.substring(fileInput.value.lastIndexOf('.') + 1).toLowerCase();
        const maxSize = 1024 * 1024 * 5;
        const fileSize = fileInput.files[0].size;

        if (!['jpg', 'gif', 'png'].includes(ext)) {
          alert("그림파일만 업로드 가능합니다.");
          return false;
        }
        if (fileSize > maxSize) {
          alert("업로드할 파일의 최대용량은 5MByte입니다.");
          return false;
        }
      }

      document.couponForm.submit();
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <div class="form-container">
    <div class="form-title">쿠폰 수정하기</div>
    <form name="couponForm" method="post" enctype="multipart/form-data">
      
      <div class="form-group">
        <label class="form-label" for="couponType">쿠폰 타입</label>
        <select name="couponType" id="couponType" class="form-select">
          <option value="R" ${vo.couponType == 'R' ? 'selected' : ''}>예약쿠폰</option>
          <option value="E" ${vo.couponType == 'E' ? 'selected' : ''}>이벤트쿠폰</option>
        </select>
      </div>

      <div class="form-group">
        <label class="form-label" for="couponName">발행 쿠폰 이름</label>
        <input type="text" name="couponName" id="couponName" value="${vo.couponName}" class="form-control form-input"/>
      </div>

      <div class="form-group">
        <label class="form-label">할인 형태</label>
        <input type="radio" name="discountType" id="discountTypeP" value="P" ${vo.discountType=='P' ? 'checked' : ''} onclick="discountTypeCheck('P')">
        <label for="discountTypeP">%(퍼센트)</label>
        &nbsp;
        <input type="radio" name="discountType" id="discountTypeA" value="A" ${vo.discountType=='A' ? 'checked' : ''} onclick="discountTypeCheck('A')">
        <label for="discountTypeA">원(현금)</label>
      </div>

      <c:choose>
        <c:when test="${vo.discountType=='P'}">
          <div class="form-group" id="discountPercentGroup" style="display:block;">
            <label class="form-label" for="discountValueP">할인율</label>
            <div class="input-group">
              <input type="number" name="discountValue" id="discountValueP" value="${vo.discountValue}" class="form-control"/>
              <span class="input-group-text">%</span>
            </div>
          </div>
          <div class="form-group" id="discountAmountGroup" style="display:none;"></div>
        </c:when>
        <c:otherwise>
          <div class="form-group" id="discountPercentGroup" style="display:none;"></div>
          <div class="form-group" id="discountAmountGroup" style="display:block;">
            <label class="form-label" for="discountValueA">할인액</label>
            <div class="input-group">
              <input type="number" name="discountValue" id="discountValueA" value="${vo.discountValue}" class="form-control"/>
              <span class="input-group-text">원</span>
            </div>
          </div>
        </c:otherwise>
      </c:choose>

      <div class="form-group">
        <label class="form-label" for="issueDate">쿠폰 발행일</label>
        <input type="date" name="issueDate" id="issueDate" value="${fn:substring(vo.issueDate,0,10)}" class="form-control"/>
      </div>

      <div class="form-group">
        <label class="form-label" for="expiryDate">쿠폰 만료일</label>
        <input type="date" name="expiryDate" id="expiryDate" value="${fn:substring(vo.expiryDate,0,10)}" class="form-control"/>
      </div>

      <div class="form-group">
        <label class="form-label">쿠폰 활성화</label>
        <input type="radio" name="isActive" id="isActive0" value="0" ${vo.isActive=='0' ? 'checked' : ''}> 비활성화 &nbsp;
        <input type="radio" name="isActive" id="isActive1" value="1" ${vo.isActive=='1' ? 'checked' : ''}> 활성화
      </div>

      <div class="form-group">
        <label class="form-label" for="fName">안내 사진</label>
        <div>
          <img src="${ctp}/coupon/${vo.photo}" alt="기존 쿠폰 이미지" class="preview-img"/>
        </div>
        <input type="file" name="fName" id="fName" class="form-control"/>
      </div>

      <div class="form-button">
        <input type="button" value="쿠폰 수정" onclick="fCheck()" class="btn btn-success"/>
        <input type="reset" value="다시작성" class="btn btn-warning"/>
        <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adCouponList';" class="btn btn-info"/>
      </div>
    </form>
  </div>
</div>
<p><br/></p>
</body>
</html>
