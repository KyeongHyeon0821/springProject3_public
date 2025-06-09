<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 관리자 상세보기</title>
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
      text-align: left;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
      width: 150px;
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

    a {
      text-decoration: none;
      color: inherit;
      transition: font-weight 0.2s;
    }

    a:hover {
      font-weight: 600;
    }

    .btn {
      font-size: 1rem;
    }
  </style>
  <script>
    'use strict';

    function deleteCheck(idx) {
        let ans = confirm("현재 게시글을 삭제하시겠습니까?");
        if (ans) location.href = "adFaqDetailDelete?idx=${vo.idx}";
      }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
  <div class="col m-3 text-center">
	  <span class="my-page-header">FAQ 관리자 상세보기</span>
	</div>

<div class="container">
  <div class="section-box">
  	<form name="myform" method="post">
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
	        <td>${vo.title}</td>
	        <th>분류</th>
	        <td>${vo.category}</td>
	        <th>조회수</th>
	        <td>${vo.readNum}</td>
	      </tr>
	      <tr>
	        <th>내용</th>
	        <td colspan="5">
	          <div style="min-height:300px; height:auto;">${vo.content}</div>
	        </td>
	      </tr>
	    </table>
	
	    <div class="text-center mt-4">
	      <input type="button" value="수정하기" onclick="location.href='${ctp}/faq/adFaqUpdate?idx=${vo.idx}';" class="btn btn-outline-warning"/>
	      <input type="button" value="삭제하기" onclick="deleteCheck(${vo.idx})" class="btn btn-outline-danger"/>
	      <a href="${ctp}/faq/adFaqList" class="btn btn-outline-secondary me-2">목록으로</a>
	    </div>
	    <input type="hidden" name="idxSelect" value="${vo.idx}"/>
	   </form>
  </div>
</div>

<p><br/></p>
</body>
</html>
