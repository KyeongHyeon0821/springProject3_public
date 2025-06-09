<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 검색결과</title>
  <script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>
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
	    margin-top: 30px;
	  }
	
	  table {
	    width: 100%;
	    border-collapse: separate;
	    border-spacing: 0 10px;
	  }
	
	  thead th {
	    background-color: #e0f5e9 !important;
	    color: #444 !important;
	    padding: 14px 12px;
	    text-align: center;
	    font-weight: 600;
	  }
	
	  tbody td {
	    background-color: #fff;
	    padding: 14px 12px;
	    text-align: center;
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
	
	  .badge {
	    display: inline-block;
	    padding: 4px 10px;
	    font-size: 0.9rem;
	    font-weight: 500;
	    border-radius: 10px;
	    color: white;
	  }
	
	  .badge-success {
	    background-color: #388e3c !important;
	  }
	
	  .badge-warning {
	    background-color: #f9a825 !important;
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
	  
	  .btn-outline-success.custom-hover {
	    border-color: #2e7d32;
	    color: #2e7d32;
	    transition: 0.3s;
	  }
	
	  .btn-outline-success.custom-hover:hover {
	    background-color: #2e7d32;
	    color: white;
	  }
	</style>
  <script>
    'use strict';
    function pageSizeCheck() {
      let pageSize = document.getElementById("pageSize").value;
      location.href = "qnaList?pag=1&pageSize=" + pageSize;
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">QnA 검색결과</span>
	</div>

  <div class="section-box mt-4">
  <div class="text-center">(${pageVo.searchStr}(으)로 ${pageVo.searchString}을(를) 검색한 결과 ${fn:length(vos)}건이 검색되었습니다.)</div>
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div>
        <select name="pageSize" id="pageSize" onchange="pageSizeCheck()" class="form-select form-select-sm w-auto d-inline">
          <option ${pageVo.pageSize==5 ? 'selected' : ''}>5</option>
          <option ${pageVo.pageSize==10 ? 'selected' : ''}>10</option>
          <option ${pageVo.pageSize==15 ? 'selected' : ''}>15</option>
          <option ${pageVo.pageSize==20 ? 'selected' : ''}>20</option>
        </select>
      </div>
      <div>
        <c:if test="${sLevel == 0}">
          <select name="qnaAnswer" id="qnaAnswer" onchange="qnaAnswerCheck()" class="form-select">
            <option value="전체" ${qnaAnswer == "전체" ? "selected" : ""}>전체보기</option>
            <option ${qnaAnswer == "답변대기" ? "selected" : ""}>답변대기</option>
            <option ${qnaAnswer == "답변완료" ? "selected" : ""}>답변완료</option>
          </select>
        </c:if>
        <c:if test="${sLevel != 0}">
          <button class="btn btn-outline-success" onclick="location.href='${ctp}/qna/qnaInput';">작성하기</button>
        </c:if>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th class="text-center">번호</th>
          <th class="text-center">답변상태</th>
          <th class="text-center">제목</th>
          <th class="text-center">작성자</th>
          <th class="text-center">작성날짜</th>
        </tr>
      </thead>
      <tbody>
        <c:set var="curScrStartNo" value="${pageVo.curScrStartNo}" />
        <c:forEach var="vo" items="${vos}">
          <tr>
            <td style="border-bottom: 1px solid #e5e5e5;">${vo.idx}</td>
            <td style="border-bottom: 1px solid #e5e5e5;">
              <c:if test="${vo.qnaSw != 'a' && vo.qnaAnswer == '답변완료'}">
                <span class="badge badge-success">답변완료</span>
              </c:if>
              <c:if test="${vo.qnaSw != 'a' && vo.qnaAnswer != '답변완료'}">
                <span class="badge badge-warning">답변대기</span>
              </c:if>
            </td>
            <td class="text-start" style="border-bottom: 1px solid #e5e5e5;">
              <c:if test="${vo.qnaSw == 'a'}">
                <span>ㄴ</span>
              </c:if>
              <c:choose>
                <c:when test="${vo.delCheck == 'OK'}">
                  <span style="color:#ccc">삭제된 자료입니다.</span>
                </c:when>
                <c:otherwise>
              	  <c:if test="${vo.openSw != 'OK'}"><i class="fa-solid fa-lock"></i></c:if>
                  <a href="${ctp}/qna/qnaDetail?idx=${vo.idx}" class="text-dark" >${vo.title}</a>
                </c:otherwise>
              </c:choose>
            </td>
            <td style="border-bottom: 1px solid #e5e5e5;">${vo.nickName}</td>
            <td style="border-bottom: 1px solid #e5e5e5;">${vo.WDate.substring(0,10)}</td>
          </tr>
          <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
        </c:forEach>

        <c:if test="${empty vos}">
          <tr>
            <td colspan="5" class="no-data">등록된 글이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>

<!-- 블록페이지 시작 -->
<div class="text-center mt-4">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link" href="qnaSearchList?part=${pageVo.part}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link" href="qnaSearchList?part=${pageVo.part}&pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
	    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link" href="qnaSearchList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link" href="qnaSearchList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link" href="qnaSearchList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link" href="qnaSearchList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->
    <!-- 검색기 -->
		<div class="text-center mt-4">
		  <form class="search-box" name="searchForm" method="post" action="qnaSearch" style="display: inline-flex; align-items: center; gap: 10px;">
		    <select name="search" id="search" style="border: 1px solid #2e7d32; border-radius: 5px; padding: 5px 10px; color: #2e7d32;">
		      <option value="title">제목</option>
		      <option value="nickName">작성자</option>
		      <option value="content">글내용</option>
		    </select>
		    <input type="text" name="searchString" id="searchString" required
		           style="border: 1px solid #2e7d32; border-radius: 5px; padding: 5px 10px;" />
		    <input type="submit" value="검색" 
		           class="btn btn-outline-success btn-sm custom-hover" />
		    <input type="hidden" name="pag" value="${pageVo.pag}" />
		    <input type="hidden" name="pageSize" value="${pageVo.pageSize}" />
		  </form>
		</div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>