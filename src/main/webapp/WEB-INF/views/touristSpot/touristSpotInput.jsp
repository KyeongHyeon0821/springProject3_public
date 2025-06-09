<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>touristSpotInput.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico" />
<style>
    .form-container {
      max-width: 1000px;
      margin: 40px auto;
      padding: 30px;
      background-color: #fff;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      position: relative;
    }
    .form-title {
      text-align: center;
      font-weight: 700;
      color: #2e7d32;
      margin-bottom: 20px;
    }
    .btn-group-centered {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 15px;
      margin-top: 30px;
    }
    .logo {
      display: block;
      margin: 0 auto 20px;
      width: 120px;
    }
    nav {
	  position: relative;
	  z-index: 1000;
	}
    #map {
      width: 100%;
      height: 500px;
      border-radius: 10px;
      z-index: 1 !important;
    }
    .map_wrap {
      position: relative;
      width: 100%;
      height: 500px;
      margin-bottom: 30px;
      z-index: 1 !important;
    }
    #menu_wrap {
      position: absolute;
      top: 10px;
      left: 10px;
      bottom: 10px;
      width: 270px;
      margin: 0;
      padding: 10px;
      overflow-y: auto;
      background: rgba(255,255,255,0.6);
      font-size: 13px;
      border-radius: 10px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      z-index: 1 !important;
    }
    #menu_wrap hr {
      height: 1px;
      border: 0;
      border-top: 1px solid #888;
      margin: 5px 0;
    }
    #placesList {
      list-style: none;
      padding: 0;
      margin: 0;
    }
    #placesList li {
      padding: 10px;
      border-bottom: 1px solid #ddd;
      cursor: pointer;
    }
    #placesList li:hover {
      background: #f9f9f9;
    }
    #menu_wrap .option {
      display: flex;
      gap: 5px;
      margin-bottom: 10px;
    }
    #menu_wrap .option input {
      flex: 1;
      padding: 4px 6px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    #menu_wrap .option button {
      padding: 4px 8px;
      border: none;
      background: #2e7d32;
      color: #fff;
      border-radius: 4px;
    }
    #menu_wrap .option form {
	  display: flex;
	  gap: 5px;
	  width: 100%;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <div class="form-container">
    <img src="${ctp}/images/logo.png" alt="로고" class="logo"/>
    <h3 class="form-title mb-3">주변 관광지 등록</h3>
    <p class="text-center"><strong>${hotelName}</strong>의 주변 관광지를 등록합니다.</p>

    <div class="map_wrap">
      <div id="map"></div>
      <div id="menu_wrap">
        <div class="option">
          <form onsubmit="searchPlaces(event)">
			<input type="text" id="keyword" placeholder="키워드 입력">
			<button type="submit">검색</button>
		  </form>
        </div>
        <hr>
        <ul id="placesList"></ul>
      </div>
    </div>

    <form action="${ctp}/touristInput" method="post">
      <input type="hidden" name="hotelIdx" value="${hotelIdx}">
      <div id="spotGroupContainer">
        <div class="spot-group mb-4">
          <div class="mb-3">
            <label class="form-label fw-bold">관광지 이름</label>
            <input type="text" class="form-control name" name="name" required>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <input type="hidden" class="lat" name="lat">
            </div>
            <div class="col-md-6 mb-3">
              <input type="hidden" class="lng" name="lng">
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label fw-bold">주소</label>
            <input type="text" class="form-control address" name="address">
          </div>
          <div class="mb-3">
            <label class="form-label fw-bold">설명</label>
            <textarea class="form-control" name="description" rows="4"></textarea>
          </div>
        </div>
      </div>

      <div class="btn-group-centered">
        <button type="submit" class="btn btn-success">등록</button>
        <a href="${ctp}/hotel/hotelList" class="btn btn-outline-secondary">취소</a>
      </div>
    </form>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f5f016ee8ec4b87750154cd5e9d07dfb&libraries=services"></script>
<script>
  let map;
  let markers = [];
  let infowindow;
  const hotelLat = ${hotelY};
  const hotelLng = ${hotelX};
  const hotelName = '${hotelName}';

  window.onload = function () {
    const mapContainer = document.getElementById('map');
    const mapOption = {
      center: new kakao.maps.LatLng(hotelLat, hotelLng),
      level: 5
    };
    map = new kakao.maps.Map(mapContainer, mapOption);

    const hotelMarker = new kakao.maps.Marker({
      position: new kakao.maps.LatLng(hotelLat, hotelLng),
      map: map
    });
    const info = new kakao.maps.InfoWindow({
      position: hotelMarker.getPosition(),
      content: `<div style="padding:6px 12px; font-size:13px; white-space:nowrap;">${hotelName}</div>`
    });
    info.open(map, hotelMarker);
    infowindow = new kakao.maps.InfoWindow({zIndex:1});
  };

  function searchPlaces() {
    if (event) event.preventDefault(); 
   
    const keyword = document.getElementById('keyword').value;
    if (!keyword.trim()) {
      alert('키워드를 입력해주세요!');
      return;
    }
    const ps = new kakao.maps.services.Places();
    const center = map.getCenter();
    ps.keywordSearch(keyword, placesSearchCB, {
      location: center,
      radius: 3000
    });
  }

  function placesSearchCB(data, status) {
	  if (status === kakao.maps.services.Status.OK) {
	    removeMarkers();
	    const listEl = document.getElementById('placesList');
	    listEl.innerHTML = '';

	    data.forEach((place, idx) => {
	      const name = place.place_name || '이름 없음';
	      const address = place.road_address_name || place.address_name || '주소 없음';
	      const lat = place.y;
	      const lng = place.x;
	      const position = new kakao.maps.LatLng(lat, lng);

	      // 마커 이미지 설정 (초록 발바닥 아이콘)
	      const imageSrc = `${ctp}/images/paw_marker.png`;
	      const imageSize = new kakao.maps.Size(40, 42);
	      const imageOption = { offset: new kakao.maps.Point(20, 42) };
	      const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

	      // 마커 생성
	      const marker = new kakao.maps.Marker({
	        position: position,
	        image: markerImage,
	        map: map
	      });
	      markers.push(marker);

	      // 목록 항목 만들기
	      const item = document.createElement('li');
	      item.innerHTML = '<strong>' + name + '</strong><br/><small>' + address + '</small>';
	      item.onclick = () => {
	        document.querySelector('.spot-group:last-child .name').value = name;
	        document.querySelector('.spot-group:last-child .lat').value = lat;
	        document.querySelector('.spot-group:last-child .lng').value = lng;
	        document.querySelector('.spot-group:last-child .address').value = address;
	        map.setCenter(position);
	      };
	      listEl.appendChild(item);
	    });
	  } else {
	    alert('검색 결과가 없습니다.');
	  }
	}

  function removeMarkers() {
    for (let m of markers) m.setMap(null);
    markers = [];
  }
</script>
</body>
</html>
