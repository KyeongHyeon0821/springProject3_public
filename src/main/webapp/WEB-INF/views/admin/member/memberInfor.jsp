<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberInfor.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <style>
  
  	body {
  		text-align: center;
  		background-color: #F6F5F2;
  	}
  	.container {
  		width: 500px;
  		padding-top: 15px;
  		padding-bottom : 25px;
			margin: 100px auto;
			border: solid 1px rgba(0,0,0,0.2);
			border-radius: 14px;
			box-shadow: 10px 10px 5px rgba(0,0,0,0.1);
			background-color: white;
  	}
  	.container-head {
  		color: green;
  	}
  	.container div {
  		font-size: 16px;
  	}
  </style>
</head>
<body>
<div class="container">
  <h2 class="container-head">고객 개인정보 상세보기</h2>
  <div>고유번호 : ${vo.idx}</div>
  <div>아이디 : ${vo.mid}</div>
  <div>닉네임 : ${vo.nickName}</div>
  <div>성명 : ${vo.name}</div>
  <div>성별 : ${vo.gender}</div>
  <div>생일 : ${vo.birthday}</div>
  <div>전화번호 : ${vo.tel}</div>
  <div>주소 : ${vo.address}</div>
  <div>이메일 : ${vo.email}</div>
  <div>정보공개유무 : ${vo.userInfor}</div>
  <div>활동상태 : ${vo.userDel}</div>
  <div>회원등급 : ${vo.level}</div>
  <div>총 방문횟수 : ${vo.visitCnt}</div>
  <div>오늘 방문횟수 : ${vo.todayCnt}</div>
  <div>최초 가입일자 : ${vo.startDate}</div>
  <div>최근 방문일자 : ${vo.lastDate}</div>
  <div>넘어온 섹션값 : ${section}</div>
  <hr/>
  <div><input type="button" value="돌아가기" onclick="history.back()" class="btn btn-success"/></div>
</div>
<p><br/></p>
</body>
</html>