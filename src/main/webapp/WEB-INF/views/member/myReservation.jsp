<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>myReservation.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />

  <style>
    body {
      background-color: #f9fefb;
      font-family: 'Arial', sans-serif;
    }

    h2.text-center {
      margin: 40px 0 30px;
      color: #2e7d32;
      font-weight: bold;
    }

    .table-hover th {
      background-color: #f0f8f5;
      color: #333;
      text-align: center;
    }

    .table-hover td {
      vertical-align: middle;
      text-align: center;
    }

    .table-hover tbody tr:hover {
      background-color: #eef8f0;
    }

    .no-reservation {
      text-align: center;
      margin-top: 40px;
      font-size: 18px;
      color: #888;
    }

    .btn-back {
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <div class="text-center" style="margin-top: 30px;">
	<img src="${ctp}/images/logo.png" width="150px" style="margin-bottom: 10px;" />
	<h2 style="color: #2e7d32; font-weight: bold; margin-top: 0; margin-bottom: 30px;">예약 내역</h2>
  </div>

  <c:if test="${!empty vos}">
    <table class="table table-hover">
      <thead>
        <tr>
          <th>번호</th>
          <th>예약번호</th>
          <th>예약자 이름</th>
          <th>연락처</th>
          <th>이메일</th>
          <th>금액</th>
          <th>상태</th>
        </tr>
      </thead>
      <tbody>
        <c:set var="vosSize" value="${fn:length(vos)}"/>
        <c:forEach items="${vos}" var="vo" varStatus="st">
          <tr>
            <td>${vosSize - st.index}</td>
            <td>
              <a href="${ctp}/reservation/reservationDetail/${vo.reservationNo}">
                ${vo.reservationNo}
              </a>
            </td>
            <td>${vo.name}</td>
            <td>${vo.tel}</td>
            <td>${vo.email}</td>
            <td><fmt:formatNumber value="${vo.totalPrice}" type="number" pattern="#,##0" />원</td>
            <c:choose>
              <c:when test="${vo.status eq '예약완료'}">
                <td style="color: #28a745; font-weight: bold;">${vo.status}</td>
              </c:when>
              <c:when test="${vo.status eq '취소됨'}">
                <td style="color: #dc3545; font-weight: bold;">${vo.status}</td>
              </c:when>
              <c:otherwise>
                <td>${vo.status}</td>
              </c:otherwise>
            </c:choose>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:if>

  <c:if test="${empty vos}">
    <div class="no-reservation">예약 내역이 없습니다.</div>
  </c:if>
  
  <div class="text-end btn-back">
    <a href="${ctp}/member/memberMyPage" class="btn btn-outline-secondary">돌아가기</a>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>