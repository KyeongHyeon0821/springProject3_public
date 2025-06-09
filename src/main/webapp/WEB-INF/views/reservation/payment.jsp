<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>위드펫 - 결제</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
	<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
	<script>
		IMP.init("imp번호");
	
		IMP.request_pay(
		  {
			  pg : "html5_inicis.INIpayTest",
		    pay_method: "card",
		    name: "${hotelVo.name}",
		    amount: "${vo.totalPrice}",
		    buyer_email: "${vo.email}",
		    buyer_name: "${vo.name}",
		    buyer_tel: "${vo.tel}",
		  },
		  function (res) {
			  if (res.success) {
				  Swal.fire({
				    icon: 'success',
				    title: "결제가 완료되었습니다.",
				    confirmButtonText: '확인'
				  }).then(() => {
				    location.href = "${ctp}/reservation/paymentOk";
				  });
				} else {
				  Swal.fire({
				    icon: 'warning',
				    title: "결제가 취소되었습니다.",
				    text: "마이페이지에서 다시 결제를 진행해 주세요.",
				    confirmButtonText: '확인'
				  }).then(() => {
				    location.href = "${ctp}/member/memberMyPage";
				  });
				}
		  },
		);
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
	<p class="text-center">
		<img src="${ctp}/images/payment.gif" />
	</p>
</div>
</body>
</html>