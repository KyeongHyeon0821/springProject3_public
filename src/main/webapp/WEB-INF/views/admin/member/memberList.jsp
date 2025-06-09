<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script>
  	'use strict';
  	
  	// 등급별 화면 출력처리
  	function levelItemCheck() {
  		let level = $("#levelItem").val();
  		location.href = "memberList?level=" + level;
  	
  	}
/*   	// 회원 등급 변경처리
  	function levelChange(e) {
//  		alert(" value : " + myform.level.value);
//  		alert(" value : " + e.value);
//  		console.log("e",e);
			let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
			if(!ans) {
				location.reload();
				return false;
			}
			
			let items = e.value.split("/");
			let query = {
					level : items[0],
					idx : items[1]
			}
			
			$.ajax({
				url : "${ctp}/admin/memberLevelChange",
				type : "post",
				data : query,
				success:function(res) {
					if(res != "0") {
						alert("등급 수정 완료!");
						location.reload();
					}
					else alert("등급 수정 실패");
				},
				error:function() { alert("전송오류!"); }
			});
  	} */
		
    // 닉네임 클릭시 모달을 통해서 회원 '닉네임/아이디/사진' 보여주기
    function imgInfor(nickName, mid, photo) {
    	$("#myModal1 .modal-header .nickName").html(nickName);
    	$("#myModal1 .modal-body .mid").html(mid);
    	$("#myModal1 .modal-body .imgSrc").attr("src","${ctp}/resources/data/member/"+photo)
    }
    
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
    
    /* // 여러개 선택항목 등급변경처리
    function levelSelectCheck() {
    	let idx = document.getElementById("idx");
    	let select = document.getElementById("levelSelect");
    	let levelSelectText = select.options[select.selectedIndex].text;
    	let levelSelect = select.options[select.selectedIndex].value;
    	let idxSelectArray = '';
    	
      for(let i=0; i<myform.idxFlag.length; i++) {
        if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value + "/";
      }
    	if(idxSelectArray == '') {
    		alert("등급을 변경할 항목을 1개 이상 선택하세요");
    		return false;
    	}
    	
    	let ans = confirm("선택한 항목의 등급을 "+levelSelectText+"등급으로 변경하시겠습니까?");
    	if(!ans) return false;
    	
      idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
      let query = {
    		  idxSelectArray : idxSelectArray,
    		  levelSelect : levelSelect
      }
      
      $.ajax({
    	  url  : "${ctp}/admin/member/memberLevelSelectCheck",
    	  type : "post",
    	  data : query,
    	  success:function(res) {
    		  if(res != "0") alert("선택한 항목들이 "+levelSelectText+"(으)로 변경되었습니다.");
    		  else alert("등급변경 실패~");
  			  location.reload();
    	  },
    	  error : function() {
    		  alert("전송 실패~~");
    	  }
      });
    } */
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
<c:choose>
	<c:when test="${section == 2}">
  	<h2>고객 리스트</h2>
  </c:when>
  <c:otherwise>
  	<h2>사업자 리스트</h2>
  </c:otherwise>
</c:choose>  
  <div class="row mb-1">
    <div class="col-7">
	    <div class="input-group">
	      <input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm"/>
	      <input type="button" value="전체취소" onclick="allReset()" class="btn btn-primary btn-sm"/>
	      <input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm me-2"/>
	    </div>
    </div>
    <div class="col-2"></div>
  </div>
  
  <form name="myform">
  	<table class="table table-hover text-center border-secondary">
  		<tr class="table-secondary">
  			<th>번호</th>
  			<th>아이디</th>
  			<th>닉네임</th>
  			<th>성명</th>
  			<th>생일</th>
  			<th>성별</th>
  			<th>최종방문일</th>
  			<th>오늘방문횟수</th>
  			<th>활동여부</th>
  			<c:if test="${section == 1}">
        	<th>사업자등록번호</th>
      	</c:if>
  			<th>현재레벨</th>
  		</tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
        <tr>
          <td>
          	<c:if test="${vo.level != 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
          	<c:if test="${vo.level == 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}" disabled/></c:if>
          	${vo.idx}
          </td>
          <td><a href="${ctp}/admin/memberInfor/${vo.idx}" title="회원정보 상세보기">${vo.mid}</a></td>
          <!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal1">Open modal 1</button> -->
          <td><a href="#" onclick="imgInfor('${vo.nickName}','${vo.mid}')" data-bs-toggle="modal" data-bs-target="#myModal1">${vo.nickName}</a></td>
          <td>${vo.name}</td>
          <td>${fn:substring(vo.birthday,0,10)}</td>
          <td>${vo.gender}</td>
          <td>${fn:substring(vo.lastDate,0,10)}</td>
          <td>${vo.todayCnt}</td>
          <td>
          	${vo.userDel == 'NO' ? '활동중' : '<font color=red>탈퇴신청</font>'}
           	<c:if test="${vo.userDel == 'OK'}">(<font color="blue"><b>${vo.deleteDiff}</b></font>)</c:if>
          </td>
          <c:if test="${section == 1}">
          	<td>${vo.businessNo}</td>
          </c:if>
          <td>
            <select name="level" id="level" >
              <option value="1/${vo.idx}"   ${vo.level == 1 ? 'selected' : ''}>사업자회원</option>
              <option value="2/${vo.idx}"   ${vo.level == 2 ? 'selected' : ''}>일반회원</option>
              <option value="0/${vo.idx}"   ${vo.level == 0 ? 'selected' : ''}>관리자</option>
              <option value="999/${vo.idx}" ${vo.level == 999 ? 'selected' : ''}>탈퇴신청회원</option>
              <option value="888/${vo.idx}" ${vo.level == 888 ? 'selected' : ''}>탈퇴신청회원</option>
              
            </select>
          </td>
        </tr>
      </c:forEach>
    </table>
  </form>
  
<!-- 페이징처리 -->  
  
  
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title nickName"></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <p>아이디 : <span class="mid"></span></p>
        <p>포토<br/>
          <img class="imgSrc" width="250px"/>
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
</body>
</html>