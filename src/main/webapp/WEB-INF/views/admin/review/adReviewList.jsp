<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adReviewList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<%-- <jsp:include page="/WEB-INF/views/review/reviewModalForm.jsp" /> --%>
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
	<style>
		.pagination .page-link {
      color: #2e7d32;
      border-color: #2e7d32;
    }

    .pagination .active .page-link {
      background-color: #2e7d32;
      border-color: #2e7d32;
    }
    
		h6 {
		  position: fixed;
		  right: 1rem;
		  bottom: -50px;
		  transition: 0.7s ease;
		}
   	.on {
		  opacity: 0.8;
		  cursor: pointer;
		  bottom: 0;
		}
    .container table {
      width: 1000px;
      padding-right:30px;
    }
		.container-review {
			background-color: white;
		}
		.room-detail {
			display: flex;
			align-items: center;
		}
		.room-items2 {
			width: 500px;		
		}
		.room-items3 {
			width: 500px;
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
		$(window).scroll(function(){
	    	if($(this).scrollTop() > 100) {
	    		$("#topBtn").addClass("on");
	    	}
	    	else {
	    		$("#topBtn").removeClass("on");
	    	}
	    	
	    	$("#topBtn").click(function(){
	    		window.scrollTo({top:0, behavior: "smooth"});
	   	});
	  });
	</script>
	<script>
	  'use strict';
	  
	  function modalCheck(hotelIdx,roomIdx,roomName) {
		  $("#hotelIdx").val(hotelIdx);
		  $("#roomIdx").val(roomIdx);
		  $("#roomName").val(roomName);
	  }
	  
	  function reviewShowCheck(roomIdx) {
		  $("#reviewShowBtn"+roomIdx).hide();
		  $("#reviewHideBtn"+roomIdx).show();
		  $("#reviewDispaly"+roomIdx).show();
		  
		  $.ajax({
			  url  : "${ctp}/room/roomReviewList",
			  type : "post",
			  data : {roomIdx : roomIdx},
			  success:function(res) {
				  let str = '';
				  if(res != "") {
					  str += '<form name="reviewCheckForm">';
					  str += '<table class="table table-hover text-center">';
	          str += '<tr class="table-secondary">';
	          str += '<th><input type="button" value="x" onclick="reviewDelete()" class="btn btn-danger"/></th>';
	          str += '<th>글쓴이</th>';
	          str += '<th>목적</th>';
	          str += '<th>별점</th>';
	          str += '<th>작성날짜</th>';
	          str += '<th>접속IP</th>';
	          str += '<th class="text-start ps-5"> &nbsp;&nbsp;&nbsp;리뷰내용</th>';
	          str += '</tr>';
	          for(let i=0; i<res.length; i++) {
			        str += '<tr>';
			        str += '<td><input type="checkbox" name="reviewCheckBox" id="reviewCheckBox'+res[i].idx+'" value="'+res[i].idx+'" /></td>';
			        str += '<td>'+res[i].nickName+'</td>';
			        str += '<td>'+res[i].purpose+'</td>';
			        str += '<td>'+res[i].star+'</td>';
			        str += '<td>'+res[i].reviewDate+'</td>';
			        str += '<td>'+res[i].hostIp+'</td>';
			        str += '<td class="text-start">'+res[i].content.replaceAll('\n','<br/>')+'</td>';
			        str += '</tr>';
	          }
	          str += '</table>';
					  str += '</form>';
				  }
				  else {
					  str += '<hr class="border-secondary mt-1 p-0">댓글이 존재하지 않습니다.';
				  }
				  $("#reviewDispaly"+roomIdx).html(str);
			  }
		  });
	  }
	  
	  function reviewHideCheck(roomIdx) {
		  $("#reviewShowBtn"+roomIdx).show();
		  $("#reviewHideBtn"+roomIdx).hide();
		  $(".reviewClass").hide();
	  }
	  
	  function reviewDelete() {
		  let reviewStr = '';
		  for(let i=0; i<reviewCheckForm.reviewCheckBox.length; i++) {
			  if(reviewCheckForm.reviewCheckBox[i].checked) {
				  reviewStr += reviewCheckForm.reviewCheckBox[i].value + "/";
			  }
		  }
		  reviewStr = reviewStr.substring(0,reviewStr.length-1);
		  let ans = confirm("선택한 리뷰를 삭제하시겠습니까?");
		  if(!ans) return false;
		  
		  
		  $.ajax({
			  url : "${ctp}/admin/reviewDelete",
			  type : "post",
			  data : {reviewStr : reviewStr},
			  success:function(res) {
				  if(res != "0") {
					  alert( "해당 리뷰가 삭제되었습니다." );
					  location.reload();
				  }
				  else alert("작업 실패");
			  },
			  error:function() { alert("전송오류"); }
		  });
		  
	  }
	  
	</script>
</head>
<body>
<p><br/></p>
<div class="container container-review">
		<p><br></p>
  	<div class="input-group">
	    <select name="part" id="part" class="form-select bg-success-subtle">
	      <option value="mid">아이디</option>
	      <option value="name">성명</option>
	      <option value="address">주소</option>
	    </select>
	    <input type="text" name="content" id="content" placeholder="검색할 내용을 입력하세요" class="form-control"/>
	    <div class="input-group-append">
	      <input type="button" value="검색(완전일치)" onclick="formSearch()" class="btn btn-success ms-1 me-1"/>
	    </div>
	  </div>
	  <table class="table text-center">
	  	<tr>
        <th class="table-secondary">숙소 이용 내역</th>
      </tr>
      <c:forEach var="ReservationListVo" items="${rsVos}" varStatus="st">
	      <tr class="room-detail">
					<td class="room-items1 border border-0 ">
				    <img class="room-photo" src="${ctp}/roomThumbnail/${ReservationListVo.roomThumbnail}" alt="객실 사진" style="width:200px;max-height:180px;border:none;"/>
					</td>
			    <td class="room-items2 ms-4 border border-0">
				    <div class="room-info"><span class="room-label"><a href="${ctp}/hotel/hotelDetail?idx=${ReservationListVo.hotelIdx}"><b style="color: blue">호텔 이름:${ReservationListVo.hotelName}</b></a></span></div>
				    <div class="room-info"><span class="room-label">객실 명칭: ${ReservationListVo.roomName}</span></div>
				    <div class="room-info"><span class="room-label">객실 고유번호: ${ReservationListVo.roomIdx}</span></div>
				    <div class="room-info"><span class="room-label">가격: ${ReservationListVo.price}</span>₩</div>
				    <div class="room-info"><span class="room-label">최대숙박인원: ${ReservationListVo.maxPeople}</span></div>
				    <div class="room-info"><span class="room-label">반려견크기제한: ${ReservationListVo.petSizeLimit}</span></div>
				    <div class="room-info"><span class="room-label">최대마리수: ${ReservationListVo.petCountLimit}</span></div>
				    <div class="room-info"><span class="room-label">체크인 날짜: ${ReservationListVo.checkinDate}</span></div>
				    <div class="room-info"><span class="room-label">체크아웃 날짜: ${ReservationListVo.checkoutDate}</span></div>
				    <div class="room-info"><span class="room-label" style="color: red">총 숙박비용: ${ReservationListVo.totalPrice}</span></div>
			    </td>
			    <td class="room-items3 border border-0">
<%-- 			      <a href="javascript:reviewShowCheck(${st.index})" id="reviewShowBtn${st.index}" class="btn btn-success btn-sm">리뷰보기</a>
			    	<a href="javascript:reviewHideCheck(${st.index})" id="reviewHideBtn${st.index}" class="btn btn-warning btn-sm" style="display:none" >리뷰가리기</a> --%>
			    	<a href="javascript:reviewShowCheck(${ReservationListVo.roomIdx})" id="reviewShowBtn${ReservationListVo.roomIdx}" class="btn btn-success btn-sm">리뷰보기</a>
			    	<a href="javascript:reviewHideCheck(${ReservationListVo.roomIdx})" id="reviewHideBtn${ReservationListVo.roomIdx}" class="btn btn-warning btn-sm" style="display:none" >리뷰가리기</a>
			    </td>
			    <td class="room-items4 border border-0 ms-10">
			    	<a href="${ctp}/room/roomDetail?roomIdx=${ReservationListVo.roomIdx}&checkinDate=${ReservationListVo.checkinDate}&checkoutDate=${ReservationListVo.checkoutDate}&guestCount=${guestCount}&petCount=${petCount}" class="btn btn-danger btn-sm">상세보기</a>
			    </td>
	      </tr>
	      <tr>
	        <td colspan="4" class="text-center">
	          <div id="reviewDispaly${ReservationListVo.roomIdx}" class="reviewClass"></div>
	        </td>
	      </tr>
      </c:forEach>
	  </table>
	  
  <!-- 블록페이지 시작 -->
	<div class="text-center mt-4">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link" href="reviewList?part=${pageVo.part}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
	  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link" href="reviewList?part=${pageVo.part}&pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
	  	<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link" href="reviewList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link" href="reviewList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
	  	</c:forEach>
	  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link" href="reviewList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
	  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link" href="reviewList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
</div>
<p><br/></p>
</body>
</html>