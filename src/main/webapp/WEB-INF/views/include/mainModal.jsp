<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mainModal.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script>
		'use strict';
		$()
		
		function myInputReset() {
			$("#myInput").val("");
			$("#myInput").focus();
		}
		
		
	</script>
	<style>
		li a {
			text-decoration: none;
			list-style: none;
		}
		.modal-backdrop {
			background-color: transparent;
			opacity: 0;
		}
		.custom-modal-position1{
			position: absolute;
			top: var(--modal-top, 20%);
			left: var(--modal-left, 20%);
			margin: 0 auto;
			transform: none;
		}
		.custom-modal-position2{
			
			text-align: center;
			position: absolute;
			top: var(--modal-top, 100);
			left: var(--modal-left, 50%);
			margin: 0;
			transform: none;
		}
 		.custom-modal-position3{
			
			text-align: center;
			position: absolute;
			top: var(--modal-top, 100);
			left: var(--modal-left, 60%);
			margin: 0;
			transform: none;
		}
	
 
				/* 모달2 내용 전체 중앙 정렬 */
		.custom-modal-position2 .modal-content {
		  text-align: center;
		}
		
		/* 리스트 아이템 스타일링 */
		.custom-modal-position2 .modal-body ul {
		  padding-left: 0;
		  list-style: none;
		  display: inline-block; /* 가로 중앙 정렬 */
		  margin: 0 auto;
		}
		
		/* 링크 스타일 추가 */
		.custom-modal-position2 .modal-body a {
		  display: block;
		  padding: 8px 16px;
		  text-decoration: none;
		  color: #333;
		}
		
		
		
				/* 모달3 내용 전체 중앙 정렬 */
		.custom-modal-position3 .modal-content {
		  text-align: center;
		}
		
		/* 리스트 아이템 스타일링 */
		.custom-modal-position3 .modal-body ul {
		  padding-left: 0;
		  list-style: none;
		  display: inline-block; /* 가로 중앙 정렬 */
		  margin: 0 auto;
		}
		
		/* 링크 스타일 추가 */
		.custom-modal-position3 .modal-body a {
		  display: block;
		  padding: 8px 16px;
		  text-decoration: none;
		  color: #333;
		}

		
	</style>
</head>
<body>
<!-- modal1 -->
<div class="modal" id="myModal1">
	<div class="modal-dialog modal-dialog-scrollable custom-modal-position1">
		<div class="modal-content">
			
			<!-- modal header -->
			<!-- modal body -->
			<div class="modal-body">
				<input type="text" id="myInput" class="input-group" placeholder="어디로 가세요?">
				<button type="button" id="myBtn" class="btn" onclick="myInputReset()">X</button>
			</div>			
			<!-- modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">close</button>
			</div>	
		</div>
	</div>
</div>


<!-- modal2 -->
<div class="modal" id="myModal2">
	<div class="modal-dialog custom-modal-position2">
		<div class="modal-content">
			
			<!-- modal header -->
			<!-- modal body -->
			<div class="modal-body text-center">
        <ul class="list-unstyled">
        	<li><a href="#">마이페이지</a></li>
        	<li><a href="#">더보기</a></li>
        	<li><a href="#">더보기</a></li>
        </ul>
			<!-- modal footer -->
		</div>
	</div>
</div>
</div>



<!-- modal3 -->
<div class="modal" id="myModal3">
	<div class="modal-dialog custom-modal-position3" tabindex="-1">
		<div class="modal-content">
			<!-- modal header -->
			<!-- modal body -->
			<div class="modal-body text-center">
        <ul class="list-unstyled">
        	<li><a href="#">1:1문의</a></li>
        	<li><a href="#">FQA</a></li>
        	<li><a href="#">Q&A</a></li>
        </ul>
				<!-- modal footer -->
			</div>
		</div>
	</div>
</div>

</body>
</html>