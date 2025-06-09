<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adCoupon.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script>
    'use strict';
    
    function couponTypeCheck() {
    	let couponType = $("#couponType").val();
    	let couponActive = $("#couponActive").val();
    	location.href = "adCouponList?couponType="+couponType+"&couponActive="+couponActive;
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">발행된 쿠폰 리스트</h2>
  <div class="row m-2">
    <div class="col">
      <select name="couponType" id="couponType" onchange="couponTypeCheck()" class="form-select">
        <option value="" ${couponType=='전체' ? 'selected' : ''}>전체쿠폰타입</option>
        <option value="R" ${couponType=='R' ? 'selected' : ''}>예약쿠폰</option>
        <option value="E" ${couponType=='E' ? 'selected' : ''}>이벤트쿠폰</option>
      </select>
    </div>
    <div class="col">
      <select name="couponActive" id="couponActive" onchange="couponTypeCheck()" class="form-select">
        <option value=""  ${couponActive=='9' ? 'selected' : ''}>전체쿠폰</option>
        <option value="1" ${couponActive=='1' ? 'selected' : ''}>활성쿠폰</option>
        <option value="0" ${couponActive=='0' ? 'selected' : ''}>비활성쿠폰</option>
      </select>
    </div>
    <div class="col"></div>
    <div class="col text-end">
      <input type="button" value="쿠폰등록" onclick="location.href='adCouponInput'" class="btn btn-success"/>
    </div>
  </div>
  <table class="table table-hover text-center">
    <tr class="table-secondary">
      <th>번호</th>
      <th>쿠폰타입</th>
      <th>쿠폰명</th>
      <th>할인값(율)</th>
      <th>쿠폰최초발급일</th>
      <th>쿠폰사용만료일</th>
      <th>서비스여부</th>
      <th>비고</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStartNo}</td>
        <td>
          <c:if test="${vo.couponType == 'E'}">이벤트쿠폰</c:if>
          <c:if test="${vo.couponType == 'R'}">예약쿠폰</c:if>
        </td>
        <td><a href="adCouponContent/${vo.idx}">${vo.couponName}</a></td>
        <td>
          <c:if test="${vo.discountType=='A'}"><fmt:formatNumber value="${vo.discountValue}" pattern="#,##0" />원</c:if>
          <c:if test="${vo.discountType=='P'}"><fmt:formatNumber value="${vo.discountValue}" pattern="#,##0.0" />%</c:if>
        </td>
        <td>${fn:substring(vo.issueDate,0,10)}</td>
        <td>${fn:substring(vo.expiryDate,0,10)}</td>
        <td>${vo.isActive==1 ? "<div class='badge bg-success'>진행중</div>" : "<div class='badge bg-info'>사용중지</div>"}</td>
        <td>
          <a href="adCouponUpdate/${vo.idx}" class="badge bg-warning">수정</a>
        </td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
  </table>
  <br/>
  <!-- 블록페이지 시작 -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="adCouponList?pag=1&pageSize=${pageVo.pageSize}">첫페이지</a></li></c:if>
		  <c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="adCouponList?pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
		  <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize) + pageVo.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="adCouponList?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link text-secondary" href="adCouponList?pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		  </c:forEach>
		  <c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="adCouponList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
		  <c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="adCouponList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
</div>
<p><br/></p>
</body>
</html>