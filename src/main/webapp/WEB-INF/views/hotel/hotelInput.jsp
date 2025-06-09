<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위드펫 - 호텔등록</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<jsp:include page="/WEB-INF/views/include/mapCss.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<script>
		'use strict';
		
		
		// 호텔 등록 처리
		function fCheck() {
			let x = $("#x").val();
			console.log(x);
			
			// 유효성 체크
			let name = $("#name").val().trim();
			let address = $("#address").val().trim();
			let tel = $("#tel").val().trim();
			let thumbnailFile = $("#thumbnailFile").val(); // 썸네일 파일 이름
			let regTel = /^\d{2,4}-\d{3,4}-\d{4}$/; // 연락처 정규식 (2~4)-(3~4)-(4)
			
			if(name == "") {
				alert("호텔 이름을 입력해주세요.");
				$("#name").focus();
				return false;
			}
			else if (name.length > 100) {
	      alert("호텔 이름은 100자 이내로 입력해주세요.");
	      $("#name").focus();
	      return false;
	    }
			
			if (address == "") {
	      alert("호텔 주소를 입력해주세요.");
	      $("#address").focus();
	      return false;
	    } 
			else if (address.length > 200) {
	      alert("호텔 주소는 200자 이내로 입력해주세요.");
	      $("#address").focus();
	      return false;
	    }
			
			if(thumbnailFile == "") {
				alert("업로드할 썸네일 파일을 선택하세요");
				$("#thumbnailFile").focus();
				return false;
			}
			
			if(tel != "" && !regTel.test(tel)) {
				alert("전화번호 형식이 올바르지 않습니다.\n예: 02-123-4567, 010-1234-5678, 0505-123-4567");
			  $("#tel").focus();
			  return false;
			}
			else if (tel.length > 20) {
	      alert("호텔 연락처는 20자 이내로 입력해주세요.");
	      $("#tel").focus();
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
			
			// 모든 조건 통과시
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
	    max-width: 1000px;
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
  <h2>호텔 등록</h2>
	<hr class="border-secondary">
	
	<div class="text-muted" style="margin-bottom:5px;">
  	※ 검색 결과 또는 마커를 클릭하면 일부 데이터가 자동으로 입력됩니다.
  </div>
  <div class="map_wrap" style="margin-bottom:10px;">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div id="menu_wrap" class="bg_white">
      <div class="option">
        <div>
          <form onsubmit="searchPlaces(); return false;">
            키워드 : <input type="text" value="반려견 동반 호텔" id="keyword" size="15"> 
            <button type="submit">검색하기</button> 
          </form>
        </div>
      </div>
      <hr>
      <ul id="placesList"></ul>
      <div id="pagination"></div>
    </div>
  </div>

  <form name="hotelForm" method="post" onsubmit="return fCheck();" enctype="multipart/form-data">
    <div class="form-group">
      <label for="name">호텔 이름</label>
      <input type="text" name="name" id="name" placeholder="호텔 이름" required autofocus>
    </div>

    <div class="form-group">
      <label for="address">호텔 주소</label>
      <input type="text" name="address" id="address" placeholder="호텔 주소" required>
    </div>

    <div class="form-group">
      <label for="tel">호텔 연락처</label>
      <input type="tel" name="tel" id="tel" placeholder="호텔 연락처">
    </div>

    <div class="form-group">
      <label for="description">호텔 소개</label>
      <textarea rows="6" name="description" id="description" placeholder="호텔 소개"></textarea>
    </div>

    <div class="form-group">
      <label for="thumbnailFile">대표 사진(썸네일)</label>
      <input type="file" name="thumbnailFile" id="thumbnailFile" onchange="thumbnailCheck(this)" required accept=".jpg,.gif,.png,.jpeg,.webp">
    </div>

    <div class="form-group">
		  <label>썸네일 미리보기</label>
		  <div class="thumbnail-frame">
		    <span class="placeholder-text" id="placeholderText">미리보기 이미지 없음</span>
		  </div>
  	  <img id="thumbnailPreview" width="300px" style="display: none;" />
		</div>

    <div class="form-group">
      <label for="images">사진 등록</label>
      <div class="text-muted" style="margin-bottom:5px;">
        ※ 사진만 등록 가능합니다. 여러 장의 이미지는 마우스로 드래그하여 추가할 수 있습니다.<br>
        ※ 권장 이미지 비율: 16:9 (예: 1600x900px)
      </div>
      <textarea rows="6" name="images" id="images"></textarea>
      <script>
        CKEDITOR.replace("images",{
          height:450,
          filebrowserUploadUrl:"hotelImageUpload?mid=${sMid}",
          uploadUrl:"hotelImageUpload?mid=${sMid}"
        });
      </script>
    </div>

    <div class="form-group text-center">
      <input type="submit" value="등록하기" class="custom-btn submit-btn">
      <input type="button" value="다시입력" class="custom-btn reset-btn" onclick="location.reload()">
      <input type="button" value="돌아가기" onclick="location.href='${ctp}/';" class="custom-btn back-btn">
    </div>

    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" id="x" name="x">
    <input type="hidden" id="y" name="y">
  </form>
</div>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=앱키&libraries=services"></script>
<jsp:include page="/WEB-INF/views/include/mapJs.jsp"/>
</body>
</html>