<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 문의 수정</title>
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
      background-color: #e0f5e9;
      color: #444;
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
      border-bottom: 1px solid #e5e5e5;
    }

    table tr:last-child td {
      border-bottom: none;
    }

    .form-text {
      font-size: 0.9rem;
      color: #888;
    }

    .img-thumbnail {
      border-radius: 8px;
      border: 1px solid #ddd;
    }

    .btn {
      font-size: 1rem;
    }

    .badge.bg-danger {
      cursor: pointer;
      padding: 6px 10px;
      border-radius: 10px;
    }
  </style>
  <script>
    'use strict';
    function imgCheck(e) {
      if (e.files && e.files[0]) {
        let reader = new FileReader();
        reader.onload = function(evt) {
          const img = document.getElementById("photoDemo");
          const btn = document.getElementById("removeBtn");
          img.src = evt.target.result;
          img.style.display = "block";
          btn.style.display = "inline-block";
        }
        reader.readAsDataURL(e.files[0]);
      }
    }
    function removeImage() {
      if (!confirm("이미지를 삭제하시겠습니까?")) return false;
      const img = document.getElementById("photoDemo");
      const btn = document.getElementById("removeBtn");
      img.src = "";
      img.style.display = "none";
      btn.style.display = "none";
      document.getElementById("fSName").value = "";
    }
    function imageDelete(idx,fSName) {
      if (!confirm("해당 이미지를 삭제하시겠습니까?\n삭제를 선택하시면 현재 이미지는 영구히 삭제됩니다.")) return false;
      $.ajax({
        url: "imageDelete",
        type: "post",
        data: { idx: idx, fSName: fSName },
        success: function(res) {
          if (res != "0") {
            alert('파일이 삭제되었습니다.');
            location.reload();
          } else {
            alert('삭제에 실패했습니다.');
          }
        },
        error: function() { alert('전송오류!'); }
      });
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">1:1 문의 수정하기</span>
	</div>

  <div class="section-box">
    <form name="myform" method="post" enctype="multipart/form-data">
      <table>
        <tr>
          <th>제목</th>
          <td style="border-top: 1px solid #e5e5e5;">
        	  <input type="text" name="title" value="${vo.title}" required class="form-control" />
          </td>
        </tr>
        <tr>
          <th>예약번호</th>
          <td><input type="text" name="reservation" value="${vo.reservation}" class="form-control" /></td>
        </tr>
        <tr>
          <th>분류</th>
          <td>
            <select name="part" class="form-select">
              <option ${vo.part=='예약'?'selected':''}>예약</option>
              <option ${vo.part=='결제/환불'?'selected':''}>결제/환불</option>
              <option ${vo.part=='회원정보'?'selected':''}>회원정보</option>
              <option ${vo.part=='기타'?'selected':''}>기타</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>내용</th>
          <td><textarea name="content" rows="6" class="form-control" required>${vo.content}</textarea></td>
        </tr>
        <tr>
          <th>첨부파일</th>
          <td>
            <c:if test="${empty vo.FSName}">
              <div>
                <img id="photoDemo" width="150" style="display:none;" />
                <button type="button" id="removeBtn" onclick="removeImage()" class="badge bg-danger" style="display:none;border:0;">이미지 삭제</button>
              </div>
            </c:if>
            <c:if test="${not empty vo.FSName}">
              <div style="display:flex; align-items:flex-end; gap:10px;">
                <div class="img-thumbnail p-1">
                  <img src="${ctp}/inquiry/${vo.FSName}" width="200" style="border-radius:4px;" />
                </div>
                <button type="button" onclick="imageDelete('${vo.idx}','${vo.FSName}')" class="btn btn-outline-danger btn-sm">삭제</button>
              </div>
            </c:if>
            <input type="file" id="fSName" name="mFile" onchange="imgCheck(this)" class="form-control mt-3 mb-2" />
            <div class="form-text">새 파일을 등록하면 기존 파일이 대체됩니다.</div>
            <div class="imgs_wrap form-text text-muted"><img id="photoDemo" width="100px"/></div>
          </td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="submit" value="수정하기" class="btn btn-outline-success me-2" />
            <input type="button" value="다시입력" onclick="location.reload()" class="btn btn-outline-warning me-2" />
            <input type="button" value="돌아가기" onclick="location.href='${ctp}/inquiry/inquiryList';" class="btn btn-outline-secondary" />
          </td>
        </tr>
      </table>
      <input type="hidden" name="idx" value="${vo.idx}" />
      <input type="hidden" name="fSName" value="${vo.FSName}" />
    </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
