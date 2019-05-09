<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다음 지도 띄워보기</title>
</head>
<body>
<!-- 1 -->
	<div id="map" style="width: 500px; height: 400px;"></div>
	<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=09843fbfff4ebe148f2dfff78831886e&libraries=services,clusterer,drawing"></script>
	
	<script>
		var container = document.getElementById('map'); //지도 담을 영역 DOM Reference
		var options = { //지도를 생성할 때 필요한 기본 옵션
				center: new daum.maps.LatLng(37.501444, 127.028269), //지도 중심 좌표
				// Latitude : 위도, Longitude : 경도 = LatLng
				level: 3 //지도의 레벨(확대, 축소 정도)
		};
		
		var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		
	</script>
	
	
</body>
</html>