<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 리스트 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script>
    'use strict';
    function answerChoice() {
      let choice = $("#choice").val();
      if(choice != '') location.href = 'adInquiryList?choice=' + encodeURIComponent(choice);
    }
  </script>
  <style>
    body {
      background-color: #f9fefb;
      font-family: 'Arial', sans-serif;
      font-size: 1.1rem;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 40px 20px;
    }

    .my-page-header {
      text-align: center;
      font-weight: bold;
      font-size: 2rem;
      margin-bottom: 50px;
      color: #2e7d32;
    }

    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 60px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e0e0e0;
      margin: 40px auto;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 15px;
    }

    th {
      background-color: #e0f5e9;
      padding: 14px 20px;
      text-align: center;
      color: #444;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
    }

    td {
      background-color: #fff;
      padding: 14px 20px;
      text-align: center;
      border-bottom: 1px solid #e5e5e5;
    }

    tbody tr {
      border-bottom: 1px solid #e5e5e5;
    }

    td a {
      text-decoration: none;
      font-weight: 500;
      color: inherit;
      transition: font-weight 0.2s;
    }

    td a:hover {
      color: #4caf50;
      font-weight: 600;
      text-decoration: none;
    }

    .badge {
      display: inline-block;
      padding: 4px 10px;
      font-size: 0.9rem;
      font-weight: 500;
      border-radius: 10px;
      color: white;
    }

    .badge.bg-success {
      background-color: #388e3c;
    }

    .badge.bg-warning {
      background-color: #f9a825;
    }

    .badge.bg-secondary {
      background-color: #9e9e9e;
    }

    .pagination .page-link {
      color: #2e7d32;
      border-color: #2e7d32;
    }

    .pagination .active .page-link {
      background-color: #2e7d32;
      border-color: #2e7d32;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="col m-3 text-center">
  <span class="my-page-header">1:1 문의 리스트</span>
</div>

<div class="container">
  <div class="section-box">
    <div class="text-end mb-4">
      <div class="row justify-content-start">
        <div class="col-3">
          <select name="choice" id="choice" onChange="answerChoice()" class="form-select">
            <option value="전체" ${choice == "전체" ? "selected" : ""}>전체문의글</option>
            <option value="답변대기중" ${choice == "답변대기중" ? "selected" : ""}>답변대기중</option>
            <option value="답변완료" ${choice == "답변완료" ? "selected" : ""}>답변완료</option>
            <option value="답변보류" ${choice == "답변보류" ? "selected" : ""}>답변보류</option>
          </select>
        </div>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th class="text-center">제목</th>
          <th class="text-center">분류</th>
          <th class="text-center">작성일</th>
          <th class="text-center">상태</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${vos}">
          <tr>
            <td><a href="${ctp}/admin/inquiry/adInquiryDetail?idx=${vo.idx}">${vo.title}</a></td>
            <td>${vo.part}</td>
            <td>${vo.WDate.substring(0,16)}</td>
            <td>
              <c:if test="${vo.reply == '답변대기중'}">
                <span class="badge bg-secondary">${vo.reply}</span>
              </c:if>
              <c:if test="${vo.reply == '답변완료'}">
                <span class="badge bg-success">${vo.reply}</span>
              </c:if>
              <c:if test="${vo.reply == '답변보류'}">
                <span class="badge bg-warning">${vo.reply}</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty vos}">
          <tr>
            <td colspan="4" class="text-center">등록된 문의가 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
<!-- 블록페이지 시작 -->
<div class="text-center mt-4">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link" href="adInquiryList?part=${pageVo.part}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link" href="adInquiryList?part=${pageVo.part}&pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link" href="adInquiryList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link" href="adInquiryList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link" href="adInquiryList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link" href="adInquiryList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->
  </div>
</div>
</body>
</html>
