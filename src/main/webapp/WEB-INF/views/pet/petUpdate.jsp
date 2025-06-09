<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>petUpdate.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
<script>
  function isJongSung(char) {
    const code = char.charCodeAt(0);
    const jong = (code - 44032) % 28;
    return jong !== 0;
  }
</script>
<c:if test="${result eq 'ok'}">
  <script>
    const name = "${name}";
    const lastChar = name.charAt(name.length - 1);
    const josa = isJongSung(lastChar) ? "이" : "의";
    alert(name + josa + " 정보가 수정되었어요! 💚");
    location.href = "${ctp}/member/memberMyPage";
  </script>
</c:if>
 <style>
  body {
    background-color: #f9fefb;
  }
  .form-container {
    max-width: 600px;
    margin: 50px auto;
    padding: 30px;
    background-color: #fff;
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
    margin-bottom: 15px;
  }
  .form-group > label {
    font-weight: bold;
    margin-bottom: 5px;
    display: block;
    color: #333;
  }
  .img-grid {
    display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 16px;
	justify-items: center;
  }
  .img-grid label {
	width: 80px;
	text-align: center;
  }
  input, select, textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 1rem;
  }
  input[type="radio"] {
    width: auto;
  }
  .radio-inline {
    display: inline-block;
    margin-right: 20px;
    font-weight: normal;
  }
  input[type="submit"] {
    background-color: #6ac47e;
    color: white;
    font-weight: bold;
    border: none;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }
  input[type="submit"]:hover {
    background-color: #519d63;
  }
  .my-page-header {
    text-align: center;
    font-weight: bold;
    color: #2e7d32;
  }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="form-container">
<h3 class="text-center mb-4">
  <img src="${ctp}/images/logo.png" width="150px"/><br/>
  <div class="my-page-header">반려견 정보 수정</div>
</h3>
<form id="petForm" method="post" action="#" onsubmit="return confirmUpdate();">
  <input type="hidden" name="petIdx" value="${vo.petIdx}">
  <div class="form-group">
    <label for="petName">이름</label>
    <input type="text" id="petName" name="petName" value="${vo.petName}" required>
  </div>
  <div class="form-group">
    <label for="breed">견종</label>
    <input type="text" id="breed" name="breed" value="${vo.breed}">
  </div>
  <div class="form-group">
    <label>성별</label>
    <div style="margin-top: 5px;">
      <label class="radio-inline">
        <input type="radio" name="petGenderDisplay" value="남" ${vo.petGender eq '남' ? 'checked' : ''}> 남아
      </label>
      <label class="radio-inline">
        <input type="radio" name="petGenderDisplay" value="여" ${vo.petGender eq '여' ? 'checked' : ''}> 여아
      </label>
      <input type="hidden" name="petGender" value="${vo.petGender}">
    </div>
  </div>
  <div class="form-group">
    <label for="petAge">나이</label>
    <input type="number" id="petAge" name="petAge" min="0" value="${vo.petAge}">
  </div>
  <div class="form-group">
    <label for="weight">몸무게 (kg)</label>
    <input type="number" id="weight" name="weight" step="0.1" min="0" value="${vo.weight}">
  </div>
  <div class="form-group">
    <label>프로필 이미지 선택</label>
    <div class="img-grid">
      <c:set var="photo" value="${vo.photo}" />
      <label>
        <input type="radio" name="photo" value="dog1.png" ${photo eq 'dog1.png' ? 'checked' : ''}>
        <img src="${ctp}/images/dog1.png" width="70" height="70" style="border-radius: 10px;">
      </label>
      <label>
        <input type="radio" name="photo" value="dog2.png" ${photo eq 'dog2.png' ? 'checked' : ''}>
        <img src="${ctp}/images/dog2.png" width="70" height="70" style="border-radius: 10px;">
      </label>
      <label>
        <input type="radio" name="photo" value="dog3.png" ${photo eq 'dog3.png' ? 'checked' : ''}>
        <img src="${ctp}/images/dog3.png" width="70" height="70" style="border-radius: 10px;">
      </label>
      <label>
        <input type="radio" name="photo" value="dog4.png" ${photo eq 'dog4.png' ? 'checked' : ''}>
        <img src="${ctp}/images/dog4.png" width="70" height="70" style="border-radius: 10px;">
      </label>
      <label>
        <input type="radio" name="photo" value="dog5.png" ${photo eq 'dog5.png' ? 'checked' : ''}>
        <img src="${ctp}/images/dog5.png" width="70" height="70" style="border-radius: 10px;">
      </label>
      <label>
        <input type="radio" name="photo" value="dog6.png" ${photo eq 'dog6.png' ? 'checked' : ''}>
        <img src="${ctp}/images/dog6.png" width="70" height="70" style="border-radius: 10px;">
      </label>
    </div>
  </div>
  <div class="form-group">
    <label for="memo">특이사항 / 메모</label>
    <textarea id="memo" name="memo" rows="3" placeholder="예: 사람을 좋아함">${vo.memo}</textarea>
  </div>
  <input type="submit" value="수정하기">
</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>

