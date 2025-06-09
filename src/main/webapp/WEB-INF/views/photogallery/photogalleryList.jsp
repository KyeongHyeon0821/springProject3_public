<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>포토갤러리</title>
  <script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>
  <!-- <script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script> -->
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
      padding: 30px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
    }

    th {
      background-color: #e0f5e9;
      padding: 12px;
      text-align: center;
      color: #444;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
    }

    td {
      background-color: #fff;
      padding: 14px 12px;
      text-align: center;
      border-bottom: 1px solid #e5e5e5;
    }

    td a {
      text-decoration: none;
      font-weight: 500;
    }

    td a:hover {
      color: #4caf50;
      text-decoration: none;
    }

    .badge {
      display: inline-block;
      padding: 4px 10px;
      font-size: 0.9rem;
      font-weight: 500;
      border-radius: 10px;
      color: white;
    }

    .badge-success {
      background-color: #388e3c;
    }

    .badge-warning {
      background-color: #f9a825;
    }

    .pagination .page-link {
      color: #2e7d32;
      border-color: #2e7d32;
    }

    .pagination .active .page-link {
      background-color: #2e7d32;
      border-color: #2e7d32;
    }

    .no-data {
      text-align: center;
      padding: 30px 0;
      color: #888;
    }
    
    
    /* 포토갤러리 */
		div.gallery {
		  border: 1px solid #ccc;
		}
		
		div.gallery:hover {
		  border: 1px solid #777;
		}
		
		div.gallery img {
		  width: 100%;
		  height: auto;
		}
		
		div.desc {
		  padding: 15px;
		  text-align: center;
		}
		
		* {
		  box-sizing: border-box;
		}
		
		.responsive {
		  padding: 0 6px;
		  float: left;
		  width: 24.99999%;
		}
		
		@media only screen and (max-width: 700px) {
		  .responsive {
		    width: 49.99999%;
		    margin: 6px 0;
		  }
		}
		
		@media only screen and (max-width: 500px) {
		  .responsive {
		    width: 100%;
		  }
		}
		
		.clearfix:after {
		  content: "";
		  display: table;
		  clear: both;
		}
  </style>
  <script>
    'use strict';
    
    function pageSizeCheck() {
        let pageSize = document.getElementById("pageSize").value;
        location.href = "photogalleryList?pag=1&pageSize=" + pageSize;
      }
    
    function partCheck() {
    	  const part = document.getElementById("part").value;
    	  location.href = 'photogalleryList?part=' + part;
    	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">포토갤러리</span>
	</div>
  <div class="section-box">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div>
				<select name="part" id="part" onchange="partCheck()" class="form-select">
				  <option ${pageVo.part == '최신순' ? 'selected' : ''}>최신순</option>
				  <option ${pageVo.part == '조회수순' ? 'selected' : ''}>조회수순</option>
				  <option ${pageVo.part == '좋아요순' ? 'selected' : ''}>좋아요순</option>
				</select>
      </div>
      <div>
        <c:if test="${sLevel != 0}">
          <button class="btn btn-outline-info" onclick="location.href='${ctp}/photogallery/photogallerySingleAll';">전체보기</button>
          <button class="btn btn-outline-success" onclick="location.href='${ctp}/photogallery/photogalleryInput';">작성하기</button>
        </c:if>
      </div>
    </div>
    <%-- 
    <table>
      <thead>
        <tr>
          <th class="text-center">번호</th>
          <th class="text-center">장소</th>
          <th class="text-center">제목</th>
          <th class="text-center">작성날짜</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="vo" items="${vos}">
          <tr style="border-bottom: 1px solid #e5e5e5;">
          	<td>${vo.idx}</td>
            <td>${vo.part}</td>
            <td><a href="${ctp}/photogallery/photogalleryDetail?idx=${vo.idx}">${vo.title}</a></td>
            <td>${vo.WDate.substring(0,16)}</td>
          </tr>
        </c:forEach>
        <c:if test="${empty vos}">
          <tr>
            <td colspan="5" class="no-data">등록된 글이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  --%>
    <c:set var="no" value="0"/>
    <c:forEach var="i" begin="0" end="1"  varStatus="st">
	    <c:forEach var="j" begin="0" end="3"  varStatus="st">
	      <c:if test="${!empty vos[no].thumbnail}">
					<div class="responsive mb-5">
					  <div class="gallery">
					    <a href="${ctp}/photogallery/photogalleryDetail?idx=${vos[no].idx}">
					      <img src="${vos[no].thumbnail}" alt="${vo.title}">
					    </a>
					    <div class="row mt-2 mb-2">
					    	<div class="col ms-2"><i class="fa-regular fa-eye" title="조회수"></i> ${vos[no].readNum}</div>
					    	<div class="col text-center">
					    	  <c:if test="${fn:length(vos[no].part) > 5}"><c:set var="part" value="${fn:substring(vos[no].part,0,5)}.."/></c:if>
					    	  <c:if test="${fn:length(vos[no].part) <= 5}"><c:set var="part" value="${vos[no].part}"/></c:if>
					    	  ${part}
					    	</div>
					    	<div class="col me-3 text-end"><i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vos[no].good}</div>
					    </div>
					  </div>
					</div>
					<c:set var="no" value="${no + 1}"/>
				</c:if>
			</c:forEach>
		</c:forEach>
		
		<div class="clearfix"></div>
  
<!-- 블록페이지 시작 -->
		<div class="text-center mt-4">
		  <ul class="pagination justify-content-center">
		    <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link" href="photogalleryList?part=${pageVo.part}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
		  	<c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link" href="photogalleryList?part=${pageVo.part}&pag=${(curBlock-1)*blockSize+1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
		  	<c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize)+pageVo.blockSize}" varStatus="st">
			    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link" href="photogalleryList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
			    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link" href="photogalleryList?part=${pageVo.part}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		  	</c:forEach>
		  	<c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link" href="photogalleryList?part=${pageVo.part}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
		  	<c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link" href="photogalleryList?part=${pageVo.part}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
		  </ul>
		</div>
<!-- 블록페이지 끝 -->

  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
