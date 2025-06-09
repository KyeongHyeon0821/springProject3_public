<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 상세보기</title>
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
      margin-top: 30px;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
    }

    table th {
      background-color: #e0f5e9 !important;
      color: #444 !important;
      padding: 14px 12px;
      text-align: center;
      border-top: 1px solid #d0e0d5;
      border-bottom: 1px solid #d0e0d5;
      width: 150px;
    }

    table td {
      background-color: #fff;
      padding: 20px 20px;
      vertical-align: middle;
      border-bottom: 1px solid #e5e5e5;
    }

    table tr:last-child td {
      border-bottom: none !important;
    }

    .btn {
      font-size: 1rem;
    }
  </style>
  <script>
    'use strict';

    function deleteCheck(idx) {
      let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
      if (ans) location.href = "qnaDelete?idx=${vo.idx}";
    }

    function qnaIdxDeleteCheck(idx) {
      let ans = confirm("QnA 답변글을 삭제하시겠습니까?");
      if (!ans) return false;
      location.href = "/springProject3/qna/qnaDelete?idx=" + ${vo.idx};
    }

    function answerCheck() {
      let tempStr = '<div class="mt-5">';
      tempStr += '<h4 class="text-center mb-4" style="color: #2e7d32;">답 변 글 달 기</h4>';
      tempStr += '<div class="container">';
      tempStr += '<table class="table">';
      tempStr += '<tr>';
      tempStr += '  <th>작성자</th>';
      tempStr += '  <td style="border-top: 1px solid #e5e5e5;"><input type="text" name="nickName" value="${sNickName}" disabled class="form-control"/></td>';
      tempStr += '</tr>';
      tempStr += '<tr>';
      tempStr += '  <th>답변글제목</th>';
      tempStr += '  <td class="text-start">(Re) ${vo.title}</td>';
      tempStr += '</tr>';
      tempStr += '<tr>';
      tempStr += '  <th>이메일</th>';
      tempStr += '  <td><input type="text" name="email" value="${memberVo.email}" class="form-control" required/></td>';
      tempStr += '</tr>';
      tempStr += '<tr>';
      tempStr += '  <th>글내용</th>';
      tempStr += '  <td><textarea rows="6" name="content" required class="form-control"></textarea></td>';
      tempStr += '</tr>';
      tempStr += '<tr>';
      tempStr += '  <td colspan="2" class="text-center">';
      tempStr += '    <input type="button" value="답변등록" onclick="fCheck()" class="btn btn-outline-success me-2"/>';
      tempStr += '    <input type="button" value="취소" onclick="location.reload();" class="btn btn-outline-danger"/>';
      tempStr += '  </td>';
      tempStr += '</tr>';
      tempStr += '</table>';
      tempStr += '</div>';
      tempStr += '<input type="hidden" name="qnaSw" value="a"/>';
      tempStr += '<input type="hidden" name="qnaIdx" value="${vo.qnaIdx}"/>';
      tempStr += '<input type="hidden" name="title" value="(Re) ${vo.title}"/>';
      tempStr += '<input type="hidden" name="openSw" value="${vo.openSw}"/>';
      tempStr += '</div>';
      document.getElementById("reply").innerHTML = tempStr;
    }

    function fCheck() {
      var title = myform.title.value;
      var content = myform.content.value;

      if (title == "") {
        alert("글제목을 입력하세요");
        myform.title.focus();
        return false;
      }
      else if (content == "") {
        alert("글내용을 입력하세요");
        myform.content.focus();
        return false;
      }
      else myform.submit();
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <div class="col m-3 text-center">
	  <span class="my-page-header">QnA 상세보기</span>
	</div>
  <div class="section-box">
    <table class="table">
      <tr>
        <th>작성자</th>
        <td style="border-top: 1px solid #e5e5e5;">${vo.nickName}</td>
        <th>작성일시</th>
        <td style="border-top: 1px solid #e5e5e5;"><c:out value="${vo.WDate.substring(0,16)}" /></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td colspan="3">${vo.email}</td>
      </tr>
      <tr>
        <th>제목</th>
        <td colspan="3">${vo.title}</td>
      </tr>
      <tr>
        <th>내용</th>
        <td colspan="3">
        	<div style="min-height:300px; height:auto;">${fn:replace(vo.content, newLine, "<br/>")}</div>
        </td>
      </tr>
      <tr>
        <th>공개여부</th>
        <td colspan="3" style="border-bottom: 1px solid #e5e5e5 !important; padding-bottom: 8px;">
          ${vo.openSw == 'OK' ? '공개' : '비공개'}
        </td>
      </tr>
    </table>

    <div class="text-center mt-4">
      <c:if test="${vo.qnaAnswer == '답변대기'}">
        <input type="button" value="답변등록" onclick="answerCheck()" class="btn btn-outline-success me-2"/>
      </c:if>
      <input type="button" value="목록으로" onclick="location.href='${ctp}/qna/qnaList';" class="btn btn-outline-secondary me-2"/>
      <c:if test="${sMid eq vo.mid}">
        <c:if test="${vo.qnaAnswer == '답변대기' || sLevel == 0}">
          <c:if test="${sLevel != 0}">
            <input type="button" value="수정하기" onclick="location.href='${ctp}/qna/qnaUpdate?idx=${vo.idx}';" class="btn btn-outline-warning me-2"/>
          </c:if>
          <input type="button" value="삭제하기" onclick="deleteCheck(${vo.idx})" class="btn btn-outline-danger"/>
        </c:if>
      </c:if>
      <%-- 
      <c:if test="${(vo.qnaSw == 'a') && (sMid eq vo.mid)}">
        <input type="button" value="삭제하기" onclick="qnaIdxDeleteCheck(${vo.idx})" class="btn btn-outline-danger"/>
      </c:if>
       --%>
    </div>
    <form name="myform" method="post" action="qnaInput">
      <div id="reply"></div>
      <input type="hidden" name="pag" value="1"/>
      <input type="hidden" name="pageSize" value=""/>
      <input type="hidden" name="idx" value="${vo.idx}"/>
      <input type="hidden" name="mid" value="${sMid}"/>
      <input type="hidden" name="level" value="${sLevel}"/>
      <input type="hidden" name="nickName" value="${sNickName}"/>
    </form>
  </div>
  <div id="reply"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
