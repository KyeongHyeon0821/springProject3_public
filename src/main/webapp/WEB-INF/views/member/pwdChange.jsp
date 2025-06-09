<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pwdChange.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script>
    'use strict';
    
    function pwdCheck() {
    	let pwd = document.getElementById("pwd").value;
    	let rePwd = document.getElementById("rePwd").value;
    	
    	if(pwd != rePwd) {
    		alert("비밀번호가 일치하지 않습니다. 확인후 다시 입력하세요.");
    		document.getElementById("pwd").focus();
    	}
    	else myform.submit();
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container flex-fill" style="max-width: 500px; margin-top: 70px; margin-bottom: 40px;">
  <div class="card shadow-sm p-4">
    <h3 class="text-center mb-4">비밀번호 변경</h3>

    <form name="myform" method="post" action="${ctp}/member/pwdChange">
      <div class="mb-3">
        <label for="pwd" class="form-label fw-bold">새로운 비밀번호</label>
        <input type="password" name="pwd" id="pwd" placeholder="새로운 비밀번호를 입력하세요." required class="form-control" />
      </div>

      <div class="mb-4">
        <label for="rePwd" class="form-label fw-bold">비밀번호 확인</label>
        <input type="password" name="rePwd" id="rePwd" placeholder="비밀번호를 한 번 더 입력해 주세요." required class="form-control" />
      </div>

      <div class="d-flex justify-content-center gap-2">
        <button type="button" onclick="pwdCheck()" class="btn btn-success">비밀번호변경</button>
        <button type="button" onclick="location.href='${ctp}/member/memberMyPage'" class="btn px-4 py-2" style="background-color: #eeeeee; color: #333; border-radius: 8px; font-weight: 500;">돌아가기</button>
      </div>
    </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>