<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 수정하기</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
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
      margin-bottom: 30px;
      color: #2e7d32;
    }

    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 60px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e0e0e0;
      margin-top: 30px;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
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
      border-bottom: 1px solid #e5e5e5;
    }

    table tr:last-child td {
      border-bottom: none !important;
    }

    .btn {
      font-size: 1rem;
    }
  </style>
  <script>
  	'use strict';
  	
  	function fCheck() {
  		let title = myform.title.value;
  		
  		if(privacyRegit(privacy_editor)) return false;
  		else if(title == "") {
  			alert("제목을 입력해주세요.");
  			myform.title.focus();
  			return false;
  		}
  		else myform.submit();
  	}
  	
    // ckeditor null값체크하도록 처리하기 함수
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
  <span class="my-page-header">QnA 수정하기</span>
</div>
<div class="container">
  <div class="section-box">
    <form name="myform" method="post">
      <table class="table">
        <tr>
          <th>작성자</th>
          <td style="border-top: 1px solid #e5e5e5;"><input type="text" name="nickName" value="${vo.nickName}" readonly class="form-control"/></td>
        </tr>
        <tr>
          <th>제목</th>
          <td><input type="text" name="title" value="${vo.title}" required class="form-control"/></td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><input type="text" name="email" value="${vo.email}" required class="form-control"/></td>
        </tr>
        <tr>
          <th>내용</th>
          <td><textarea name="content" id="CKEDITOR" rows="6" placeholder="내용을 입력하세요." required class="form-control">${vo.content}</textarea>
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
          <th>비밀글</th>
          <td>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" name="openSw" id="openSwCheck" ${vo.openSw == 'NO' ? 'checked' : ''}>
              <label class="form-check-label" for="openSwCheck">비밀글</label>
            </div>
            <div class="form-text text-muted">선택 시, 비밀글로 등록됩니다.</div>
          </td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="button" value="수정하기" onclick="fCheck()" class="btn btn-outline-success me-2"/>
            <input type="button" value="다시쓰기" onclick="location.reload()" class="btn btn-outline-warning me-2"/>
            <input type="button" value="돌아가기" onclick="location.href='${ctp}/qna/qnaList';" class="btn btn-outline-secondary"/>
          </td>
        </tr>
      </table>
      <input type="hidden" name="qnaSw" value="${qnaSw}"/>
      <input type="hidden" name="mid" value="${sMid}"/>
      <input type="hidden" name="ansLevel" value="${sLevel}"/>
      <input type="hidden" name="idx" value="${idx}"/>
    </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>