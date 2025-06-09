<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>footer.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<link rel="stylesheet" type="text/css" href="${ctp}/css/linkMain.css"/>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
	<style>
		
		footer {
		  background-color: #3F7D58;
		  color: white;
		  padding: 60px 0 30px;
		}
		
		.footer-logo {
		  text-decoration: none;
		  font-size: 30px;
		  font-weight: bold;
		  color: black;
		  margin-bottom: 20px;
		  display: block;
		}
		
		.footer-links h3 {
		  margin-bottom: 20px;
		  font-size: 1.25rem;
		  color: black;
		  font-weight: 700;
  		  letter-spacing: 0.5px;
		}
		
		.footer-grid {
		  display: grid;
		  grid-template-columns: 2fr 1fr 1fr 1fr;
		  gap: 50px;
		  margin-bottom: 40px;
		}
		
		.footer-about p {
		  margin-bottom: 20px;
		  opacity: 0.8;
		}
		
		.social-icons {
		  display: flex;
		  gap: 15px;
		}
		
		.social-icon {
		  width: 40px;
		  height: 40px;
		  background-color: rgba(255, 255, 255, 0.1);
		  border-radius: 50%;
		  display: flex;
		  align-items: center;
		  justify-content: center;
		  transition: background-color 0.3s;
		}
		
		.social-icon:hover {
		  background-color: #EF9651;
		}
		
		.footer-links h3 {
		  margin-bottom: 20px;
		  font-size: 1.2rem;
		  color: black;
		}
		
		.footer-links ul {
		  list-style: none;
		  margin-bottom: 12px;
		  text-align: left;
		  padding-left: 5;  
		}

		.footer-links li {
		  margin-bottom: 10px;
		  margin-bottom: 12px;
		}
		
		.footer-links a {
		  color: white;
		  opacity: 0.8;
		  text-decoration: none;
		  transition: opacity 0.3s;
		}
		
		.footer-links a:hover {
		  opacity: 1;
		}
		
		.footer-bottom {
		  text-align: center;
		  padding-top: 30px;
		  border-top: 1px solid rgba(255, 255, 255, 0.1);
		  opacity: 0.7;
		  font-size: 0.9rem;
		}
		
		@media (max-width: 1024px) {
		  .benefits-grid {
		    grid-template-columns: repeat(2, 1fr);
		  }
		
		  .collections-grid {
		    grid-template-rows: repeat(3, 200px);
		  }
		
		  .collection-item:nth-child(1) {
		    grid-column: span 12;
		    grid-row: span 1;
		  }
		
		  .collection-item:nth-child(2) {
		    grid-column: span 6;
		    grid-row: span 1;
		  }
		
		  .collection-item:nth-child(3) {
		    grid-column: span 6;
		    grid-row: span 1;
		  }
		
		  .reviews-grid {
		    grid-template-columns: repeat(2, 1fr);
		  }
		}
		
		@media (max-width: 768px) {
		  .nav-container {
		    grid-template-columns: 1fr auto;
		  }
		
		  .nav-links {
		    display: none;
		  }
		
		  .hero-content,
		  .newsletter-container {
		    grid-template-columns: 1fr;
		    gap: 30px;
		  }
		
		  .footer-grid {
		    grid-template-columns: 1fr 1fr;
		  }
		
		  .reviews-grid {
		    grid-template-columns: 1fr;
		  }
		}
		
		@media (max-width: 576px) {
		  .footer-grid {
		    grid-template-columns: 1fr;
		  }
		
		  .collection-item:nth-child(2),
		  .collection-item:nth-child(3) {
		    grid-column: span 12;
		  }
		
		  .newsletter-form {
		    grid-template-columns: 1fr;
		  }
		
		  .benefits-grid {
		    grid-template-columns: 1fr;
		  }
		}
		
		@keyframes fadeIn {
		  from { opacity: 0; transform: translateY(20px); }
		  to { opacity: 1; transform: translateY(0); }
		}
		
		.animated {
		  animation: fadeIn 0.5s ease forwards;
		}
	</style>
</head>
<body>

<!-- Footer -->
<footer>
  <div class="container">
    <div class="footer-grid">
      <!-- 소개 -->
      <div class="footer-about">
        <a href="${ctp}/" class="footer-logo">withPET</a>
        <p>반려동물이 함께하는 여행, withPET에서 시작하세요.</p>
        <div class="social-icons">
          <a href="https://www.instagram.com/withpet" class="social-icon" target="_blank">
            <i class="bi bi-instagram"></i>
          </a>
          <a href="https://www.facebook.com/withpet" class="social-icon" target="_blank">
            <i class="bi bi-facebook"></i>
          </a>
          <a href="https://www.youtube.com/@withpet" class="social-icon" target="_blank">
            <i class="bi bi-youtube"></i>
          </a>
        </div>
      </div>

      <!-- 고객센터 -->
      <div class="footer-links">
        <h3>고객센터</h3>
        <ul>
          <li><a href="${ctp}/contact">문의하기</a></li>
          <li><a href="${ctp}/reservation/check">예약 확인</a></li>
          <li><a href="${ctp}/faq">자주 묻는 질문</a></li>
          <li><a href="${ctp}/terms">이용약관</a></li>
        </ul>
      </div>

      <!-- 반려동물 정책 -->
      <div class="footer-links">
        <h3>반려동물 안내</h3>
        <ul>
          <li><a href="${ctp}/policy">동반 기준</a></li>
          <li><a href="${ctp}/safety">펫 안전 수칙</a></li>
          <li><a href="${ctp}/hotel/rules">호텔 이용규칙</a></li>
        </ul>
      </div>

      <!-- 회사정보 -->
      <div class="footer-links">
        <h3>회사 정보</h3>
        <ul>
          <li>대표: 홍길동</li>
          <li>사업자등록번호: 123-45-67890</li>
          <li>고객센터: 1600-1234</li>
          <li>Email: support@withpet.co.kr</li>
        </ul>
      </div>
    </div>

    <!-- 하단 바 -->
    <div class="footer-bottom">
      <p>© 2025 withPET | 반려동물과의 여행, 이제는 걱정 없이.</p>
    </div>
  </div>
</footer>
</body>
</html>