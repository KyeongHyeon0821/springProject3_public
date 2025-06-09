<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 작성하기</title>
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
      margin-bottom: 30px;
      color: #2e7d32;
    }

    .section-box {
      background: #fff;
      border-radius: 12px;
      padding: 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
    }

    table th {
      background-color: #e0f5e9 !important;
      color: #444 !important;
      padding: 12px;
      text-align: left;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
      width: 150px;
    }

    table td {
      background-color: #fff;
      padding: 14px 12px;
      vertical-align: middle;
    }

    .form-text {
      font-size: 0.9rem;
      color: #888;
    }

    .badge.bg-danger {
      cursor: pointer;
      padding: 6px 10px;
      border-radius: 10px;
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
      let maxSize = 1024 * 1024 * 20;
      let fName = document.getElementById("fSName").value;
      let ext = "";
      let fileSize = 0;
      let title = document.getElementById("title").value;
      let part = document.getElementById("part").value;
      let content = document.getElementById("content").value;

      if (title.trim() === "") {
        alert("제목을 입력해주세요."); return false;
      }

      if (part === "선택해주세요.") {
        alert("문의 분류를 선택해주세요."); return false;
      }

      if (content.trim() === "") {
        alert("내용을 입력해주세요."); return false;
      }

      if (fName.trim() !== "") {
        let fileInput = document.getElementById("fSName");
        for (let file of fileInput.files) {
          ext = file.name.split('.').pop().toLowerCase();
          fileSize += file.size;
          if (!["jpg", "gif", "png", "zip", "ppt", "pptx", "hwp", "webp"].includes(ext)) {
            alert("업로드 가능파일은 'jpg/gif/png/zip/ppt/pptx/hwp/webp' 입니다."); return false;
          }
        }
        if (fileSize > maxSize) {
          alert("업로드할 파일의 최대용량은 20MByte입니다."); return false;
        }
      }

      document.myform.submit();
    }

    function imgCheck(e) {
      if (e.files && e.files[0]) {
        let reader = new FileReader();
        reader.onload = function(event) {
          document.getElementById("photoDemo").src = event.target.result;
          document.getElementById("photoDemo").style.display = "block";
          document.getElementById("removeBtn").style.display = "inline-block";
        }
        reader.readAsDataURL(e.files[0]);
      }
    }

    function removeImage() {
      if (!confirm("이미지를 삭제하시겠습니까?")) return;
      document.getElementById("photoDemo").src = "";
      document.getElementById("photoDemo").style.display = "none";
      document.getElementById("removeBtn").style.display = "none";
      document.getElementById("fSName").value = "";
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">1:1 문의 작성하기</span>
	</div>

  <div class="section-box">
    <form name="myform" method="post" enctype="multipart/form-data">
      <table class="table">
        <tr>
          <th>제목</th>
          <td style="border-top: 1px solid #e5e5e5;">
          	<input type="text" name="title" id="title" class="form-control" placeholder="제목을 입력하세요." required autofocus/>
          </td>
        </tr>
        <tr>
          <th>예약번호</th>
          <td><input type="text" name="reservation" id="reservation" class="form-control" placeholder="예약번호를 알고계시면 입력하세요."/></td>
        </tr>
        <tr>
          <th>분류</th>
          <td>
            <select name="part" id="part" class="form-select">
              <option selected>선택해주세요.</option>
              <option>예약</option>
              <option>결제/환불</option>
              <option>회원정보</option>
              <option>기타</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>내용</th>
          <td><textarea rows="6" name="content" id="content" class="form-control" placeholder="내용을 입력하세요." required></textarea></td>
        </tr>
        <tr>
          <th>첨부파일</th>
          <td>
            <input type="file" name="mFile" id="fSName" onchange="imgCheck(this)" class="form-control mb-2"/>
            <div class="form-text">- 업로드 가능파일은 'jpg/gif/png/zip/ppt/pptx/hwp/webp' 입니다.</div>
            <div>
              <img id="photoDemo" width="200px" style="display:none;"/>
              <button type="button" onclick="removeImage()" id="removeBtn" style="display:none;border:0px" class="badge bg-danger">이미지 삭제</button>
            </div>
          </td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="button" value="작성하기" onclick="fCheck()" class="btn btn-outline-success me-2"/>
            <input type="button" value="다시입력" onclick="location.reload()" class="btn btn-outline-warning me-2"/>
            <input type="button" value="돌아가기" onclick="location.href='${ctp}/inquiry/inquiryList';" class="btn btn-outline-secondary"/>
          </td>
        </tr>
      </table>
      <input type="hidden" name="mid" value="${sMid}"/>
    </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
