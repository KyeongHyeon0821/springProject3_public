<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>dashBoard.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<style>
	
		body {
			background-color: #F6F5F2;
		}
		.grid-container {
		  display: grid;
		  grid-template-columns: auto auto;
		  gap: 20px;
		  background-color:#F6F5F2;
		  padding: 130px 30px 30px 30px;
		}
		
		.grid-container > div {
		  background-color: white;
		  text-align: center;
		  padding: 15px;
		  font-size: 30px;
		  border-radius: 20px;
		  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
		}
		
		.grid-container > div:hover {
		  transform: translateY(-3px);
		  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
		}

	</style>
</head>
<body>
<p><br/></p>
<div class="grid-container">
  <div class="item1">고객</div>
  <div class="item2">사업자</div>
  <div class="item3">호텔게시물</div>  
  <div class="item4">리뷰</div>
  <div class="item5">호텔게시물 승인</div>
  <div class="item6">신고리뷰</div>
  <div class="item7">호텔등록 대기</div>
  <div class="item8">예약</div>  
</div>
  

<p><br/></p>
</body>
</html>