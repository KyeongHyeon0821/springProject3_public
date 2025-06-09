<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
 	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	  document.addEventListener('DOMContentLoaded', function () {
	    'use strict';
	    let message = '${message}';
	    let msgType = '${msgType}';
	    let targetUrl = '${ctp}/${url}';
	
	    let finalMsgType = (msgType === '' || msgType === 'null' || msgType === 'undefined') ? 'info' : msgType;
	
	    if (message) {
	      Swal.fire({
	        icon: finalMsgType,
	        title: message,
	        confirmButtonText: '확인'
	      }).then(() => {
	        location.href = targetUrl;
	      });
	    }
	  });
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
  
</div>
</body>
</html>