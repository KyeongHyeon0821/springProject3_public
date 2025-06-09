<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위드펫 - 객실이미지수정</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<script>
		'use strict';
		
		// 기존 이미지 삭제 처리(1개)
		function imageFileDelete(imageFileName) {
			let ans = confirm("해당 이미지를 삭제하시겠습니까?");
			if(!ans) return false;
			
			let images = '${vo.images}';
			let idx = ${vo.idx};
				
			$.ajax({
				url : "${ctp}/room/roomImageFileDelete",
				type : "post",
				data : {
					imageFileName : imageFileName,
					images : images,
					idx : idx
					},
				success : function(res) {
					if(res != "0") {
						alert("이미지가 삭제되었습니다.");
						location.reload();
					}
					else alert("이미지 삭제를 실패했습니다.\n다시 시도해주세요.");
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
		
		
		// 기존 이미지 전체 삭제 처리
		function imageFilesDeleteAll() {
			let ans = confirm("썸네일 외 이미지를 전부 삭제하시겠습니까?");
			if(!ans) return false;
			
			let idx = ${vo.idx};
			let images = '${vo.images}';
			
			$.ajax({
				url : "${ctp}/room/roomImageFilesDeleteAll",
				type : "post",
				data : {
					idx : idx,
					images : images
					},
				success : function(res) {
					if(res != "0") {
						alert("썸네일 외 이미지가 전부 삭제되었습니다.");
						location.reload();
					}
					else alert("이미지 삭제를 실패했습니다.\n다시 시도해주세요.");
				},
				error : function() { alert("다시 시도해주세요."); }
			});
		}
		
		
		// 이미지 수정 처리
		function fCheck() {
			
			let thumbnailFile = $("#thumbnailFile").val(); // 썸네일 파일 이름
			
			// 이미지 파일 체크용 변수 선언
			let maxSize = 1024 * 1024 * 20; // 한번에 업로드할 파일의 최대용랑을 20mb로 한정
			let ext = "";
			let fileSize = 0;
			
			// 썸네일 파일 변경시 파일 용량 체크, 확장자 체크
			let file = document.getElementById("thumbnailFile").files[0];
			
			if(file) {
				ext = thumbnailFile.substring(thumbnailFile.lastIndexOf(".")+1).toLowerCase();
				fileSize = document.getElementById("thumbnailFile").files[0].size;
				
				if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 20mb 입니다.");
					$("#thumbnailFile").focus();
					return false;
				}
				
				if(ext !="jpg" && ext !="gif" && ext !="png" && ext !="jpeg" && ext !="webp") {
					alert("업로드 가능 파일은 'jpg/gif/png/jpeg/webp' 입니다.");
					$("#thumbnailFile").focus();
					return false;
				}
			}
			
			
			// 썸네일 외 이미지 파일 확장자 체크, 파일 누적 크기 체크
			let imageFiles = document.getElementById("imageFiles").value; // 이미지 이름
			let imageFilesLength = document.getElementById("imageFiles").files.length; // 이미지 파일 갯수
			// 썸네일 외 이미지 파일을 업로드 했을 경우에만 체크
			if(imageFilesLength > 0) {
				// 각 파일 확장자 체크, 파일 누적 크기 체크
				for(let i=0; i<imageFilesLength; i++) {
					let imageFileName = document.getElementById("imageFiles").files[i].name;
					ext = imageFileName.substring(imageFileName.lastIndexOf(".")+1).toLowerCase();
					fileSize += document.getElementById("imageFiles").files[i].size;
					
					if(ext !="jpg" && ext !="gif" && ext !="png" && ext !="jpeg" && ext !="webp") {
						alert("업로드 가능 파일은 'jpg/gif/png/jpeg/webp' 입니다.");
						return false;
					}
					
					if(fileSize > maxSize) {
						alert("업로드할 파일의 최대용량은 20mb 입니다.");
						return false;
					}
				}
			}
			return true;
		}
		
		// 썸네일 이미지 미리보기
		function thumbnailCheck(e) {
	    if(e.files && e.files[0]) {
	      let reader = new FileReader();
	      reader.onload = function(e) {
	        document.getElementById("thumbnailPreview").src = e.target.result;
	      }
	      reader.readAsDataURL(e.files[0]);
	    }
	    $("#beforeThumbnailPreview").hide();
	    $("#thumbnailPreview").show();
	  }
	</script>
	<style>
	  body {
	  background-color: #f9fefb;
		}
		
		.form-container {
		  max-width: 1000px; /* 크기를 더 크게 설정 */
 			width: 100%; /* 전체 너비에 맞게 설정 */
		  margin: 50px auto;
		  padding: 30px;
		  background-color: #fff;
		  border: 1px solid #cde6da;
		  border-radius: 15px;
		  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
		}
		
		.page-title {
		  text-align: center;
		  color: #2e7d32;
		  margin-bottom: 30px;
		  font-weight: bold;
		}
		
		.form-group {
		  margin-bottom: 20px;
		}
		
		.form-label {
		  font-weight: bold;
		  color: #2e7d32;
		  margin-bottom: 5px;
		  margin-top: 2rem;
		  display: block;
		}
		
		.form-control {
		  width: 100%;
		  padding: 10px;
		  border: 1px solid #cde6da;
		  border-radius: 6px;
		  box-sizing: border-box;
		}
		
		.preview-img {
		  width: 100%;
		  max-width: 200px;
		  border: 1px solid #ccc;
		  border-radius: 6px;
		}
		
		.image-gallery {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 20px;
		  margin-top: 15px;
		}
		
		.image-card {
		  display: flex;
		  flex-direction: column;
		  align-items: center;
		}
		
		.btn-custom-delete {
		  margin-top: 8px;
		  background-color: #e53935;
		  color: #fff;
		  border: none;
		  padding: 8px 12px;
		  border-radius: 6px;
		  cursor: pointer;
		}
		
		.btn-custom-delete.small {
		  padding: 5px 10px;
		  font-size: 0.9em;
		}
		
		.btn-custom-delete:hover {
		  background-color: #c62828;
		}
		
		.text-center {
		  text-align: center;
		}
		.form-text.text-muted {
		  display: block;
		  margin-top: 4px;
		  margin-bottom: 6px;
		  font-size: 0.9em;
		  color: #6c757d;
		}
		
		/* 공통 버튼 스타일 */
		.custom-btn {
		  padding: 10px 18px;
		  font-size: 15px;
		  border: none;
		  border-radius: 8px;
		  text-decoration: none;
		  color: white;
		  transition: background-color 0.3s ease;
		  cursor: pointer;
		  margin: 0 6px;
		}
		
		/* 각 버튼 색상 */
		.submit-btn {
		  background-color: #28a745;
		}
		.submit-btn:hover {
		  background-color: #218838;
		}
		
		.reset-btn {
		  background-color: #ffc107; /* 노란 계열 (다시입력) */
		  color: black;
		}
		.reset-btn:hover {
		  background-color: #e0a800;
		}
		
		.back-btn {
		  background-color: #6c757d; /* 회색 계열 (돌아가기) */
		}
		.back-btn:hover {
		  background-color: #5a6268;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="form-container">
  <h2 class="page-title">객실 이미지 수정</h2>
  <form name="roomForm" method="post" onsubmit="return fCheck();" enctype="multipart/form-data">
    <input type="hidden" name="idx" value="${vo.idx}" />
    <input type="hidden" name="oThumbnail" value="${vo.thumbnail}" />
    <input type="hidden" name="hotelIdx" value="${vo.hotelIdx}" />
    <input type="hidden" name="images" value="${vo.images}" />

    <div class="form-group">
      <label for="thumbnail" class="form-label">썸네일 이미지</label>
      <input type="file" name="thumbnailFile" id="thumbnailFile" onchange="thumbnailCheck(this)" class="form-control" accept=".jpg,.gif,.png,.jpeg,.webp"/>
    </div>

    <div class="form-group">
      <label class="form-label">썸네일 미리보기</label>
      <img id="beforeThumbnailPreview" src="${ctp}/roomThumbnail/${vo.thumbnail}" width="300px" />
      <img id="thumbnailPreview" width="300px" style="display:none">
    </div>

    <c:if test="${!empty vo.images}">
      <div class="form-group">
        <label class="form-label">기존 등록 이미지</label>
        <div class="image-gallery">
          <c:set var="imageFileNames" value="${fn:split(vo.images, '/')}" />
          <c:forEach var="imageFileName" items="${imageFileNames}" varStatus="st">
            <div class="image-card">
              <img src="${ctp}/roomImages/${imageFileName}" class="preview-img" />
              <button type="button" class="btn-custom-delete small" onclick="imageFileDelete('${imageFileName}')">삭제</button>
            </div>
          </c:forEach>
        </div>
      </div>
    </c:if>

    <c:if test="${empty vo.images}">
      <div class="form-label">썸네일 외 등록된 이미지가 없습니다.</div>
    </c:if>
    <c:if test="${!empty vo.images}">
    	<div class="text-center"><button type="button" class="btn-custom-delete" onclick="imageFilesDeleteAll()">이미지 전체 삭제</button></div>
    </c:if>
    
    

    <div class="form-group">
      <label for="images" class="form-label">객실 이미지 추가 (여러 장 가능)</label>
      <small class="form-text text-muted">※ 권장 이미지 비율: 16:9 (예: 1600x900px)</small>
      <input type="file" name="imageFiles" id="imageFiles" class="form-control" accept=".jpg,.gif,.png,.jpeg,.webp" multiple />
    </div>

    <div class="form-group text-center">
      <input type="submit" value="수정하기" class="custom-btn submit-btn" />
      <input type="reset" value="다시입력" class="custom-btn reset-btn" onclick="location.reload()">
      <a href="${ctp}/room/roomDetail?roomIdx=${vo.idx}" class="custom-btn back-btn">돌아가기</a>
    </div>
  </form>
</div>

</body>
</html>