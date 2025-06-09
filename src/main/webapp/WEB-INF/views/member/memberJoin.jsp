<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberJoin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
	'use strict';
	
	let idCheckSw = 0;
	let nickCheckSw = 0;
	let emailCheckSw = 0;
	let bizNoCheckSw = 0;
	
	let regMid = /^[a-zA-Z0-9_-]{4,20}$/;
	let regPwd = /^[a-zA-Z0-9!@#$%^&*]{4,16}$/;
	let regNickName = /^[가-힣a-zA-Z0-9_]{2,}$/;
	let regName = /^[가-힣a-zA-Z]+$/;
	let regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	let regTel = /^(01[016789]|02|0[3-6][1-5])-\d{3,4}-\d{4}$/;
	let regBizNo = /^\d{10}$/;
	
	function toggleBizForm(isBiz) {
	  document.getElementById('bizRow1').style.display = isBiz ? '' : 'none';
	}
	
	// 아이디 중복 체크
	function idCheck() {
	  let mid = myform.mid.value;
	  if (mid.trim() === "") {
	    alert("아이디를 입력하세요");
	    myform.mid.focus();
	  } else {
	    $.ajax({
	      url: "${ctp}/member/memberIdCheck",
	      type: "get",
	      data: { mid: mid },
	      success: function(res) {
	        if (res !== '0') {
	          alert("이미 사용중인 아이디입니다. 다시 입력하세요");
	          myform.mid.focus();
	        } else {
	          alert("사용 가능한 아이디입니다.");
	          idCheckSw = 1;
	          myform.mid.readOnly = true;
	        }
	      },
	      error: function() {
	        alert("전송 실패하였습니다.");
	      }
	    });
	  }
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
	
	// 사업자등록번호 중복 체크
	function bizNoCheck() {
	  let bizNo = myform.businessNo.value.trim();
	
	  if (bizNo === "") {
	    alert("사업자등록번호를 입력해주세요.");
	    myform.businessNo.focus();
	    return;
	  }
	  if (!regBizNo.test(bizNo)) {
	    alert("사업자등록번호는 숫자 10자리로 입력해주세요.");
	    myform.businessNo.focus();
	    return;
	  }
	
	  $.ajax({
	    url: "${ctp}/member/memberBizNoCheck",
	    type: "get",
	    data: { businessNo: bizNo },
	    success: function(res) {
	      if (res !== '0') {
	        alert("이미 등록된 사업자등록번호입니다.");
	        myform.businessNo.focus();
	      } else {
	        alert("사용 가능한 사업자등록번호입니다.");
	        bizNoCheckSw = 1;
	        myform.businessNo.readOnly = true;
	      }
	    },
	    error: function() {
	      alert("전송 실패하였습니다.");
	    }
	  });
	}
	
	// 이메일 인증 요청
	function emailCertification() {
	  let email = myform.email1.value.trim() + '@' + myform.email2.value.trim();
	
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
	        str += '<button type="button" onclick="emailCeritificationOk()" class="btn btn-info btn-sm rounded">인증번호확인</button>';
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
	  let mid = myform.mid.value.trim();
	  let pwd = myform.pwd.value.trim();
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
	  if (mid === "") {
	    alert("아이디를 입력해주세요.");
	    myform.mid.focus();
	    return;
	  }
	  if (!regMid.test(mid)) {
		alert("아이디는 4~20자의 영문, 숫자, 특수문자(_,-)만 사용 가능합니다.");
		myform.mid.focus();
		return;
	  }
	  if (idCheckSw === 0) {
		alert("아이디 중복체크를 해주세요.");
		document.getElementById("midBtn").focus();
		return;
	  }
	  if (pwd === "") {
	    alert("비밀번호를 입력해주세요.");
	    myform.pwd.focus();
	    return;
	  }
	  if (!regPwd.test(pwd)) {
		alert("비밀번호는 4~16자의 영문, 숫자, 특수문자(!@#$%^&*)만 사용 가능합니다.");
		myform.pwd.focus();
		return;
	  }
	  if (nickName === "") {
	    alert("닉네임을 입력해주세요.");
	    myform.nickName.focus();
	    return;
	  }
	  if (!regNickName.test(nickName)) {
		alert("닉네임은 2자 이상의 영문, 숫자, 특수문자(_,-)만 사용 가능합니다.");
		myform.nickName.focus();
		return;
	  }
	  if (nickCheckSw === 0) {
		 alert("닉네임 중복체크를 해주세요.");
		 document.getElementById("nickNameBtn").focus();
		 return;
	  }
	  if (name === "") {
	    alert("성명을 입력해주세요.");
	    myform.name.focus();
	    return;
	  }
	  if (!regName.test(name)) {
		alert("성명은 한글 또는 영문만 입력 가능합니다.");
		myform.name.focus();
		return;
	  }
	  if (email1 === "" || email2 === "") {
	    alert("이메일을 입력해주세요.");
	    myform.email1.focus();
	    return;
	  }
	  if (emailCheckSw === 0) {
		 alert("이메일 인증을 완료해주세요.");
		 document.getElementById("certificationBtn").focus();
		 return;
	  }
	  if (!regEmail.test(email)) {
	    alert("이메일 형식이 올바르지 않습니다.");
	    myform.email1.focus();
	    return;
	  }
	  if (!regTel.test(tel)) {
		alert("전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678 또는 02-123-4567");
		myform.tel2.focus();
		return;
	  }
	  if (level === "1") {
	    let businessNo = myform.businessNo.value.trim();
	    
	    if (businessNo === "") {
	      alert("사업자등록번호를 입력해주세요.");
	      myform.businessNo.focus();
	      return;
	    }
	    if (!regBizNo.test(businessNo)) {
	      alert("사업자등록번호는 숫자 10자리로 입력해주세요.");
	      myform.businessNo.focus();
	      return;
	    }
	    if (bizNoCheckSw === 0) {
	      alert("사업자등록번호 중복체크를 해주세요.");
	      document.getElementById("bizNoBtn").focus();
	      return;
	    }
	  }
	  myform.email.value = email;
	  myform.tel.value = tel;
	  myform.address.value = address;
	  myform.submit();
	}
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
    .btn-success {
      background-color: #02b757;
      border: none;
    }
    .btn-success:hover {
      background-color: #009345;
    }
    .btn-secondary {
      background-color: #ebebeb;
      color: #333;
      border: 1px solid #ccc;
    }
    .btn-secondary:hover {
      background-color: #ddd;
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
  	  <span style="color: #2e7d32; font-weight: bold;">회 원 가 입</span>
	</h3>
	<div class="join-container">
  <form name="myform" method="post" enctype="multipart/form-data">
    <table class="join-table">
      <tr>
        <th class="bg-secondary-subtle">회원유형</th>
        <td>
          <input type="radio" name="level" value="2" checked onclick="toggleBizForm(false)"> 일반회원 &nbsp;
          <input type="radio" name="level" value="1" onclick="toggleBizForm(true)"> 사업자회원
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">아이디</th>
        <td>
          <div class="input-group">
            <input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" autofocus required class="form-control" />
            <button type="button" id="midBtn" onclick="idCheck()" class="btn btn-secondary btn-sm ms-2 rounded">아이디중복체크</button>
          </div>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">비밀번호</th>
        <td>
          <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" required class="form-control" />
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">닉네임</th>
        <td>
          <div class="input-group">
            <input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" required class="form-control" />
            <button type="button" id="nickNameBtn" onclick="nickCheck()" class="btn btn-secondary btn-sm ms-2 rounded">닉네임중복체크</button>
          </div>
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">성명</th>
        <td>
          <input type="text" name="name" id="name" placeholder="성명을 입력하세요" required class="form-control" />
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">성별</th>
        <td>
          <input type="radio" name="gender" id="gender1" value="남자" checked> 남자 &nbsp;
          <input type="radio" name="gender" id="gender2" value="여자"> 여자
        </td>
      </tr>
      <tr>
        <th class="bg-secondary-subtle">이메일</th>
        <td>
          <div class="input-group">
            <input type="text" name="email1" id="email1" class="form-control" required placeholder="이메일"/>
            <span class="input-group-text">@</span>
            <select name="email2" id="email2" class="form-select">
              <option>naver.com</option>
              <option>hanmail.net</option>
              <option>gmail.com</option>
              <option>daum.net</option>
              <option>yahoo.com</option>
              <option>hotmail.com</option>
              <option>nate.com</option>
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
		    <div class="input-group">
		      <input type="text" name="businessNo" id="businessNo" class="form-control" placeholder="숫자 10자리 입력" />
		      <button type="button" id="bizNoBtn" onclick="bizNoCheck()" class="btn btn-secondary btn-sm ms-2 rounded">중복체크</button>
		    </div>
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
          <td><input type="date" name="birthday" id="birthday" value="<%=java.time.LocalDate.now()%>" class="form-control"></td>
        </tr>
        <tr>
          <th class="bg-secondary-subtle">전화번호</th>
          <td>
            <div class="input-group">
              <select name="tel1" class="form-select">
                <option value="010" selected>010</option>
                <option value="02">02</option>
                <option value="031">031</option>
                <option value="032">032</option>
                <option value="033">033</option>
                <option value="041">041</option>
                <option value="042">042</option>
                <option value="043">043</option>
                <option value="044">044</option>
                <option value="051">051</option>
                <option value="052">052</option>
                <option value="053">053</option>
                <option value="054">054</option>
                <option value="055">055</option>
                <option value="061">061</option>
                <option value="062">062</option>
                <option value="063">063</option>
                <option value="064">064</option>
              </select>
              <span class="input-group-text">-</span>
              <input type="text" name="tel2" id="tel2" class="form-control">
              <span class="input-group-text">-</span>
              <input type="text" name="tel3" id="tel3" class="form-control">
            </div>
          </td>
        </tr>
        <tr>
		  <th class="bg-secondary-subtle">주소</th>
		  <td>
		    <div class="input-group mb-2">
		      <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
		      <button type="button" onclick="sample6_execDaumPostcode()" class="btn btn-success btn-sm ms-2 rounded">우편번호 찾기</button>
		    </div>
		    <input type="text" name="roadAddress" id="sample6_address" placeholder="주소" class="form-control mb-2">
		    <div class="input-group mb-1">
		      <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control me-1">
		      <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="동/건물명" class="form-control">
		    </div>
		  </td>
		</tr>
        <tr>
          <th class="bg-secondary-subtle">정보공개</th>
          <td class="text-start">
            <input type="radio" name="userInfor" id="userinfor1" value="공개" checked> 공개 &nbsp;
            <input type="radio" name="userInfor" id="userinfor2" value="비공개"> 비공개
          </td>
        </tr>
      </table>
    </div>
    <div class="text-center mt-4" id="addBtn">
      <button type="button" onclick="fCheck()" class="btn btn-success me-2">회원가입</button>
      <button type="button" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-primary">돌아가기</button>
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
