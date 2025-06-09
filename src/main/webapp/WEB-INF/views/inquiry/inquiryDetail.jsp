<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 상세보기</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
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
      margin-bottom: 30px;
      color: #2e7d32;
    }

    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 60px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e0e0e0;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
    }

    table th {
      background-color: #e0f5e9 !important;
      color: #444 !important;
      padding: 12px;
      text-align: center;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
    }

    table td {
      background-color: #fff;
      padding: 14px 12px;
      vertical-align: middle;
      border-top: 1px solid #e5e5e5;
      border-bottom: 1px solid #e5e5e5;
    }

    table tr:last-child td {
      border-bottom: 1px solid #e5e5e5 !important;
    }

    .btn {
      font-size: 1rem;
    }

    .img-thumbnail {
      border-radius: 8px;
      border: 1px solid #ddd;
    }

    .text-start {
      text-align: left !important;
    }
  </style>
  <script>
    'use strict';

    function inquiryUpdateCheck() {
      let ans = confirm("해당 문의글을 수정하시겠습니까?");
      if (!ans) return false;
      else location.href = "${ctp}/inquiry/inquiryUpdateCheck?idx=${vo.idx}";
    }

    function inquiryDeleteCheck() {
      let ans = confirm("해당 문의글을 삭제하시겠습니까?");
      if (!ans) return false;
      else location.href = "${ctp}/inquiry/inquiryDeleteCheck?idx=${vo.idx}";
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">1:1 문의 상세보기</span>
	</div>

  <div class="section-box">
    <table class="table text-center">
      <tr>
        <th style="width:15%;">작성자</th>
        <td style="width:35%; border-top: 1px solid #e5e5e5;">${vo.mid}</td>
        <th style="width:15%;">작성일시</th>
        <td style="width:35%; border-top: 1px solid #e5e5e5;"><c:out value="${vo.WDate.substring(0,16)}" /></td>
      </tr>
      <tr>
        <th>제목</th>
        <td style="border-top: 1px solid #e5e5e5;">${vo.title}</td>
        <th>분류</th>
        <td style="border-top: 1px solid #e5e5e5;">${vo.part}</td>
      </tr>
      <tr>
        <th>예약번호</th>
        <td style="border-top: 1px solid #e5e5e5;">
          <c:choose>
            <c:when test="${empty vo.reservation}">-</c:when>
            <c:otherwise>${vo.reservation}</c:otherwise>
          </c:choose>
        </td>
        <th>답변 상태</th>
        <td style="border-top: 1px solid #e5e5e5;">
          <c:choose>
            <c:when test="${vo.reply == '답변대기중'}">
              <span class="badge bg-secondary">${vo.reply}</span>
            </c:when>
            <c:when test="${vo.reply == '답변완료'}">
              <span class="badge bg-success">${vo.reply}</span>
            </c:when>
            <c:when test="${vo.reply == '답변보류'}">
              <span class="badge bg-warning">${vo.reply}</span>
            </c:when>
            <c:otherwise>
              <span class="badge bg-info">${vo.reply}</span>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr>
        <th>문의내용</th>
        <td colspan="5" class="text-start" style="border-top: 1px solid #e5e5e5;">
          <div style="min-height:300px; height:auto;">
            ${vo.content}
          </div>
        </td>
      </tr>
      <tr>
        <th>첨부파일</th>
        <td colspan="3" style="border-top: 1px solid #e5e5e5;">
          <c:if test="${not empty vo.FSName}">
            <img src="${ctp}/inquiry/${vo.FSName}" width="200px" class="img-thumbnail"
                 style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#imageModal" />
          </c:if>
          <c:if test="${empty vo.FSName}">없음</c:if>
        </td>
      </tr>
    </table>

    <div class="text-center mt-4">
      <c:if test="${vo.reply != '답변완료' && vo.reply != '답변보류'}">
        <input type="button" value="수정하기" onclick="inquiryUpdateCheck()" class="btn btn-outline-warning m-1">
        <input type="button" value="삭제하기" onclick="inquiryDeleteCheck()" class="btn btn-outline-danger m-1">
      </c:if>
      <button class="btn btn-outline-secondary" onclick="location.href='${ctp}/inquiry/inquiryList';">목록으로</button>
    </div>

    <c:if test="${vo.reply == '답변완료'}">
      <hr class="border-secondary mt-5 mb-3">
      <div class="border rounded p-3 bg-light">
        <p class="mt-2" style="white-space: pre-line;">${vo.reContent}</p>
      </div>
    </c:if>
  </div>
</div>

<!-- 이미지 모달 -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="imageModalLabel">첨부파일 이미지</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <c:if test="${!empty vo.FSName}">
          <img src="${ctp}/inquiry/${vo.FSName}" class="img-fluid"/>
        </c:if>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>