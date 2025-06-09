<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
<style>
  html, body {
    height: 100%;
  }
  body {
    display: flex;
    flex-direction: column;
  }
  .container {
    flex: 1;
  }
  .board-title {
    text-align: center;
    font-weight: bold;
    font-size: 2rem;
    margin-bottom: 30px;
    color: #2e7d32;
    padding-top: 30px;
    padding-bottom: 20px;
  }
  footer {
    margin-top: auto;
  }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container mt-4" style="max-width: 1000px;">
  <h2 class="board-title mb-4">자유게시판</h2>
  <form method="get" action="${ctp}/board/list" class="d-flex justify-content-end mb-3" role="search">
    <select name="searchType" class="form-select me-2" style="width: 120px;">
	  <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
	  <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
	  <option value="writer" ${searchType == 'writer' ? 'selected' : ''}>작성자</option>
	  <option value="tc" ${searchType == 'tc' ? 'selected' : ''}>제목+내용</option>
	</select>
    <input type="text" name="search" value="${search}" class="form-control me-2" placeholder="검색어 입력" style="width: 200px;">
    <input type="hidden" name="pageSize" value="${pageSize}"/>
    <button type="submit" class="btn btn-outline-success">검색</button>
  </form>

  <table class="table table-hover text-center align-middle">
    <thead class="table-success">
      <tr>
        <th style="width: 8%;">번호</th>
        <th style="width: 40%;">제목</th>
        <th style="width: 15%;">작성자</th>
        <th style="width: 10%;">조회수</th>
        <th style="width: 20%;">작성일</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="vo" items="${vos}">
        <tr>
          <td>${vo.idx}</td>
          <td class="text-start">
			<a href="${ctp}/board/content?idx=${vo.idx}" class="text-decoration-none text-dark">
			  ${vo.title}
			  <c:if test="${replyCountMap[vo.idx] > 0}">
			    <span class="badge bg-secondary ms-1">${replyCountMap[vo.idx]}</span>
			  </c:if>
		    </a>
		   </td>
          <td>${vo.nickName}</td>
          <td>${vo.readCount}</td>
          <td>${vo.createdAt}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  <div class="d-flex justify-content-center mt-5 mb-2">
	  <ul class="pagination" style="margin: 0;">
	    <c:forEach var="i" begin="1" end="${totPage}">
	      <li class="page-item ${i == pag ? 'active' : ''}">
	        <a class="page-link ${i == pag ? 'bg-success text-white border-success' : ''}" 
	           href="${ctp}/board/list?pag=${i}&pageSize=${pageSize}&search=${search}&searchType=${searchType}"
	           style="${i == pag ? 'border: 1px solid #28a745;' : ''}">
	          ${i}
	        </a>
	      </li>
	    </c:forEach>
	  </ul>
	</div>
  <div class="text-end mb-5">
    <a href="${pageContext.request.contextPath}/board/input" class="btn btn-primary">글쓰기</a>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
