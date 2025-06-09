<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardInput.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <style>
    html, body {
      height: 100%;
    }
    body {
      display: flex;
      flex-direction: column;
      background-color: #f9f9f9;
    }
    .container {
      flex: 1;
    }
    .extra-top-margin {
      margin-top: 60px;
    }
    footer {
      margin-top: auto;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<h2 class="fw-bold text-success text-center extra-top-margin">게시글 작성</h2>
<div class="container mt-5 mb-5 p-4 shadow-sm bg-white rounded" style="max-width: 800px;">
  <form action="${ctp}/board/input" method="post">
  
    <div class="mb-4">
      <label for="title" class="form-label fw-semibold">제목</label>
      <input type="text" class="form-control border-success" id="title" name="title" required placeholder="제목을 입력하세요">
    </div>

    <div class="mb-4">
      <label for="content" class="form-label fw-semibold">내용</label>
      <textarea class="form-control border-success" id="content" name="content" rows="10" required placeholder="내용을 입력하세요" style="word-break: keep-all;"></textarea>
    </div>

    <div class="text-end">
      <button type="submit" class="btn btn-success px-4 me-2">작성</button>
      <a href="${ctp}/board/list" class="btn btn-outline-secondary px-4">목록</a>
    </div>
  </form>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
