<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>위드펫 - 내 쿠폰</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
		.coupon-container {
		  max-width: 1000px;
		  margin: 0 auto;
		  padding: 40px 20px;
		  background-color: #f9fdf9;
		  border-radius: 12px;
		  box-shadow: 0 0 10px rgba(0,0,0,0.05);
		}
		
		.coupon-table th {
		  background-color: #d4ecd4;
		  color: #2e5939;
		  font-weight: 600;
		}
		
		.coupon-table td {
		  vertical-align: middle;
		}
		
		.coupon-form {
		  margin-top: 40px;
		  padding: 20px;
		  background-color: #f0fbf0;
		  border: 1px solid #cbe8cb;
		  border-radius: 10px;
		}
		
		.coupon-info-text {
		  font-size: 0.95rem;
		  color: #3b7b3b;
		  font-weight: 500;
		}
		
		.coupon-input-group .input-group-text {
		  background-color: #e0f5e0;
		  color: #2e5939;
		  font-weight: 500;
		  min-width: 100px;
		}
		
		.coupon-input-group select,
		.coupon-input-group input[type="text"] {
		  border-radius: 0 4px 4px 0;
		  border-color: #b8dfb8;
		}
		
		.btn-success {
		  background-color: #62a062;
		  border-color: #62a062;
		  color: #fff;
		}
		
		.btn-success:hover {
		  background-color: #4d854d;
		  border-color: #4d854d;
		}
		
		#demo {
		  margin-top: 15px;
		  font-weight: bold;
		  color: #3a773a;
		}
		
		.qr-btn {
		  background-color: #88c788;
		  border-color: #88c788;
		  color: #fff;
		}
		
		.qr-btn:hover {
		  background-color: #6fb56f;
		  border-color: #6fb56f;
		}
		
	  .modal-backdrop.show {
	    opacity: 0.2 !important; 
	  }
	

  </style>
  <script>
    'use strict';
    
    function fCheck() {
    	let coupon = $("#coupon").val();
    	let email = $("#email").val();
    	if(coupon == "") {
    		alert("발행할 쿠폰을 선택하세요");
    		return false;
    	}
    	else {
    		
    		let idx = coupon.split("/")[0];
    		let couponCode = coupon.split("/")[1];
    		
    		$.ajax({
    			url : "isCouponAlreadyIssued",
    			type : "post",
    			data : { couponCode : couponCode},
    			success : function(res) {
    				if(res != "0") {
    					Swal.fire({
				        icon: 'warning',
				        title: '이미 발급받은 쿠폰입니다.',
				        confirmButtonText: '확인'
				      })
    					return false;
    				}
    				else {
    					$("#demo").show();
    			    	
  		    		let str = '<div class="spinner-border"></div> 쿠폰 발행중입니다. <div class="spinner-border"></div>';
  		    		$("#demo").html(str);
  		    		let ans = confirm("쿠폰을 발급받으시겠습니까?");
  		    		
  		    		if(!ans) {
  			    		$("#demo").html("");
  		    			return false;
  		    		}
  		    		
  		    		$.ajax({
  		    			url  : "couponIssue",
  		    			type : "post",
  		    			data : {
  		    				idx : idx,
  		    				couponCode : couponCode,
  		    				mid : '${sMid}',
  		    				email : '${email}'
  		    			},
  		    			success:function(res) {
  		    				if(res != "0") {
  		    					Swal.fire({
	    				        icon: 'success',
	    				        title: '쿠폰이 발송되었습니다.\n메일을 확인하세요',
	    				        confirmButtonText: '확인'
	    				      })
  		    					$("#demo").html("쿠폰이 발송된 메일주소 : ${email}");
  		    				}
  		    				else {
  		    					alert("쿠폰 발송 실패~");
  		    					$("#demo").hide();
  		    				}
  		    			}
  		    		});
    					
    				}
    			}
    		});
    		
    	}
    }
    
    // QR코드 모달로 보기
    function qrCodeView(couponQrcode) {
			$(".modal-body #imgSrc").attr("src","${ctp}/resources/data/couponQrcode/"+couponQrcode);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="coupon-container">
  <h2 class="text-center">내 쿠폰</h2>
  <c:if test="${fn:length(uVos) == 0}">
    <div class="text-center">아직 발급받은 쿠폰이 없습니다.</div>
  </c:if>
  <c:if test="${fn:length(uVos) != 0}">
    <div>
      <table class="table table-hover text-center coupon-table">
        <tr class="table-secondary">
          <th>번호</th>
          <th>쿠폰번호</th>
          <th>발급 메일주소</th>
          <th>쿠폰 발급일자</th>
          <th>쿠폰사용여부</th>
          <th>쿠폰사용날짜</th>
          <th>QR코드</th>
        </tr>
        <c:forEach var="vo" items="${uVos}" varStatus="st">
          <tr>
            <td>${st.count}</td>
            <td><a href="couponContent/${vo.idx}">${vo.userCouponCode}</a></td>
            <td>${vo.email}</td>
            <td>${fn:substring(vo.userIssueDate,0,16)}</td>
            <td>
              <c:if test="${vo.isUse == '미사용'}"><span class="badge bg-success">${vo.isUse}</span></c:if>
              <c:if test="${vo.isUse != '미사용'}"><span class="badge bg-warning">${vo.isUse}</span></c:if>
            </td>
            <td>
              <c:if test="${vo.isUse == '미사용'}"><span class="badge bg-info">미사용</span></c:if>
              <c:if test="${vo.isUse != '미사용'}">${fn:substring(vo.usedDate,0,16)}</c:if>
            </td>
            <td>
              <a href="#" onclick="qrCodeView('${vo.couponQrcode}')" class="btn btn-primary btn-sm qr-btn" data-bs-toggle="modal" data-bs-target="#myCouponModal">상세보기</a>
            </td>
          </tr>
        </c:forEach>
      </table>
    </div>
  </c:if>
  
  <h2 class="text-center mt-5">쿠폰 발급받기</h2>
  <form name="couponForm" method="post" class="coupon-form">
    <div>
      <div class="coupon-info-text mb-1">※ 쿠폰 QR코드를 메일로 보내드립니다.</div>
      <div class="input-group mb-3 coupon-input-group">
        <div class="input-group-text bg-secondary-subtle">메일주소</div>
        <input type="text" name="email" id="email" value="${email}" class="form-control"/>
      </div>
      <div class="input-group coupon-input-group">
        <div class="input-group-text bg-secondary-subtle">발급 가능 쿠폰</div>
        <select name="coupon" id="coupon" class="form-control">
          <option value="">쿠폰을 선택하세요</option>
          <c:forEach var="vo" items="${couponVos}" varStatus="st">
            <option value="${vo.idx}/${vo.couponCode}">${vo.couponName}</option>
          </c:forEach>
        </select>
        <input type="button" value="쿠폰발행" onclick="fCheck()" class="btn btn-success"/>
      </div>
      <div id="demo" style="display:none" class="text-center"></div>
    </div>
  </form>
</div>
<p><br/></p>

<!-- The Modal -->
<div class="modal fade" id="myCouponModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-sm">
      <!-- Modal Header -->
      <div class="modal-header">
        <h5><span id="title"></span>발행된 QR코드</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
        <img id="imgSrc"/><br/>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>