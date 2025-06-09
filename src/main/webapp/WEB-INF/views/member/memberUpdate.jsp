<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
	'use strict';
	
	let nickCheckSw = 0;
	let emailCheckSw = 0;
	let originalEmail = "${vo.email}";
	
	let regNickName = /^[가-힣a-zA-Z0-9_]{2,}$/;
	let regName = /^[가-힣a-zA-Z]+$/;
	let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
	let regBizNo = /^\d{10}$/;
	
	function toggleBizForm(isBiz) {
	  document.getElementById('bizRow1').style.display = isBiz ? '' : 'none';
	}
	
	// 닉네임 중복 체크
	function nickCheck() {
	  let nickName = myform.nickName.value;
	  if (nickName.trim() === "") {
	    alert("닉네임을 입력하세요");
	    myform.nickName.focus();
	  } else {
	    $.ajax({
	      url: "${ctp}/member/memberNickCheck",
	      type: "get",
	      data: { nickName: nickName },
	      success: function(res) {
	        if (res !== '0') {
	          alert("이미 사용중인 닉네임입니다. 다시 입력하세요");
	          myform.nickName.focus();
	        } else {
	          alert("사용 가능한 닉네임입니다.");
	          nickCheckSw = 1;
	          myform.nickName.readOnly = true;
	        }
	      },
	      error: function() {
	        alert("전송 실패하였습니다.");
	      }
	    });
	  }
	}
	
	// 이메일 인증 요청
	function emailCertification() {
	  let email = myform.email1.value.trim() + '@' + myform.email2.value.trim();
	  if (email !== originalEmail) {
		  emailCheckSw = 0;
	  }
	  if (!regEmail.test(email)) {
	    alert("이메일 형식이 올바르지 않습니다.");
	    return;
	  }
	  
	  $("#spinner").show();
	  $("#demo").empty();
	
	  $.ajax({
	    url: "${ctp}/member/memberEmailCheck",
	    type: "post",
	    data: { email: email },
	    success: function(res) {
	      $("#spinner").hide();
	      
	      if (res !== '0') {
	        alert("인증번호가 발송되었습니다. 메일을 확인해주세요.");
	        let str = '<div class="input-group">';
	        str += '<input type="text" name="checkKey" id="checkKey" class="form-control"/>';
	        str += '<button type="button" onclick="emailCeritificationOk()" class="btn btn-primary btn-sm rounded">인증번호확인</button>';
	        str += '</div>';
	        $("#demo").html(str);
	      } else {
	        alert("전송 실패하였습니다. 이메일을 다시 확인해주세요.");
	      }
	    },
	    error: function() {
	      $("#spinner").hide();
	      alert("전송 실패하였습니다.");
	    }
	  });
	}
	
	function emailCeritificationOk() {
	  let checkKey = $("#checkKey").val();
	  if (checkKey.trim() === "") {
	    alert("인증번호를 입력해주세요.");
	    return;
	  }
	
	  $.ajax({
	    url: "${ctp}/member/memberEmailCheckOk",
	    type: "post",
	    data: { checkKey: checkKey },
	    success: function(res) {
	      if (res !== "0") {
	    	alert("이메일 인증이 완료되었습니다.");
	    	emailCheckSw = 1;
	        $("#certificationBtn").hide();
	        $("#addContent").show();
	        $("#addBtn").show();
	        $("#viewCheckBtn").show();
	      } else {
	        alert("인증번호가 일치하지 않습니다.");
	      }
	    },
	    error: function() {
	      alert("인증번호 확인 실패");
	    }
	  });
	}

	// 최종 유효성 검사 및 전송
	function fCheck() {
	  let nickName = myform.nickName.value.trim();
	  let name = myform.name.value.trim();
	
	  let email1 = myform.email1.value.trim();
	  let email2 = myform.email2.value.trim();
	  let email = email1 + "@" + email2;
	
	  let tel1 = myform.tel1.value.trim();
	  let tel2 = myform.tel2.value.trim();
	  let tel3 = myform.tel3.value.trim();
	  let tel = tel1 + "-" + tel2 + "-" + tel3;
	
	  let postcode = myform.postcode.value + " ";
	  let roadAddress = myform.roadAddress.value + " ";
	  let detailAddress = myform.detailAddress.value + " ";
	  let extraAddress = myform.extraAddress.value + " ";
	  let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
	  let level = document.querySelector('input[name="level"]:checked').value;
	  
	  // 입력 여부 확인
	  if (nickCheckSw === 0 && nickName !== "${sNickName}") {
		 alert("닉네임 중복체크를 해주세요.");
		 document.getElementById("nickNameBtn").focus();
		 return;
	  }
	  if (emailCheckSw === 0 && email !== originalEmail) {
		 alert("이메일 인증을 완료해주세요.");
		 document.getElementById("certificationBtn").focus();
		 return;
	  }
	  myform.email.value = email;
	  myform.tel.value = tel;
	  myform.address.value = address;
	  myform.submit();
	}
	
	window.onload = function() {
		  const levelRadios = document.querySelectorAll('input[name="level"]');
		  levelRadios.forEach(radio => {
		    if (radio.checked && radio.value === "1") {
		      toggleBizForm(true);
		    }
		  });
		};
</script>

  <style>
    .join-container {
      max-width: 800px;
      margin: 30px auto;
      border: 1px solid #e3e3e3;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      background-color: #fff;
    }
    .join-container h3 {
      font-weight: bold;
      margin-bottom: 20px;
      text-align: center;
    }
    .join-table {
      border: none;
      width: 100%;
    }
    .join-table th,
    .join-table td {
      vertical-align: middle !important;
      border-top: none !important;
      border-bottom: 1px solid #f0f0f0;
      padding: 0.75rem 1rem;
    }
    .join-table th {
      width: 140px;
      text-align: center;
      font-weight: bold;
      background-color: #fafafa;
      color: #000;
    }
    .join-table input[type="text"],
    .join-table input[type="password"],
    .join-table select {
      border: 1px solid #d4d4d4;
      border-radius: 4px;
    }
    .btn-sm {
      padding: 6px 12px !important;
      font-size: 0.875rem !important;
    }
    .btn-info {
      background-color: #03c75a;
      border: none;
    }
    .btn-info:hover {
      background-color: #02b757;
    }
    .btn-secondary {
      background-color: #ebebeb;
      color: #333;
      border: 1px solid #ccc;
    }
    .btn-secondary:hover {
      background-color: #ddd;
    }
    .btn-green {
	  background-color: #02b757 !important;
	  color: white !important;
	  border: 1px solid #02b757 !important;
	  border-radius: 4px !important;
	  padding: 8px 16px !important;
	  font-weight: bold !important;
	  display: inline-block !important;
	}
	.btn-green:hover {
	  background-color: #009345;
	}
    #demo {
      margin-bottom: 1rem;
    }
    .text-start {
      text-align: left !important;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
	<h3 class="text-center mb-4">
  	  <img src="${ctp}/images/logo.png" width="150px"/><br/>
  	  <span style="color: #2e7d32; font-weight: bold;">회 원 정 보 수 정</span>
	</h3>
	<div class="join-container">
  <form name="myform" method="post" enctype="multipart/form-data">
    <table class="join-table">
      <tr>
		<th class="bg-secondary-subtle">회원유형</th>
		<td>
		  <input type="radio" name="level" value="2" ${vo.level == 2 ? 'checked' : ''} disabled> 일반회원 &nbsp;
		  <input type="radio" name="level" value="1" ${vo.level == 1 ? 'checked' : ''} disabled> 사업자회원
		  <input type="hidden" name="level" value="${vo.level}" />
		</td>
	  </tr>
      <tr>
		 <th class="bg-secondary-subtle">아이디</th>
		 <td style="padding-top: 0.9rem;">
		   <span style="padding-left: 6px;">${vo.mid}</span>
		   <input type="hidden" name="mid" value="${vo.mid}" />
		 </td>
	  </tr>
      <tr>
        <th class="bg-secondary-subtle">닉네임</th>
        <td>
          <div class="input-group">
            <input type="text" name="nickName" id="nickName" value="${sNickName}" required class="form-control" />
            <button type="button" id="nickNameBtn" onclick="nickCheck()" class="btn btn-secondary btn-sm ms-2 rounded">닉네임중복체크</button>
          </div>
        </td>
      </tr>
      <tr>
	    <th class="bg-secondary-subtle">성명</th>
	    <td style="padding-top: 0.9rem;">
	      <span style="padding-left: 6px;">${vo.name}</span>
	      <input type="hidden" name="name" value="${vo.name}" />
	    </td>
	  </tr>
      <c:if test="${sessionScope.sLogin ne 'kakao'}">
		<tr>
		  <th class="bg-secondary-subtle">성별</th>
		  <td style="padding-top: 0.9rem;">
		    <span style="padding-left: 6px;">${vo.gender}</span>
		    <input type="hidden" name="gender" value="${vo.gender}" />
		  </td>
		</tr>
	  </c:if>

      <tr>
        <th class="bg-secondary-subtle">이메일</th>
        <td>
          <div class="input-group">
            <c:set var="email" value="${fn:split(vo.email, '@')}"/>
	          <input type="text" name="email1" id="email1" value="${email[0]}" class="form-control" required />@
	          <select name="email2" id="email2" class="form-select">
	          	<option ${email[1]=='naver.com'   ? 'selected' : ''}>naver.com</option>
	          	<option ${email[1]=='hanmail.net' ? 'selected' : ''}>hanmail.net</option>
	          	<option ${email[1]=='gmail.com'   ? 'selected' : ''}>gmail.com</option>
	          	<option ${email[1]=='daum.net'    ? 'selected' : ''}>daum.net</option>
	          	<option ${email[1]=='yahoo.com'   ? 'selected' : ''}>yahoo.com</option>
	          	<option ${email[1]=='hatmail.com' ? 'selected' : ''}>hatmail.com</option>
	          	<option ${email[1]=='nate.com'    ? 'selected' : ''}>nate.com</option>
	          </select>
	          <button type="button" onclick="emailCertification()" id="certificationBtn" class="btn btn-success btn-sm ms-2 rounded">인증번호받기</button>
			  <div id="spinner" class="ms-2" style="display: none;">
				<div class="spinner-border text-success spinner-border-sm" role="status">
				  <span class="visually-hidden">Loading...</span>
				</div>
			  </div>
			</div>
		    <div id="demo" class="mt-2"></div>
        </td>
      </tr>
      <tr id="bizRow1" style="display: none;">
		<th class="bg-secondary-subtle">사업자등록번호</th>
		<td>
		  <span class="form-control-plaintext" style="padding-left: 6px;">${vo.businessNo}</span>
    	  <input type="hidden" name="businessNo" value="${vo.businessNo}" />
		</td>
	  </tr>
    </table>

    <!-- 선택입력사항 -->
    <tr>
  	  <td colspan="2">
        <div style="margin: 40px auto 10px auto; text-align: center;">
          <span style="color: #2e7d32; font-weight: bold; font-size: 1.3rem;">선택입력항목</span>
        </div>
      </td>
    </tr>
    <div id="addContent">
      <table class="join-table">
        <tr>
	      <th class="bg-secondary-subtle">생일</th>
	      <td>
	      	<input type="date" name="birthday" id="birthday" value="${fn:substring(vo.birthday, 0, 10)}" class="form-control" />
	      </td>
	    </tr>
        <tr>
          <th class="bg-secondary-subtle">전화번호</th>
          <td>
            <div class="input-group">
            	<c:set var="tel" value="${fn:split(vo.tel, '-')}"/>
              <select name="tel1" class="form-select">
                <option value="010" ${tel[0]=='010' ? 'selected' : ''}>010</option>
                <option value="02" ${tel[0]=='02' ? 'selected' : ''}>02</option>
                <option value="031" ${tel[0]=='031' ? 'selected' : ''}>031</option>
                <option value="032" ${tel[0]=='032' ? 'selected' : ''}>032</option>
                <option value="033" ${tel[0]=='033' ? 'selected' : ''}>033</option>
                <option value="041" ${tel[0]=='041' ? 'selected' : ''}>041</option>
                <option value="042" ${tel[0]=='042' ? 'selected' : ''}>042</option>
                <option value="043" ${tel[0]=='043' ? 'selected' : ''}>043</option>
                <option value="044" ${tel[0]=='044' ? 'selected' : ''}>044</option>
                <option value="051" ${tel[0]=='051' ? 'selected' : ''}>051</option>
                <option value="052" ${tel[0]=='052' ? 'selected' : ''}>052</option>
                <option value="053" ${tel[0]=='053' ? 'selected' : ''}>053</option>
                <option value="054" ${tel[0]=='054' ? 'selected' : ''}>054</option>
                <option value="055" ${tel[0]=='055' ? 'selected' : ''}>055</option>
                <option value="061" ${tel[0]=='061' ? 'selected' : ''}>061</option>
                <option value="062" ${tel[0]=='062' ? 'selected' : ''}>062</option>
                <option value="063" ${tel[0]=='063' ? 'selected' : ''}>063</option>
                <option value="064" ${tel[0]=='064' ? 'selected' : ''}>064</option>
              </select>-
              <input type="text" name="tel2" id="tel2" value="${fn:trim(tel[1])}" class="form-control" />-
		      <input type="text" name="tel3" id="tel3" value="${fn:trim(tel[2])}" class="form-control" />
            </div>
          </td>
        </tr>
        <tr>
		  <th class="bg-secondary-subtle">주소</th>
		  <td>
		    <div class="form-group">
		      <div class="input-group mb-2">
		        <c:set var="address" value="${fn:split(vo.address, '/')}"/>
		        <input type="text" name="postcode" id="sample6_postcode" value="${fn:trim(address[0])}" class="form-control">
		        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-success btn-sm ms-2 rounded">
		      </div>
		      <input type="text" name="roadAddress" id="sample6_address" value="${fn:trim(address[1])}" class="form-control mb-2">
		      <div class="input-group mb-1">
		        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${fn:trim(address[2])}" class="form-control me-1">
		        <input type="text" name="extraAddress" id="sample6_extraAddress" value="${fn:trim(address[3])}" class="form-control">
		      </div>
		    </div>
		  </td>
		</tr>
        <tr>
	        <th class="bg-secondary-subtle">정보공개</th>
	        <td class="text-start">
	        	<input type="radio" name="userInfor" id="userinfor1" value="공개"  ${vo.userInfor=='공개'   ? 'checked' : ''} />공개 &nbsp;
	        	<input type="radio" name="userInfor" id="userinfor2" value="비공개" ${vo.userInfor=='비공개' ? 'checked' : ''} />비공개
	        </td>
	      </tr>
      </table>
    </div>
      <div class="text-center mt-4">
	    <div class="d-flex justify-content-center gap-2 mb-3">
    	  <button type="button" onclick="fCheck()" class="btn btn-success">회원정보수정</button>
  		</div>
  		<div style="text-align: right; margin-right: 10px; margin-top: 10px;">
		  <a href="${ctp}/member/pwdCheck/d" style="font-size: 1rem; color: #cc0000;">회원 탈퇴하기</a>
		</div>
	  </div>
    <input type="hidden" name="email">
    <input type="hidden" name="tel">
    <input type="hidden" name="address">
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>