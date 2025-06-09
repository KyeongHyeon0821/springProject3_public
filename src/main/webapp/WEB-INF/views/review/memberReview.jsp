<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberReviewInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<%-- <jsp:include page="/WEB-INF/views/review/reviewModalForm.jsp" /> --%>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
	<style>
		fieldset {
      direction: rtl;
    }
    #starForm input[type=radio] {
      display: none;
    }
    #starForm label {
      font-size: 1.6em;
      color: transparent;
      text-shadow: 0 0 0 #f0f0f0;
    }
    #starForm label:hover {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    #starForm label:hover ~ label {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    #starForm input[type=radio]:checked ~ label {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    
    a {text-decoration:none !important}
	</style>
	<script>
	  'use strict';
	  
	  	$(function () {
	  		$(".replyUpdateForm").hide();
	  	});
	  	
	  	
	  	function replyDeleteCheck(idx,reservationNo) {
	  		let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
	  		if(!ans) return false;
	  		
	  		$.ajax({
	  			url  : "${ctp}/review/reviewDelete",
	  			type : "post",
	  			data : {
	  				idx : idx,
	  				reservationNo : reservationNo,
	  			},
	  			success:function(res) {
	  				if(res != "0") {
	  					alert("댓글이 삭제되었습니다.");
	  					location.reload();
	  				}
	  				else alert("삭제 실패!");
	  			},
	  			error:function() { alert("전송오류!"); }
	  		});
	  	}
	  	// 댓글 수정창 보여주기
	  	function replyUpdateCheck(idx) {
	  		$(".replyUpdateForm").hide();
	  		$("#replyUpdateForm"+idx).show();
	  	}
	  	
	  	// 댓글 수정창 닫기
	  	function replyUpdateViewClose(idx) {
	  		$("#replyUpdateForm"+idx).hide();
	  	}
	  	
	  	// 댓글 수정하기
	  	function replyUpdateCheckOk(idx) {
	  		let content = $("#content"+idx).val();
	  		if(content.trim() == "") {
	  			alert("수정할 댓글을 입력하세요.");
	  			return false;
	  		}
	  		let query = {
	  				idx: idx,
	  				content : content
	  		}
	  		
	  		$.ajax({
	  			url : "${ctp}/review/reviewUpdateCheckOk",
	  			type : "post",
	  			data : query,
	  			success:function(res) {
	  				if(res != "0") {
	  					alert("댓글이 수정 되었습니다.");
	  					location.reload();
	  				}
	  				else alert("수정 실패!");
	  			},
	  			error : function() { alert("전송오류!"); }
	  		});
	  	}
	  	
	</script>
 	<style>
    body {
      background-color: #f9fefb;
    }
    .review-complete-container {
		  max-width: 900px;
		  margin: 40px auto;
		  padding: 30px;
		  background: #fff;
		  border-radius: 16px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		  font-family: 'Pretendard', sans-serif;
		}

  </style>
</head>
<body>
<p><br/></p>
<div class="review-complete-container">
	<table class="table table-hover text-center table-borderless">
			<tr class="table-success">
				<th>예약번호</th>
				<th>글쓴이</th>
				<th>숙박이유</th>
				<th>별점</th>
				<th>작성날짜</th>
				<th>리뷰내용</th>
			</tr>
			<c:forEach var="vo" items="${rVos}" varStatus="st">
				<tr class="">
					<td>${vo.reservationNo}</td>
					<td>${vo.mid}
						<c:if test="${sMid == vo.mid || sLevel == 0}">
		  				 	<a href="javascript:replyDeleteCheck('${vo.idx}','${vo.reservationNo}')" style="color: white" class="btn btn-sm btn-danger" title="리뷰삭제">삭제</a>
		  				 <c:if test="${sMid == vo.mid}">
		  				 	<a href="javascript:replyUpdateCheck(${vo.idx})" style="color: white" class="btn btn-sm btn-primary" title="리뷰수정">수정</a>
		  				 </c:if>
	  				</c:if>
					</td>
					<td>${vo.purpose}</td>
					<td>${vo.star}</td>
					<td>${fn:substring(vo.reviewDate,0,10)}</td>
					<td class="text-start">${fn:replace(vo.content,newLine,"<br/>")}</td>
				</tr>
				<!-- 아래로 댓글 수정 폼 보기 -->
				<tr>
	  			<td colspan="4">
	  				<div id="replyUpdateForm${vo.idx}" class="replyUpdateForm">
						  <form name="replyUpdateForm">
						  	<table class="table text-center table-borderless">
						  		<tr>
						  			<td class="text-start" style="width:85%">
						  				글내용 : 
						  				<textarea rows="4" name="content" id="content${vo.idx}" class="form-control">${vo.content}</textarea>
						  			</td>
						  			<td style="width:15%"><br/>
						  				<p>작성자 : ${sNickName}</p>
						  				<p>
						  					<a href="javascript:replyUpdateCheckOk(${vo.idx})" class="badge bg-primary">리뷰수정</a>
						  					<a href="javascript:replyUpdateViewClose(${vo.idx})" class="badge bg-warning ">창닫기</a>
						  				</p>
						  			</td>
						  		</tr>
						  	</table>
						  </form>
						</div>
	  			</td>
	  		</tr>
			</c:forEach>
	</table>
	<span class="border-top"></span>	
</div>
<p><br/></p>


<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>