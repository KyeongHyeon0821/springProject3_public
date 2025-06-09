<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberLogin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script>
    'use strict';
    window.Kakao.init("158c673636c9a17a27b67c95f2c6be5c");
    function kakaoLogin() {
      window.Kakao.Auth.login({
        scope: 'profile_nickname, account_email',
        success:function(autoObj) {
          window.Kakao.API.request({
            url : '/v2/user/me',
            success:function(res) {
              const kakao_account = res.kakao_account;
              location.href = "${ctp}/member/kakaoLogin?nickName=" + kakao_account.profile.nickname + "&email=" + kakao_account.email + "&accessToken=" + Kakao.Auth.getAccessToken();
            }
          });
        }
      });
    }
    
    function loginCheck() {
    	const mid = document.getElementById("mid").value.trim();
    	const pwd = document.getElementById("pwd").value.trim();

    	if (mid === "") {
    	  alert("아이디를 입력하세요.");
    	  document.getElementById("mid").focus();
    	  return false;
    	}

    	if (pwd === "") {
    	  alert("비밀번호를 입력하세요.");
    	  document.getElementById("pwd").focus();
    	  return false;
    	}

    	return true;
    }
    
    function togglePwdVisibility() {
    	const pwdInput = document.getElementById("pwd");
    	pwdInput.type = pwdInput.type === "password" ? "text" : "password";
    }

  </script>
<style>
    .login-box {
      max-width: 400px;
      margin: 50px auto;
      padding: 30px;
      border: 1px solid #eee;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
      background-color: #fff;
    }
    .form-control {
      height: 50px;
      font-size: 1rem;
    }
    .btn-success {
      background-color: #2e7d32;
      border: none;
    }
    .btn-success:hover {
      background-color: #27692b;
    }
    .kakao-btn img {
      width: 100%;
    }
    .login-links {
      text-align: center;
      margin-top: 10px;
    }
    .login-links a {
      text-decoration: none;
      color: #555;
      margin: 0 5px;
    }
    .login-links a:hover {
      text-decoration: underline;
    }
</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="login-box text-center">
  <form name="myform" method="post" onsubmit="return loginCheck()">
    <img src="${ctp}/images/logo.png" width="150px" class="mb-3" />
    <div class="mb-3">
      <input type="text" name="mid" id="mid" value="${mid}" class="form-control" placeholder="아이디를 입력해주세요" autofocus />
    </div>
    <div class="mb-3">
      <input type="password" name="pwd" id="pwd" class="form-control" placeholder="비밀번호를 입력해주세요" />
    </div>

    <div class="form-check mb-3 text-start">
      <input type="checkbox" class="form-check-input" id="idSave" name="idSave" checked />
      <label class="form-check-label" for="idSave">아이디 저장</label>
    </div>

    <div class="d-grid gap-2 mb-2">
      <button type="submit" class="btn btn-success">로그인</button>
    </div>

    <div class="mb-3 d-grid">
	  <button type="button" onclick="kakaoLogin()" class="btn btn-warning w-100" style="background-color: #FEE500; color: #3c1e1e; font-weight: bold; border: none;">
  		<i class="bi bi-chat-fill" style="margin-right: 5px;"></i> 카카오 로그인
	  </button>
	</div>

    <div class="login-links">
      <a href="${ctp}/member/memberFindId">아이디 찾기</a> |
      <a href="${ctp}/member/memberFindPwd">비밀번호 찾기</a> |
      <a href="${ctp}/member/memberJoin">회원가입</a>
    </div>
  </form>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>