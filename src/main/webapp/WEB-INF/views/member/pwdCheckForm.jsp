<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pwdCheckForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  
  <script>
    function checkDeleteForm() {
      const pwd = document.getElementById('pwd').value;
      if (!pwd) {
        alert('비밀번호를 입력하세요.');
        return false;
      }

      const pwdFlag = '${pwdFlag}';
      if (pwdFlag === 'd') {
        return confirm('정말 탈퇴하시겠습니까?\n※ 탈퇴 시 동일 아이디로는 재가입이 불가능합니다.');
      }
      
      return true;
    }
  </script>
</head>
<body style="min-height: 100vh; display: flex; flex-direction: column;">
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container flex-fill" style="max-width: 500px; margin-top: 80px; margin-bottom: 40px;">
  <div class="card shadow-sm p-4">
    <h3 class="text-center mb-3">비밀번호 확인</h3>
    <c:if test="${pwdFlag == 'p'}">
      <div class="text-center text-danger mb-3">(현재 비밀번호를 입력하세요)</div>
    </c:if>
    <form method="post" onsubmit="return checkDeleteForm();">
      <div class="mb-3">
        <label for="pwd" class="form-label fw-bold">비밀번호</label>
        <input type="password" name="pwd" id="pwd" class="form-control" placeholder="비밀번호를 입력하세요." required />
      </div>

      <div class="d-flex justify-content-center gap-2">
        <button type="submit" class="btn btn-success">비밀번호확인</button>
        <button type="button" onclick="location.href='${ctp}/member/memberMyPage'" class="btn px-4 py-2" style="background-color: #eeeeee; color: #333; border-radius: 8px; font-weight: 500;">돌아가기</button>
      </div>
    </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>