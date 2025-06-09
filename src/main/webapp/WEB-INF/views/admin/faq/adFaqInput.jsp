<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 글쓰기</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
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
      margin-bottom: 70px;
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
      margin-top: 10px;
      margin-bottom: 10px;
    }

    table th {
      background-color: #e0f5e9 !important;
      color: #444 !important;
      padding: 14px 20px;
      text-align: left;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
      width: 150px;
    }

    table td {
      background-color: #fff;
      padding: 14px 20px;
      vertical-align: middle;
    }

    .btn {
      font-size: 1rem;
    }

    table tr:last-child td {
      border-bottom: none !important;
    }
  </style>
  <script>
  	'use strict';
  
  	function fCheck() {
  	  let title = myform.title.value;
  	  let category = $("#category").val();
  	  
  	  if (privacyRegit(privacy_editor)) return false;
  	  
  	  if (title == "") {
  	    alert("제목을 입력해주세요.");
  	    myform.title.focus();
  	    return false;
  	  }
  	  
  	  if (category == "") {
  	    alert("분류를 선택해주세요.");
  	    return false;
  	  }

  	  myform.submit();
  	}

    function privacyRegit(privacy_editor){ 
			if(privacy_editor.getData().trim() == ''){ 
				alert("내용을 입력해주세요."); 
				return true; 
			} 
		}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="col m-3 text-center">
  <span class="my-page-header">FAQ 작성하기</span>
</div>

<div class="container section-box">
  <form name="myform" method="post">
    <table class="table">
      <tr>
        <th>분류</th>
        <td style="border-top: 1px solid #e5e5e5;">
          <select name="category" id="category" class="form-select">
            <option selected value="">선택해주세요.</option>
            <option>예약</option>
            <option>결제/환불</option>
            <option>회원정보</option>
            <option>기타</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>제목</th>
        <td><input type="text" name="title" placeholder="제목을 입력하세요." required class="form-control"/></td>
      </tr>
      <tr>
        <th>내용</th>
        <td><textarea name="content" id="CKEDITOR" rows="6" placeholder="내용을 입력하세요." required class="form-control"></textarea>
         <script>
           var privacy_editor = CKEDITOR.replace("content",{
             height:460,
             filebrowserUploadUrl:"${ctp}/imageUpload",
             uploadUrl : "${ctp}/imageUpload"
           });
         </script>
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="등록하기" onclick="fCheck()" class="btn btn-outline-success me-2"/>
          <input type="button" value="다시쓰기" onclick="location.reload()" class="btn btn-outline-warning me-2"/>
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/faq/adFaqList';" class="btn btn-outline-secondary"/>
        </td>
      </tr>
    </table>
  </form>
</div>

<p><br/></p>
</body>
</html>
