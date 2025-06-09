<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>hotelList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script>
  	'use strict';
  	
  	// 등급별 화면 출력처리
  	function statusItemCheck() {
  		let level = $("#statusItem").val();
  		location.href = "hotelList?status=" + status;
  	
  	}
/*    	// 호텔 상태 변경처리
  	function statusChange(e) {
//  		alert(" value : " + myform.level.value);
//  		alert(" value : " + e.value);
//  		console.log("e",e);
			let ans = confirm("선택한 호텔의 상태를 변경하시겠습니까?");
			if(!ans) {
				location.reload();
				return false;
			}
			
			let items = e.value.split("/");
			let query = {
					level :items[0],
					idx : items[1]
			}
			
			$.ajax({
				url : "${ctp}/admin/hotelStatusChange",
				type : "post",
				data : query,
				success:function(res) {
					if(res != "0") {
						alert("상태 수정 완료!");
						location.reload();
					}
					else alert("상태 수정 실패");
				},
				error:function() { alert("전송오류!"); }
			});
  	} 
		
    // 닉네임 클릭시 모달을 통해서 회원 '닉네임/아이디/사진' 보여주기
/*     function imgInfor(nickName, mid, photo) {
    	$("#myModal1 .modal-header .nickName").html(nickName);
    	$("#myModal1 .modal-body .mid").html(mid);
    	$("#myModal1 .modal-body .imgSrc").attr("src","${ctp}/resources/data/member/"+photo)
    } */
    
    // 전체선택
    function allCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = true;
      }
    }

    // 전체취소
    function allReset() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = false;
      }
    }

    // 선택반전
    function reverseCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = !myform.idxFlag[i].checked;
      }
    }
    
     // 여러개 선택항목 등급변경처리
    function statusSelectCheck() {
    	let idx = document.getElementById("idx");
    	let select = document.getElementById("statusSelect");
    	let statusSelect = select.options[select.selectedIndex].value;
    	let idxSelectArray = '';
    	
      for(let i=0; i<myform.idxFlag.length; i++) {
        if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value + "/";
      }
    	if(idxSelectArray == '') {
    		alert("상태를 변경할 항목을 1개 이상 선택하세요");
    		return false;
    	}
    	
    	let ans = confirm("선택한 항목의 상태를 "+statusSelect+"상태로 변경하시겠습니까?");
    	if(!ans) return false;
    	
      idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
      
      let query = {
    		  idxSelectArray : idxSelectArray,
    		  statusSelect : statusSelect
      }
      
      $.ajax({
    	  url  : "${ctp}/admin/hotel/hotelStatusSelectCheck",
    	  type : "post",
    	  data : query,
    	  success:function(res) {
    		  if(res != "0") alert("선택한 항목들이 "+statusSelect+"(으)로 변경되었습니다.");
    		  else alert("상태변경 실패~");
  			  location.reload();
    	  },
    	  error : function() {
    		  alert("전송 실패~~");
    	  }
      });
    } 
  </script>
  <style>
  	body {
  		background-color: #F6F5F2;
  	}
    a {text-decoration: none}
    a:hover {
      text-decoration: underline;
      color: orange;
    }

  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>호텔 리스트</h2>
  <div class="row mb-1">
    <div class="col-7">
	    <div class="input-group">
	      <input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm"/>
	      <input type="button" value="전체취소" onclick="allReset()" class="btn btn-primary btn-sm"/>
	      <input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm me-2"/>
	      <select name="statusSelect" id="statusSelect" class="form-select form-select-sm">  
	        <option>정상</option>
	        <option>서비스중지신청</option>
	        <option>서비스중지</option>
	      </select>
	      <input type="button" value="선택항목등급변경" onclick="statusSelectCheck()" class="btn btn-warning btn-sm" />
	    </div>
    </div>
    
  </div>
  
  <form name="myform">
  	<table class="table table-hover text-center border-secondary">
  		<tr class="table-secondary hotel-headLow">
  			<th>번호</th>
  			<th>호텔등록ID</th>
  			<th>호텔이름</th>
  			<th>주소</th>
  			<th>연락처</th>
  			<th>썸네일</th>
  			<th>상태</th>
  			<th>status</th>
  			<th>객실정보</th>
  		</tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
        <tr class="hotel-low">
          <td><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/>
          	${vo.idx}
          </td>
          <td>${vo.mid}</td>
          <td><a href="${ctp}/hotel/hotelDetail?idx=${vo.idx}" title="호텔정보 상세보기">${vo.name}</a></td>
          <td>${vo.address}</td>
          <td>${vo.tel}</td>
          <td>${vo.thumbnail}</td>
          <td>${vo.status}</td>
          <td>
            <select name="status" id="status">
              <option value="1/${vo.idx}"   ${vo.status == '정상' ? 'selected' : ''}>정상</option>
              <option value="2/${vo.idx}"   ${vo.status == '서비스중지신청' ? 'selected' : ''}>서비스중지신청</option>
              <option value="3/${vo.idx}"   ${vo.status == '서비스중지' ? 'selected' : ''}>서비스중지</option>
            </select>
          </td>
          <td>
          	<a href="${ctp}/admin/room/roomList?hotelIdx=${vo.idx}" class="btn btn-dark">객실정보</a>
          </td>
        </tr>
      </c:forEach>
    </table>
  </form>
  
<!-- 페이징처리 -->  
</div>


</body>
</html>