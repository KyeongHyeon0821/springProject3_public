<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위드펫 - 객실등록</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<script>
		'use strict';
		
		// 객실 등록 처리
		function fCheck() {
			// 유효성 체크
			let name = $("#name").val().trim();
			let roomNumber = $("#roomNumber").val().trim();
			let price = $("#price").val().trim();
			let petSizeLimit = $("#petSizeLimit").val().trim();
			let thumbnailFile = $("#thumbnailFile").val(); // 썸네일 파일 이름
			
			if(name == "") {
				alert("객실 타입을 입력해주세요.");
				$("#name").focus();
				return false;
			}
			else if (name.length > 50) {
	      alert("객실 타입은 50자 이내로 입력해주세요.");
	      $("#name").focus();
	      return false;
	    }
			
			if (roomNumber.length > 20) {
	      alert("객실 이름은 20자 이내로 입력해주세요.");
	      $("#roomNumber").focus();
	      return false;
	    }
			
			if(price == "") {
				alert("객실 요금을 입력해주세요.");
				$("#price").focus();
				return false;
			}
			
			if(petSizeLimit == "") {
				alert("반려견 크기 제한을 선택해주세요.");
				$("#petSizeLimit").focus();
				return false;
			}
			
			if(thumbnailFile == "") {
				alert("업로드할 썸네일 파일을 선택하세요");
				$("#thumbnailFile").focus();
				return false;
			}
			
			// 썸네일 파일 용량 체크, 확장자 체크
			let ext = thumbnailFile.substring(thumbnailFile.lastIndexOf(".")+1).toLowerCase();
			let maxSize = 1024 * 1024 * 20; // 한번에 업로드할 파일의 최대용랑을 20mb로 한정
			let fileSize = document.getElementById("thumbnailFile").files[0].size;
			
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
	    $("#thumbnailPreview").show();
	    $(".thumbnail-frame").hide();
	  }
	</script>
	<style>
	  body {
	    background-color: #f9fefb;
	  }
	
	  .form-container {
	    max-width: 800px;
	    margin: 50px auto;
	    padding: 30px;
	    background-color: #fff;
	    border: 1px solid #cde6da;
	    border-radius: 15px;
	    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
	  }
	
	  .form-container h2 {
	    text-align: center;
	    color: #2e7d32;
	    margin-bottom: 25px;
	    font-weight: bold;
	  }
	
	  .form-group {
	    margin-bottom: 20px;
	  }
	
	  .form-group label {
	    display: block;
	    font-weight: bold;
	    color: #2e7d32;
	    margin-bottom: 5px;
	  }
	
	  .form-group input[type="text"],
	  .form-group input[type="tel"],
	  .form-group input[type="file"],
	  .form-group input[type="number"],
	  .form-group select,
	  .form-group textarea {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #cde6da;
	    border-radius: 6px;
	    box-sizing: border-box;
	  }
	
	  .form-group textarea {
	    resize: vertical;
	  }
	
	  .form-group img {
	    display: block;
	    margin-top: 10px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	  }
	
	  .form-group.text-center {
	    text-align: center;
	  }
	
	  .form-group.text-center .btn-secondary {
	    background-color: #b0bec5;
	    color: #fff;
	    padding: 10px 20px;
	    font-weight: bold;
	    border-radius: 6px;
	    text-decoration: none;
	  }
	
	  .form-group.text-center .btn-secondary:hover {
	    background-color: #90a4ae;
	  }
	  .option-list {
		  display: flex;
		  flex-wrap: wrap;
		  gap: 10px 20px;
		}
		
		.option-item {
		  display: flex;
		  align-items: center;
		  margin-bottom: 5px;
		}
		
		.option-item input[type="checkbox"] {
		  margin-right: 5px;
		}
		}
		.form-text.text-muted {
		  display: block;
		  margin-top: 4px;
		  margin-bottom: 6px;
		  font-size: 0.9em;
		  color: #6c757d;
		}
		.thumbnail-frame {
		  width: 100%;
		  max-width: 300px;
		  height: 170px; /* 16:9 비율에 맞게 (300 x 170) */
		  border: 1px dashed #ccc;
		  border-radius: 8px;
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  background-color: #f8f9fa;
		  position: relative;
		  overflow: hidden;
		}
		.thumbnail-frame img {
		  max-width: 100%;
		  max-height: 100%;
		  display: block;
		  object-fit: cover;
		}
		.placeholder-text {
		  color: #999;
		  font-size: 0.9em;
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
  <h2>객실 등록</h2>
  <form name="roomForm" method="post" onsubmit="return fCheck();" enctype="multipart/form-data">
    <input type="hidden" name="hotelIdx" value="${hotelIdx}" />
    <input type="hidden" name="mid" value="${sMid}" />

    <div class="form-group">
      <label for="hotelName">호텔명</label>
      <input type="text" value="${vo.name}" name="hotelName" id="hotelName" class="form-control" readonly />
    </div>

    <div class="form-group">
      <label for="name">객실 타입</label>
      <input type="text" name="name" id="name" class="form-control" required />
    </div>

    <div class="form-group">
      <label for="roomNumber">객실 이름(번호)</label>
      <input type="text" name="roomNumber" id="roomNumber" class="form-control"/>
    </div>

    <div class="form-group">
      <label for="price">1박 요금</label>
      <input type="number" name="price" id="price" class="form-control" required />
    </div>

    <div class="form-group">
      <label for="maxPeople">최대 인원 수</label>
      <select name="maxPeople" id="maxPeople" class="form-control" required>
        <option value="1">1</option>
        <option value="2" selected>2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10</option>
      </select>
    </div>

    <div class="form-group">
      <label for="petSizeLimit">반려견 크기 제한</label>
      <select name="petSizeLimit" id="petSizeLimit" class="form-control" required>
        <option value="">선택 안 함</option>
        <option value="소형">소형견만 가능</option>
        <option value="중형">중형견까지 가능</option>
        <option value="대형">대형견까지 가능 (모두 가능)</option>
      </select>
    </div>

    <div class="form-group">
      <label for="petCountLimit">최대 반려견 수</label>
      <select name="petCountLimit" id="petCountLimit" class="form-control" required>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
      </select>
    </div>

    <div class="form-group">
		  <label for="thumbnailFile">썸네일 이미지</label>
		  <small class="form-text text-muted">※ 권장 이미지 비율: 16:9 (예: 1600x900px)</small>
		  <input type="file" name="thumbnailFile" id="thumbnailFile" onchange="thumbnailCheck(this)" class="form-control" accept=".jpg,.gif,.png,.jpeg,.webp" required />
		</div>

    <div class="form-group">
		  <label>썸네일 미리보기</label>
		  <div class="thumbnail-frame">
		    <span class="placeholder-text" id="placeholderText">미리보기 이미지 없음</span>
		  </div>
  	  <img id="thumbnailPreview" width="300px" style="display: none;" />
		</div>

    <div class="form-group">
		  <label for="imageFiles">객실 이미지 (여러 장 가능)</label>
		  <small class="form-text text-muted">※ 권장 이미지 비율: 16:9 (예: 1600x900px)</small>
		  <input type="file" name="imageFiles" id="imageFiles" class="form-control" accept=".jpg,.gif,.png,.jpeg,.webp" multiple />
		</div>

    <div class="form-group">
		  <label>객실 옵션</label>
		  <div class="option-list">
		    <c:forEach var="option" items="${optionList}">
		      <div class="option-item">
		        <input type="checkbox" name="options" value="${option.idx}" id="option${option.idx}" />
		        <label for="option${option.idx}">${option.name}</label>
		      </div>
		    </c:forEach>
		  </div>
		</div>

    <div class="form-group text-center">
      <input type="submit" value="등록하기" class="custom-btn submit-btn" />
      <input type="reset" value="다시입력" class="custom-btn reset-btn" onclick="location.reload()">
      <a href="${ctp}/hotel/hotelDetail?idx=${hotelIdx}"  class="custom-btn back-btn">돌아가기</a>
    </div>
  </form>
</div>

</body>
</html>