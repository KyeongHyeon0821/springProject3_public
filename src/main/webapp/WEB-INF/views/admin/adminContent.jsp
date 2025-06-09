<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <jsp:include page="/WEB-INF/views/admin/dashBoard/dashBoard.jsp" />
</head>
<body>
<p><br/></p>
<!-- Main Content -->
<main class="col px-4 py-4" id="main-content">
</main>

<p><br/></p>
</body>
</html>