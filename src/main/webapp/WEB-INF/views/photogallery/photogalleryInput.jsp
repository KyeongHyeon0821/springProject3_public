<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>photogalleryInput.jsp</title>
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
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
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

    table tr:last-child td {
      border-bottom: none !important;
    }

    .form-text {
      font-size: 0.9rem;
      color: #888;
    }

    .btn {
      font-size: 1rem;
    }
  </style>
  <script>
	  'use strict';
	  function fCheck() {
		  let part = myform.part.value;
	    let title = myform.title.value;
	    if (privacyRegit(privacy_editor)) return false;
	    else if (title == "") {
	      alert("제목을 입력해주세요.");
	      myform.title.focus();
	      return false;
	    }
	    else if (part == "") {
	      alert("장소를 선택해주세요.");
	      return false;
	    }
	    else myform.submit();
	  }
	
	  function privacyRegit(privacy_editor){ 
	    if(privacy_editor.getData().trim() == ''){ 
	      alert("내용을 입력해주세요."); 
	      return true; 
	    } 
	  }
	  
	  // 장소리스트
	  function jansoCheck() {
		  //alert("ddd : " + '${pVos[0]}');
		 
	  	$(".modal-header #cnt").html(${fn:length(pVos)});
			let jusorok = '';
			jusorok += '<table class="table table-hover">';
			jusorok += '<tr class="table-dark text-dark text-center">';
			jusorok += '<th class="text-center">번호</th><th class="text-center">장소</th>';
			jusorok += '</tr>';
			jusorok += '<c:forEach var="vo" items="${pVos}" varStatus="st">';
			jusorok += '<tr onclick="javascript:inputJangsoCheck(${vo.idx},\'${vo.name}\')" class="text-center">';
			jusorok += '<td>${st.count}</td>';
			jusorok += '<td>${vo.name}</td>';
			jusorok += '</tr>';
			jusorok += '</c:forEach>';
			jusorok += '';
			jusorok += '</table>';
			$(".modal-body #jangsoCheck").html(jusorok);
	  }
	  function inputJangsoCheck(idx, name) {
    	$("#spotIdx").val(idx);
    	$("#part").val(name);
    	$(".btn-close").click();
	    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">포토갤러리 작성하기</span>
	</div>
	
	<div class="section-box">
	  <form name="myform" method="post">
	    <table class="table">
	      <tr>
	        <th>작성자</th>
	        <td style="border-top: 1px solid #e5e5e5;"><input type="text" name="nickName" value="${sNickName}" readonly class="form-control"/></td>
	      </tr>
	      <tr>
	        <th>제목</th>
	        <td><input type="text" name="title" placeholder="제목을 입력하세요." required class="form-control"/></td>
	      </tr>
        <tr>
          <th>장소</th>
          <td>
          	<div style="display: flex; align-items: center; gap: 10px;">
							<input type="button" value="장소선택" onclick="jansoCheck()" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#myModal" />
	          	<input type="text" name="part" id="part" class="form-control" readonly style="width: 300px"/>
						</div>
          </td>
        </tr>
	      <tr>
	        <th>내용</th>
	        <td>
	          <textarea name="content" id="CKEDITOR" rows="6" placeholder="내용을 입력하세요." required class="form-control"></textarea>
	          <script>
	            var privacy_editor = CKEDITOR.replace("content", {
	              height: 460,
	              filebrowserUploadUrl: "${ctp}/imageUpload",
	              uploadUrl: "${ctp}/imageUpload"
	            });
	          </script>
	        </td>
	      </tr>
	      <tr>
	        <td colspan="2" class="text-center mt-2">
	          <input type="button" value="작성하기" onclick="fCheck()" class="btn btn-outline-success me-2"/>
	          <input type="button" value="다시쓰기" onclick="location.reload()" class="btn btn-outline-warning me-2"/>
	          <input type="button" value="돌아가기" onclick="location.href='${ctp}/photogallery/photogalleryList';" class="btn btn-outline-secondary"/>
	        </td>
	      </tr>
	    </table>
	    <input type="hidden" name="mid" value="${sMid}"/>
	    <input type="hidden" name="spotIdx" id="spotIdx" />
	  </form>
	</div>
</div>

<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-dialog-centered">
	  <div class="modal-content" style="width:600px">
	  	<div class="modal-header" style="width:600px">
	  		<h4 class="modal-title">장소 선택</h4>
	  		<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	  	</div>
	  	<div class="modal-body" style="width:600px;height:400px;overflow:auto;">
	  		<span id="jangsoCheck"></span>
	  	</div>
	  	<div class="modal-footer" style="width:600px">
	  		<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	  	</div>
	  </div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>