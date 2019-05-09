<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다음 지도 띄워보기</title>
</head>
<body>
<!-- 3 -->
	<div id="map" style="width: 500px; height: 400px;"></div>
	<p>
		<em>지도를 클릭하면 마커가 이동!</em><br><br>
		<span id="maplevel"></span><br>
		<button onclick="zoomIn()">확대</button>
		<button onclick="zoomOut()">축소</button>
		<button onclick="setCenter()">중심으로 이동</button>
	</p>
	<div id="clickLatlng">클릭 시 위도 경도 표시되는 곳</div>
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
		
		// 클릭한 위치에 표출 시킬 마커
		var marker = new daum.maps.Marker({
			// 초기 위치 : 중심 좌표로 설정
			position: map.getCenter() // 맵의 가운데 좌표를 반환하는 내부 메서드 getCenter()
		});
		
		// 마커 지도에 표시
		marker.setMap(map);
		
		// ----------여기까지 하면 마커는 고정-----------
		
		// 마커 위치 저장용 변수
		var marker_latlng = marker.getPosition();		
		
		// 지도 클릭 이벤트 설정
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출한다.
		daum.maps.event.addListener(map, 'click', function(mouseEvent){
			//클릭한 위도, 경도 정보를 가져옵니다.
			var latlng = mouseEvent.latLng;
			
			//마커 위치를 클릭한 위치로 옮깁니다.
			marker.setPosition(latlng);
			
			marker_latlng = marker.getPosition();
			
			var message = '클릭한 위치의 위도 : ' + latlng.getLat() + "\n경도 : " + latlng.getLng();
			
			var resultDiv = document.getElementById('clickLatlng');
			resultDiv.innerHTML = message;
			
		});
		
		//--------------------------------------------------------
		
		// 지도 레벨 표시 1~14
		// 아래에서 함수 정의하였음
		displayLevel();
		
		// 줌 인
		function zoomIn() {
			// 현재 지도의 레벨을 얻어옵니다.
			var level = map.getLevel();
			
			// 지도를 1레벨 내립니다. (지도 확대)
			map.setLevel(level - 1);
			
			// 지도 레벨 표시
			displayLevel();
		}
		
		// 줌 아웃
		function zoomOut() {
			// 현재 지도의 레벨을 얻어옵니다.
			var level = map.getLevel();
			
			// 지도를 1레벨 올립니다. (지도 축소)
			map.setLevel(level + 1);
			
			// 지도 레벨 표시
			displayLevel();
		}
		
		function displayLevel(){
			var levelEl = document.getElementById('maplevel');
			levelEl.innerHTML = '현재 지도 레벨 : '+map.getLevel();
		}
		
		//-----------------------------------------------------
		function setCenter(){
			//마커를 중심으로 지도 이동
			var moveLatLon = new daum.maps.LatLng(marker_latlng.getLat(), marker_latlng.getLng());
			console.log(moveLatLon);
			//지도 중심을 이동
			map.setCenter(moveLatLon);
		}
	</script>

	</body>
</html>