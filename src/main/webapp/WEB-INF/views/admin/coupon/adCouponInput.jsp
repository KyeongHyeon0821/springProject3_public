<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adCouponInput.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    .form-container {
		  max-width: 700px;
		  margin: 0 auto;
		  padding: 30px;
		  border: 1px solid #ddd;
		  border-radius: 12px;
		  background-color: #fafafa;
		  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
		}
		
		.form-group {
		  margin-bottom: 20px;
		}
		
		.form-group label {
		  display: block;
		  font-weight: bold;
		  margin-bottom: 8px;
		}
		
		.radio-group {
		  display: flex;
		  gap: 15px;
		  align-items: center;
		}
		
		.input-group {
		  display: flex;
		  align-items: center;
		}
		
		.input-group .form-control {
		  flex: 1;
		}
		
		.input-group-text {
		  background-color: #eee;
		  border: 1px solid #ccc;
		  padding: 6px 12px;
		  border-left: none;
		}
		
		button.btn-primary {
		  padding: 10px 30px;
		  font-size: 16px;
		  border-radius: 8px;
		}
  </style>
  <script>
	  'use strict';
		
	  function discountTypeCheck(type) {
	    document.getElementById("discountPercentGroup").style.display = (type === 'P') ? 'block' : 'none';
	    document.getElementById("discountAmountGroup").style.display = (type === 'A') ? 'block' : 'none';
	  }
	
	  function fCheck() {
	    const couponName = $("#couponName").val().trim();
	    const discountType = $("input[name='discountType']:checked").val();
	    const issueDate = $("#issueDate").val();
	    const expiryDate = $("#expiryDate").val();
	    const isActive = $("input[name='isActive']:checked").val();
	    let discountValue = "";
	
	    if (couponName === "") {
	      alert("쿠폰 이름을 적어주세요");
	      $("#couponName").focus();
	      return false;
	    }
	
	    if (!discountType) {
	      alert("할인 형태를 선택해주세요");
	      return false;
	    }
	
	    if (discountType === 'P') {
	      discountValue = $("#discountValueP").val();
	      if (discountValue.trim() === "") {
	        alert("할인율을 입력해주세요");
	        $("#discountValueP").focus();
	        return false;
	      }
	    } else if (discountType === 'A') {
	      discountValue = $("#discountValueA").val();
	      if (discountValue.trim() === "") {
	        alert("할인액을 입력해주세요");
	        $("#discountValueA").focus();
	        return false;
	      }
	    }
	
	    if (!issueDate) {
	      alert("발행일을 선택해주세요");
	      $("#issueDate").focus();
	      return false;
	    }
	
	    if (!expiryDate) {
	      alert("만료일을 선택해주세요");
	      $("#expiryDate").focus();
	      return false;
	    }
	
	    if (!isActive) {
	      alert("쿠폰 활성화 여부를 선택해주세요");
	      return false;
	    }
	
	    // 파일 업로드 검사
	    const fileInput = document.getElementById("fName");
	    const file = fileInput.files[0];
	
	    if (!file) {
	      alert("안내 이미지를 선택해주세요");
	      return false;
	    }
	
	    const ext = file.name.substring(file.name.lastIndexOf(".") + 1).toLowerCase();
	    const maxSize = 1024 * 1024 * 5;
	
	    if (["jpg", "jpeg", "png", "gif"].indexOf(ext) === -1) {
	      alert("이미지 파일만 업로드 가능합니다 (jpg, jpeg, png, gif)");
	      return false;
	    }
	
	    if (file.size > maxSize) {
	      alert("업로드할 파일의 최대용량은 5MB입니다.");
	      return false;
	    }
	
	    // 전송
	    document.couponForm.submit();
		}
	</script>
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center mb-4">쿠폰 등록</h2>
  <form name="couponForm" method="post" enctype="multipart/form-data" class="form-container">

    <div class="form-group">
      <label for="couponType">쿠폰 타입</label>
      <select name="couponType" id="couponType" class="form-select">
        <option value="R">예약쿠폰</option>
        <option value="E">이벤트쿠폰</option>
      </select>
    </div>

    <div class="form-group">
      <label for="couponName">쿠폰 이름</label>
      <input type="text" name="couponName" id="couponName" class="form-control" />
    </div>

    <div class="form-group">
      <label>할인 형태</label>
      <div class="radio-group">
        <input type="radio" name="discountType" id="discountTypeP" value="P" onclick="discountTypeCheck('P')" />
        <label for="discountTypeP" class="mb-0">퍼센트(%)</label>

        <input type="radio" name="discountType" id="discountTypeA" value="A" onclick="discountTypeCheck('A')" />
        <label for="discountTypeA" class="mb-0">정액(원)</label>
      </div>
    </div>

    <div class="form-group" id="discountPercentGroup" style="display:none;">
      <label for="discountValueP ">할인율 (%)</label>
      <div class="input-group">
        <input type="number" name="discountValue" id="discountValueP" class="form-control" />
        <div class="input-group-text">%</div>
      </div>
    </div>

    <div class="form-group" id="discountAmountGroup" style="display:none;">
      <label for="discountValueA">할인액 (원)</label>
      <div class="input-group">
        <input type="number" name="discountValue" id="discountValueA" class="form-control" />
        <div class="input-group-text">원</div>
      </div>
    </div>

    <div class="form-group">
      <label for="issueDate">발행일</label>
      <input type="date" name="issueDate" id="issueDate" class="form-control" />
    </div>

    <div class="form-group">
      <label for="expiryDate">만료일</label>
      <input type="date" name="expiryDate" id="expiryDate" class="form-control" />
    </div>

    <div class="form-group">
      <label>쿠폰 활성화 여부</label>
      <div class="radio-group">
        <input type="radio" name="isActive" id="isActive0" value="0" />
        <label for="isActive0" class="mb-0">비활성화</label>
        <input type="radio" name="isActive" id="isActive1" value="1" />
        <label for="isActive1" class="mb-0">활성화</label>
      </div>
    </div>

    <div class="form-group">
      <label for="fName">안내 이미지</label>
      <input type="file" name="fName" id="fName" class="form-control" />
    </div>

    <div class="text-center mt-4">
      <button type="button" onclick="fCheck()" class="btn btn-primary">등록하기</button>
    </div>
  </form>
</div>

<script>
  
</script>
</body>
</html>