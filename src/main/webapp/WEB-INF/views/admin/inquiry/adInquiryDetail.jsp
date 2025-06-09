<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 상세보기 관리</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <style>
    body {
      background-color: #f9fefb;
      font-family: 'Arial', sans-serif;
      font-size: 1.1rem;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 40px 20px;
    }

    .my-page-header {
      text-align: center;
      font-weight: bold;
      font-size: 2rem;
      margin-bottom: 50px;
      color: #2e7d32;
    }

    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 60px 60px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e0e0e0;
      margin: 40px auto;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 15px;
    }

    table th {
      background-color: #e0f5e9 !important;
      color: #444 !important;
      padding: 14px 20px;
      text-align: center;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
      width: 150px;
    }

    table td {
      background-color: #fff;
      padding: 14px 20px;
      vertical-align: middle;
      border-bottom: 1px solid #e5e5e5;
    }

    .form-label {
      font-weight: bold;
      color: #2e7d32;
    }

    .img-thumbnail {
      border-radius: 8px;
      border: 1px solid #ddd;
    }

    .btn {
      font-size: 1rem;
    }

    .badge {
      padding: 4px 10px;
      font-size: 0.9rem;
      font-weight: 500;
      border-radius: 10px;
      color: white;
    }

    .badge.bg-success { background-color: #388e3c; }
    .badge.bg-warning { background-color: #f9a825; }
    .badge.bg-secondary { background-color: #9e9e9e; }
    .badge.bg-info { background-color: #64b5f6; }
  </style>
  
	<script>
	'use strict';
	
	function inquiryReplyInput() {
	  let idx = ${vo.idx};
	  let reContent = document.getElementById("reContent").value;
	  if(reContent == "") {
	    alert("답변을 입력하세요.");
	    document.replyForm.reContent.focus();
	    return false;
	  }
	  let query = {
	    idx : idx,
	    reContent : reContent
	  }
	  $.ajax({
	    url : "${ctp}/admin/inquiry/adInquiryDetail",
	    type : "post",
	    data : query,
	    success:function(res) {
	      if(res != "0") {
	        alert("답변이 등록되었습니다.");
	        location.reload();
	      }
	      else alert("답변 등록 실패");
	    },
	    error:function() { alert("전송오류"); }
	  });
	}
	
	function inquiryReplyUpdateReady() {
	  document.getElementById("btnReplyUpdate").style.display = "none";
	  document.getElementById("btnReplyUpdateOk").style.display = "inline-block";
	  document.getElementById("reContent").readOnly = false;
	}
	
	function inquiryReplyUpdateOk() {
	  let reContent = document.getElementById("reContent").value;
	  if(reContent.trim() == "") {
	    alert("수정할 답변을 입력하세요.");
	    return false;
	  }
	  let query = {
	    reIdx : ${vo.reIdx},
	    reContent : reContent
	  }
	  $.ajax({
	    url : "${ctp}/admin/inquiry/adInquiryDetailUpdate",
	    type : "post",
	    data : query,
	    success:function(res) {
	      if(res != "0"){
	        alert("답변이 수정되었습니다.");
	        location.reload();
	      }
	      else alert("답변 수정 실패");
	    },
	    error : function() { alert("전송오류"); }
	  });
	}
	
	function inquiryHoldCheck() {
	  $.ajax({
	    url : "${ctp}/admin/inquiry/adInquiryDetailHold",
	    type : "post",
	    data : {idx : ${vo.idx}},
	    success:function(res) {
	      if(res != "0"){
	        alert("답변이 보류되었습니다.");
	        location.reload();
	      }
	      else alert("답변 보류 실패");
	    },
	    error : function() { alert("전송오류"); }
	  });
	}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">1:1 문의 리스트</span>
	</div>

  <div class="section-box">
    <table class="table">
      <tr>
        <th style="width:15%;">작성자</th>
        <td style="width:35%; border-top: 1px solid #e5e5e5;">${vo.mid}</td>
        <th style="width:15%;">작성일시</th>
        <td style="width:35%; border-top: 1px solid #e5e5e5;"><c:out value="${vo.WDate.substring(0,16)}" /></td>
      </tr>
      <tr>
        <th>제목</th>
        <td>${vo.title}</td>
        <th>분류</th>
        <td>${vo.part}</td>
      </tr>
      <tr>
        <th>예약번호</th>
        <td>
          <c:choose>
            <c:when test="${empty vo.reservation}">-</c:when>
            <c:otherwise>${vo.reservation}</c:otherwise>
          </c:choose>
        </td>
        <th>답변 상태</th>
        <td>
          <c:choose>
            <c:when test="${vo.reply == '답변대기중'}">
              <span class="badge bg-secondary">${vo.reply}</span>
            </c:when>
            <c:when test="${vo.reply == '답변완료'}">
              <span class="badge bg-success">${vo.reply}</span>
            </c:when>
            <c:when test="${vo.reply == '답변보류'}">
              <span class="badge bg-warning">${vo.reply}</span>
            </c:when>
            <c:otherwise>
              <span class="badge bg-info">${vo.reply}</span>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr>
        <th>문의내용</th>
        <td colspan="5">
          <div class="text-start" style="min-height:300px; height:auto;">
            ${vo.content}
          </div>
        </td>
      </tr>
      <tr>
        <th>첨부파일</th>
        <td colspan="3">
          <c:if test="${not empty vo.FSName}">
            <img src="${ctp}/inquiry/${vo.FSName}" width="200px" class="img-thumbnail" style="cursor:pointer;" data-bs-toggle="modal" data-bs-target="#imageModal" />
          </c:if>
          <c:if test="${empty vo.FSName}">없음</c:if>
        </td>
      </tr>
    </table>

    <div class="text-center mt-4">
      <c:if test="${vo.reply != '답변보류'}">
        <input type="button" value="보류하기" onclick="inquiryHoldCheck()" class="btn btn-outline-warning me-2">
      </c:if>
      <button class="btn btn-outline-secondary" onclick="location.href='${ctp}/admin/inquiry/adInquiryList';">목록으로</button>
    </div>

    <div class="mt-5">
      <form name="replyForm" method="post" action="${ctp}/admin/inquiry/adInquiryDetail?idx=${vo.idx}">
        <div class="mb-3">
          <label for="reContent" class="form-label">답변글 작성</label>
          <textarea name="reContent" id="reContent" class="form-control" rows="6" placeholder="답변글을 작성해주세요." ${not empty vo.reContent ? 'readonly' : ''}>${vo.reContent}</textarea>
        </div>
        <div class="text-end">
          <c:if test="${empty vo.reContent}">
            <input type="button" value="답변등록" id="btnReplyInput" onclick="inquiryReplyInput()" class="btn btn-outline-primary mb-2">
          </c:if>
          <c:if test="${!empty vo.reContent}">
            <input type="button" value="답변수정" id="btnReplyUpdate" onclick="inquiryReplyUpdateReady()" class="btn btn-outline-danger">
          </c:if>
          <input type="button" value="수정완료" id="btnReplyUpdateOk" onclick="inquiryReplyUpdateOk()" class="btn btn-outline-info" style="display:none">
        </div>
      </form>
    </div>
  </div>

  <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="imageModalLabel">첨부파일 이미지</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body text-center">
          <c:if test="${!empty vo.FSName}">
            <img src="${ctp}/inquiry/${vo.FSName}" class="img-fluid"/>
          </c:if>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>