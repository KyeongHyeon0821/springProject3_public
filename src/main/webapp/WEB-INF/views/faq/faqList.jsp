<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FAQ 리스트</title>
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
      padding: 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .top-button {
      text-align: right;
      margin-bottom: 20px;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
    }

    th {
      background-color: #e0f5e9;
      padding: 12px;
      text-align: center;
      color: #444;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
    }

    td {
      background-color: #fff;
      padding: 14px 12px;
      text-align: center;
      border-bottom: 1px solid #e5e5e5;
    }

    tbody tr {
      border-bottom: 1px solid #e5e5e5;
    }

    td a {
      text-decoration: none;
      font-weight: 500;
    }

    td a:hover {
      color: #4caf50;
      text-decoration: none;
    }

    .pagination .page-link {
      color: #2e7d32;
      border-color: #2e7d32;
    }

    .pagination .active .page-link {
      background-color: #2e7d32;
      border-color: #2e7d32;
    }

    .no-data {
      text-align: center;
      padding: 30px 0;
      color: #888;
    }
  </style>
  <script>
    'use strict';

    function pageSizeCheck() {
      let pageSize = document.getElementById("pageSize").value;
      location.href = "faqList?pag=1&pageSize=" + pageSize;
    }

    function categoryCheck() {
      let category = $('#category').val();
      if (category != '') location.href = 'faqList?category=' + category;
    }

    function searchCheck() {
      let category = $('#category').val();
      let searchString = $('#searchString').val();
      if (searchString == '') {
        alert("검색어를 입력하세요");
        return false;
      }
      else location.href = 'faqList?searchString=' + searchString + '&category=' + category;
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">FAQ 리스트</span>
	</div>

  <div class="section-box">
    <div class="row m-0 mb-4">
      <div class="col-3">
        <select name="category" id="category" onchange="categoryCheck()" class="form-select me-3 mb-2">
          <option value="전체" ${category == "전체" ? "selected" : "" }>전체</option>
          <option ${pageVo.part == "예약" ? "selected" : "" }>예약</option>
          <option ${pageVo.part == "결제/환불" ? "selected" : "" }>결제/환불</option>
          <option ${pageVo.part == "회원정보" ? "selected" : "" }>회원정보</option>
          <option ${pageVo.part == "기타" ? "selected" : "" }>기타</option>
        </select>
      </div>
      <div class="col-3"></div>
      <div class="col-6">
        <div class="input-group mb-2">
          <input type="text" name="searchString" id="searchString" value="${pageVo.searchString}" placeholder="제목 검색가능" class="form-control"/>
          <button type="button" onclick="searchCheck()" class="btn btn-outline-secondary">검색</button>
        </div>
      </div>
    </div>

    <form name="myform">
      <table>
        <thead>
          <tr>
            <th class="text-center">번호</th>
            <th class="text-center">제목</th>
            <th class="text-center">조회수</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
          <c:forEach var="vo" items="${vos}">
            <tr>
              <td>${curScrStartNo}</td>
              <td class="text-start">
                <a href="${ctp}/faq/faqDetail?idx=${vo.idx}">
                  <b>[${vo.category}]</b> ${vo.title}
                </a>
              </td>
              <td>${vo.readNum}</td>
            </tr>
            <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
          </c:forEach>
          <c:if test="${empty vos}">
            <tr>
              <td colspan="3" class="no-data">등록된 FAQ가 없습니다.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </form>
<!-- 블록페이지 시작 -->
<div class="text-center mt-4">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link" href="faqList?part=${pageVo.part}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link" href="faqList?part=${pageVo.part}&pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link" href="faqList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link" href="faqList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link" href="faqList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link" href="faqList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>