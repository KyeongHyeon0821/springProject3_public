<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberFindPwd.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
<style>
  html, body {
    height: 100%;
    margin: 0;
    padding: 0;
  }
  body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
  }
  main {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 60px 0;
  }
  .form-box {
    width: 100%;
    max-width: 400px;
    padding: 30px;
    background: #fff;
    border: 1px solid #eee;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    margin: 0 auto;
  }
  footer {
    width: 100%;
  }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<main>
<div class="form-box">
  <h3 class="text-center mb-4">
	<img src="${ctp}/images/logo.png" width="150px"/><br/>
  	<span style="color: #2e7d32; font-weight: bold;">비밀번호찾기</span>
  </h3>

  <form method="post" action="${ctp}/member/memberFindPwd" onsubmit="return validateForm()">
    <div class="mb-3">
      <label for="name" class="form-label">이름</label>
      <input type="text" name="name" id="name" class="form-control">
    </div>

    <div class="mb-3">
      <label for="mid" class="form-label">아이디</label>
      <input type="text" name="mid" id="mid" class="form-control">
    </div>

    <div class="mb-3">
      <label for="email1" class="form-label">이메일</label>
      <div class="input-group">
        <input type="text" name="email1" id="email1" class="form-control" placeholder="이메일 아이디">
        <span class="input-group-text">@</span>
        <select name="email2" id="email2" class="form-select">
          <option value="naver.com">naver.com</option>
          <option value="hanmail.net">hanmail.net</option>
          <option value="gmail.com">gmail.com</option>
          <option value="daum.net">daum.net</option>
          <option value="yahoo.com">yahoo.com</option>
          <option value="hotmail.com">hotmail.com</option>
          <option value="nate.com">nate.com</option>
        </select>
      </div>
    </div>

    <button type="submit" class="btn btn-success w-100 mt-4">비밀번호 찾기</button>
  </form>
</div>
</main>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
  function validateForm() {
    const name = document.getElementById("name").value.trim();
    const mid = document.getElementById("mid").value.trim();
    const email1 = document.getElementById("email1").value.trim();
    const email2 = document.getElementById("email2").value;
    const email = email1 + "@" + email2;

    const namePattern = /^[가-힣a-zA-Z]+$/;
    const midPattern = /^[a-zA-Z0-9_-]{4,20}$/;
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!name) {
      alert("이름을 입력해주세요.");
      document.getElementById("name").focus();
      return false;
    }
    if (!namePattern.test(name)) {
      alert("이름은 한글 또는 영문만 입력 가능합니다.");
      document.getElementById("name").focus();
      return false;
    }
    if (!mid) {
      alert("아이디를 입력해주세요.");
      document.getElementById("mid").focus();
      return false;
    }
    if (!midPattern.test(mid)) {
		alert("아이디는 4~20자의 영문, 숫자, 특수문자(_,-)만 입력 가능합니다.");
		document.getElementById("mid").focus();
		return false;
	}
    if (!email1) {
      alert("이메일을 입력해주세요.");
      document.getElementById("email1").focus();
      return false;
    }

    if (!emailPattern.test(email)) {
      alert("이메일 형식이 올바르지 않습니다.");
      document.getElementById("email1").focus();
      return false;
    }
    return true;
  }
</script>
</body>
</html>
