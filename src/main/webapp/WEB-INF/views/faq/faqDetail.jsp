<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 상세보기</title>
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
      border-collapse: collapse;
    }

    table th {
      background-color: #e0f5e9 !important;
      color: #444 !important;
      padding: 12px;
      text-align: left;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
      width: 150px;
    }

    table td {
      background-color: #fff;
      padding: 14px 12px;
      vertical-align: middle;
      border-bottom: 1px solid #e5e5e5;
    }

    a {
      color: inherit;
      text-decoration: none;
      transition: font-weight 0.2s;
    }

    a:hover {
      font-weight: 600;
    }

    .btn {
      font-size: 1rem;
    }

    .pagination .page-link {
      color: #2e7d32;
      border: 1px solid #cde7d6;
    }

    .pagination .page-item.active .page-link {
      background-color: #2e7d32;
      border-color: #2e7d32;
      color: white;
    }

    hr.border-secondary {
      margin: 50px 0 20px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="col m-3 text-center">
  <span class="my-page-header">FAQ 상세보기</span>
</div>
<div class="container">
  <div class="section-box">
    <table class="table">
      <colgroup>
        <col style="width: 10%;">
        <col style="width: 50%;">
        <col style="width: 10%;">
        <col style="width: 15%;">
        <col style="width: 10%;">
        <col style="width: 5%;">
      </colgroup>
      <tr>
        <th>제목</th>
        <td style="border-top: 1px solid #e5e5e5;">${vo.title}</td>
        <th>분류</th>
        <td style="border-top: 1px solid #e5e5e5;">${vo.category}</td>
        <th>조회수</th>
        <td style="border-top: 1px solid #e5e5e5;">${vo.readNum}</td>
      </tr>
      <tr>
        <th>내용</th>
        <td colspan="5">
          <div style="min-height:300px; height:auto;">${vo.content}</div>
        </td>
      </tr>
    </table>

    <div class="text-center mt-4">
      <a href="${ctp}/faq/faqList" class="btn btn-outline-success me-2">목록으로</a>
    </div>

    <hr class="border-secondary">

    <!-- 이전글/다음글 -->
    <div class="row">
      <div class="col">
        <c:if test="${not empty nextVo.title}">
          👉 <a href="faqDetail?idx=${nextVo.idx}" style="text-decoration:none;">다음글 : ${nextVo.title}</a><br/>
        </c:if>
        <c:if test="${not empty preVo.title}">
          👈 <a href="faqDetail?idx=${preVo.idx}" style="text-decoration:none;">이전글 : ${preVo.title}</a><br/>
        </c:if>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
