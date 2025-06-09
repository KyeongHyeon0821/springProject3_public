<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page errorPage="/WEB-INF/views/errorPage/errorMessage1.jsp" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>위드펫 - 에러</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
</head>
<body>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<div class="container text-center mt-5 mb-5">
	<h2>현재 시스템 점검중입니다.</h2>

  <div>사용에 불편을 드려서 죄송합니다.</div>
  <div>빠른 시일내에 복구하도록 하겠습니다.</div>
  <hr class="border-secondary" />
  <div><img src="${ctp}/images/logo.png" width="400px"/></div><br>
  <div>
  	<a href="${ctp}/" class="btn btn-success">돌아가기</a>
  </div>
</div>

</body>
</html>