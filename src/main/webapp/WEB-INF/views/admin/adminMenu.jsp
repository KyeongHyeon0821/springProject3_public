<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자메뉴</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
  <a href="${ctp}/admin/inquiry/adInquiryList">1:1문의 리스트 관리</a>
<p><br/></p>
</body>
</html>