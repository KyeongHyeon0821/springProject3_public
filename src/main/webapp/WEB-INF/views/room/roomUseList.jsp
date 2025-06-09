<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>roomUseList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
	<style>
		.container-review {
			max-width: 900px;
		  margin: 40px auto;
		  padding: 30px;
		  background: #fff;
		  border-radius: 16px;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
		  font-family: 'Pretendard', sans-serif;
		  font-size: 1em;
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
		.modal-content {
			box-sizing: border-box;
		} 
		.modal-content textarea {
			width: 100%;
			height: 100%;
			box-sizing: border-box;
			border-color: #eee;
			resize: none;
			
		}
		
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
	  
	  function reviewUploadCheck() {
		  let star = reviewForm.star.value;
		  let purpose = reviewForm.purpose.value;
		  let content = reviewForm.content.value;
		  
		  if(star == "") {
			  alert("별점을 입력하세요.");
		  }
		  else if(purpose == "" ) { alert("목적을 입력하세요."); 
		  }
		  else if(content == "") { alert("내용을 입력하세요."); 
		  } 
		  else reviewForm.submit();
	  }
	  

	  
	  function modalCheck(hotelIdx,roomIdx,roomName,reservationIdx,reservationNo) {
		  $("#hotelIdx").val(hotelIdx);
		  $("#roomIdx").val(roomIdx);
		  $("#roomName").val(roomName);
		  $("#reservationIdx").val(reservationIdx);
		  $("#reservationNo").val(reservationNo);

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
					  str += '<table class="table table-hover text-center">';
	          str += '<tr class="table-secondary">';
	          str += '<th>글쓴이</th>';
	          str += '<th>목적</th>';
	          str += '<th>별점</th>';
	          str += '<th>작성날짜</th>';
	          str += '<th>접속IP</th>';
	          str += '<th class="text-start ps-5"> &nbsp;&nbsp;&nbsp;리뷰내용</th>';
	          str += '</tr>';
	          for(let i=0; i<res.length; i++) {
			        str += '<tr>';
			        str += '<td>'+res[i].nickName+'</td>';
			        str += '<td>'+res[i].purpose+'</td>';
			        str += '<td>'+res[i].star+'</td>';
			        str += '<td>'+res[i].reviewDate+'</td>';
			        str += '<td>'+res[i].hostIp+'</td>';
			        str += '<td class="text-start">'+res[i].content.replaceAll('\n','<br/>')+'</td>';
			        str += '</tr>';
	          }
	          str += '</table>';
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
	  
/* 	  function reviewCheck(hotelIdx,roomIdx,roomName,reservationIdx,reservationNo) {
		  alert("reservationNo : " + reservationNo);
		  $.ajax({
			  url  : "${ctp}/room/reviewSaveCheck",
			  type : "get",
			  data : {reservationNo : reservationNo},
			  success:function(res) {
				  if(res != "0") alert("이미 리뷰를 등록하셨습니다.");
				  else {
		        let str = 
             `<form id="reviewForm">
                <input type="hidden" id="hotelIdx" name="hotelIdx" value="${hotelIdx}">
                <input type="hidden" id="roomIdx" name="roomIdx" value="${roomIdx}">
                <input type="hidden" id="roomName" name="roomName" value="${roomName}">
                <input type="hidden" id="reservationIdx" name="reservationIdx" value="${reservationIdx}">
                <input type="hidden" id="reservationNo" name="reservationNo" value="${reservationNo}">
                <textarea name="reviewContent" placeholder="리뷰 내용"></textarea>
            	</form>`;

					  $('#modalContent').html(str);  // 모달 내용 주입
			      $('#myModal').modal('show');    // 모달 표시
				  }
			  }
			  
		  }); 
	  }*/
	</script>
</head>
<body>
<p><br/></p>
<div class="container container-review">
		<p><br></p>
	  <table class="table text-center">
	  	<tr>
        <th class="table-success">숙소 이용 내역</th>
      </tr>
      <tr>
      	<td>
      	</td>
      </tr>
      <c:forEach var="ReservationListVo" items="${rsVos}" varStatus="st">
	      <tr class="room-detail">
					<td class="room-items1 border border-0 ">
				    <img class="room-photo" src="${ctp}/roomThumbnail/${ReservationListVo.roomThumbnail}" alt="객실 사진" style="width:200px;max-height:180px;border:none;"/>
					</td>
			    <td class="room-items2 ms-4 border border-0">
				    <div class="room-info"><span class="room-label"><a href="${ctp}/hotel/hotelDetail?idx=${ReservationListVo.hotelIdx}"><b style="color: green">호텔 이름:${ReservationListVo.hotelName}</b></a></span></div>
				    <div class="room-info"><span class="room-label">객실 명칭: ${ReservationListVo.roomName}</span></div>
				    <div class="room-info"><span class="room-label">가격: ${ReservationListVo.price}</span>₩</div>
				    <div class="room-info"><span class="room-label">최대숙박인원: ${ReservationListVo.maxPeople}</span></div>
				    <div class="room-info"><span class="room-label">반려견크기제한: ${ReservationListVo.petSizeLimit}</span></div>
				    <div class="room-info"><span class="room-label">최대마리수: ${ReservationListVo.petCountLimit}</span></div>
				    <div class="room-info"><span class="room-label">체크인 날짜: ${ReservationListVo.checkinDate}</span></div>
				    <div class="room-info"><span class="room-label">체크아웃 날짜: ${ReservationListVo.checkoutDate}</span></div>
				    <div class="room-info"><span class="room-label" style="color: red">총 숙박비용: ${ReservationListVo.totalPrice}</span></div>
				    <c:if test="${sMid == 'admin'}">
				    	<div class="room-info"><span class="room-label" style="color: red">예약idx: ${ReservationListVo.reservationIdx}</span></div>
				    </c:if>
			    </td>
			    <td class="room-items3 border border-0">
 		    		<a href="#" onclick="modalCheck('${ReservationListVo.hotelIdx}','${ReservationListVo.roomIdx}','${ReservationListVo.roomName}'
 		    		,'${ReservationListVo.reservationIdx}','${ReservationListVo.reservationNo}')" class="btn btn-success btn-sm ms-3 text-end" data-bs-toggle="modal" 
 		    		data-bs-target="#myModal">리뷰작성</a>
 		    		<%-- <input type="button" value="리뷰작성" onclick="reviewCheck('${ReservationListVo.reservationNo}')" class="btn btn-success btn-sm"/> --%>
			    </td>
			    <td class="room-items4 border border-0 ms-10">
			    	<a href="${ctp}/room/roomDetail?roomIdx=${ReservationListVo.roomIdx}&checkinDate=${ReservationListVo.checkinDate}&checkoutDate=${ReservationListVo.checkoutDate}&guestCount=${guestCount}&petCount=${petCount}" class="btn btn-danger btn-sm">상세보기</a>
			    </td>
	      </tr>
	      <tr>
	        <td colspan="4" class="text-center">
	          <div id="reviewDispaly${st.index}" class="reviewClass"></div>
	        </td>
	      </tr>
      </c:forEach>
	  </table>
</div>
<p><br/></p>

<!-- 모달로 리뷰작성창 띄우기 -->

	<div class="modal modal-lg" id="myModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	    	<div class="modal-header">
	      	<h4>리뷰달기 </h4><span class="btn btn-success ms-3">${sNickName} 님</span>
	    	</div>
				<form name="reviewForm" id="reviewForm" action="${ctp}/review/reviewInput" method="post">
		      <div class="modal-body text-end">
			      <fieldset style="border:0px;" class="starForm" id="starForm" name="starForm">
			        <div class="text-left viewPoint m-0 b-0" >
			          <input type="radio" name="star" value="5" id="star1"><label for="star1">★</label>
			          <input type="radio" name="star" value="4" id="star2"><label for="star2">★</label>
			          <input type="radio" name="star" value="3" id="star3"><label for="star3">★</label>
			          <input type="radio" name="star" value="2" id="star4"><label for="star4">★</label>
			          <input type="radio" name="star" value="1" id="star5"><label for="star5">★</label>
			          : 별점을 선택해 주세요 ■
			        </div>
			      </fieldset>
			      
			      <div class="m-0 p-0">
			      	<div class="text-end" class="purposeForm" id="purposeForm" >
			      	  <select name="purpose" class="form-select">
								  <option id="purpose1" value="휴식이 필요해서">휴식이 필요했어요</option>
								  <option id="purpose2" value="반려견과 첫 여행">반려견과 첫 여행이에요</option>
								  <option id="purpose3" value="기념일 여행">기념일이라 특별한 여행이에요</option>
								  <option id="purpose4" value="가족과 힐링">가족과 힐링하려고 왔어요</option>
								  <option id="purpose5" value="일상 탈출">일상에서 벗어나고 싶었어요</option>
								  <option id="purpose6" value="사진 찍으러">예쁜 사진 찍으러 왔어요</option>
								  <option id="purpose7" value="반려견 친구 만나러">친구 반려견이랑 만났어요</option>
								  <option id="purpose8" value="반려견 생일여행">반려견 생일 기념 여행이에요</option>
								  <option id="purpose9" value="그냥 함께 있고 싶어서">그냥 함께 있고 싶어서요</option>
								  <option id="purpose10" value="기타">기타</option>
								</select>
			        </div>
		      		<textarea rows="6" cols="80" name="content" id="content" placeholder="리뷰를 등록해주세요." required></textarea>
		      	</div>
					</div>
					<div class="modal-footer">
		      	<button type="button" class="btn btn-success" onclick="reviewUploadCheck()">등록하기</button>
		      	<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
					</div>   
					<input type="hidden" name="roomIdx" id="roomIdx" />
					<input type="hidden" name="hotelIdx" id="hotelIdx" />
					<input type="hidden" name="roomName" id="roomName" />
					<input type="hidden" name="reservationIdx" id="reservationIdx" />
					<input type="hidden" name="reservationNo" id="reservationNo" />
				</form>      
			</div>
		</div>      
	</div>
<p><br></p>


<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>