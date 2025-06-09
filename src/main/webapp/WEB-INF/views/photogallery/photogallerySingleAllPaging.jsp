<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>


<c:forEach var="vo" items="${vos}" varStatus="st">
	<div class="text-end"><input type="button" value="돌아가기" onclick="location.href='photogalleryList'" class="btn btn-outline-secondary btn-sm mb-2"/></div>
  <table class="table">
    <tr>
      <th>작성자</th>
      <td style="border-top: 1px solid #e5e5e5;">${vo.nickName}</td>
      <th>작성일시</th>
      <td style="border-top: 1px solid #e5e5e5;"><c:out value="${vo.WDate.substring(0,16)}" /></td>
      <th>조회수</th>
      <td style="border-top: 1px solid #e5e5e5;">${vo.readNum}</td>
      <th>좋아요</th>
      <td style="border-top: 1px solid #e5e5e5;"><a href="javascript:goodCheck()" title="좋아요" style="text-decoration: none;"><font size="4">👍 (${vo.good})</font></a></td>
    </tr>
    <tr>
      <th>제목</th>
      <td colspan="9">${vo.title}</td>
    </tr>
    <tr style="border-bottom: 1px solid #e5e5e5">
      <th>내용</th>
      <td colspan="9">
      	<div style="min-height:300px; height:auto; ">${fn:replace(vo.content, newLine, "<br/>")}</div>
      </td>
    </tr>
  </table>
  <div class="text-center mt-4">
    <input type="button" value="목록으로" onclick="location.href='${ctp}/photogallery/photogalleryList';" class="btn btn-outline-secondary me-2"/>
  </div>
  <hr class="border-secondary">
</c:forEach>
