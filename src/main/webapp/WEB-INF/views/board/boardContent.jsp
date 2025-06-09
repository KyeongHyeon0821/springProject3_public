<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardContent.jsp</title>
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
    footer {
      margin-top: auto;
    }
    th {
      background-color: #f2f2f2;
      width: 120px;
      text-align: center;
      vertical-align: middle !important;
    }
    td {
      background-color: #fff;
    }
    .content-box {
      padding: 15px;
      background-color: #f9f9f9;
      border: 1px solid #dee2e6;
      border-radius: 5px;
      min-height: 200px;
      white-space: pre-wrap;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container mt-5 mb-5" style="max-width: 900px;">
  <!-- 게시글 제목 -->
  <h2 class="fw-bold text-center mb-4 border-bottom pb-3">${vo.title}</h2>

  <!-- 게시글 정보 -->
  <div class="p-4 bg-white rounded shadow-sm mb-4">
    <table class="table mb-0">
      <tbody>
        <tr>
          <th class="bg-light text-center">작성자</th>
          <td>${vo.nickName} (${vo.mid})</td>
          <th class="bg-light text-center">조회수</th>
          <td>${vo.readCount}</td>
        </tr>
        <tr>
          <th class="bg-light text-center">작성일</th>
          <td colspan="3">${vo.createdAt}</td>
        </tr>
        <tr>
          <th class="bg-light text-center">내용</th>
          <td colspan="3">
            <div class="p-3 bg-light border rounded" style="min-height: 200px; white-space: pre-wrap; padding: 20px;">${vo.content}</div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- 댓글 영역 -->
  <h5 class="fw-bold mt-5 mb-3 border-bottom pb-2">
    <i class="bi bi-chat-dots me-1"></i> 댓글
  </h5>

  <c:if test="${not empty sMid}">
    <form method="post" action="${ctp}/reply/insert" class="mb-4">
	  <input type="hidden" name="boardIdx" value="${vo.idx}" />
	  <div class="border rounded px-3 py-3 bg-white" style="position: relative;">
	    <div class="fw-semibold text-dark mb-2 ps-1">${sessionScope.sNickName}</div>
	    <textarea name="content" class="form-control border-0 px-1" rows="2"
	              style="resize: none;" placeholder="댓글을 남겨보세요" required></textarea>
	    <div class="d-flex justify-content-end align-items-center mt-2">
	      <button type="submit" class="btn btn-link text-success fw-semibold px-2">등록</button>
	    </div>
	  </div>
	</form>
  </c:if>
  <c:if test="${empty sMid}">
    <p class="text-muted">댓글을 작성하려면 <a href="${ctp}/member/memberLogin">로그인</a>이 필요합니다.</p>
  </c:if>

  <!-- 댓글 목록 -->
  <c:forEach var="rvo" items="${replyList}">
    <div class="border rounded p-3 mb-3 bg-white">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <div>
          <strong>${rvo.nickName}</strong>
          <span class="text-muted small">(${rvo.createdAt})</span>
        </div>
        <div class="reply-actions">
          <c:if test="${sMid eq rvo.mid}">
            <a href="javascript:void(0);" class="text-primary small me-2" onclick="openEditModal(${rvo.idx}, '${rvo.content}')">수정</a>
          </c:if>
          <c:if test="${sMid eq rvo.mid or sLevel == 0}">
            <a href="${ctp}/reply/delete?idx=${rvo.idx}&boardIdx=${vo.idx}" class="text-danger small">삭제</a>
          </c:if>
        </div>
      </div>
      <div style="white-space: pre-wrap;">${rvo.content}</div>
    </div>
  </c:forEach>

  <!-- 하단 버튼 -->
  <div class="d-flex justify-content-between mt-4">
	<div>
	  <c:if test="${sMid eq vo.mid}">
	    <a href="${ctp}/board/update?idx=${vo.idx}" class="btn btn-outline-success me-2">수정</a>
	    <a href="${ctp}/board/delete?idx=${vo.idx}" class="btn btn-outline-danger">삭제</a>
	  </c:if>
	  <c:if test="${sMid ne vo.mid and sLevel == 0}">
	    <a href="${ctp}/board/delete?idx=${vo.idx}" class="btn btn-outline-danger">관리자 삭제</a>
	  </c:if>
	</div>
	<div>
	  <a href="${ctp}/board/list" class="btn btn-outline-secondary">목록</a>
	</div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<!-- 댓글 수정 모달 -->
<div class="modal fade" id="editReplyModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <form id="editReplyForm" method="post" action="${ctp}/reply/update">
      <input type="hidden" name="idx" id="editReplyIdx">
      <input type="hidden" name="boardIdx" value="${vo.idx}">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">댓글 수정</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
        </div>
        <div class="modal-body">
          <textarea class="form-control" name="content" id="editReplyContent" rows="4" required></textarea>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">수정</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        </div>
      </div>
    </form>
  </div>
</div>
<script>
  function openEditModal(idx, content) {
    document.getElementById('editReplyIdx').value = idx;
    document.getElementById('editReplyContent').value = content;
    new bootstrap.Modal(document.getElementById('editReplyModal')).show();
  }
</script>
</body>
</html>
