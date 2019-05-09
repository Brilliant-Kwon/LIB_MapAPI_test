<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다음 지도 띄워보기</title>
<!-- jQuery CDN 로드 -->
<script src="//code.jquery.com/jquery.min.js"></script>
</head>
<body>
<!-- 4 -->
	<div id="map" style="width: 500px; height: 400px;"></div>
	<p>
		<em>지도를 클릭하면 마커가 이동!</em><br><br>
		<span id="maplevel"></span><br>
		<button onclick="zoomIn()">확대</button>
		<button onclick="zoomOut()">축소</button>
		<button onclick="setCenter()">중심으로 이동</button>
	</p>
	<div id="w3w">w3w 영어</div>
	<div id="w3w_ko">w3w 한글</div>
	<div id="w3w_lat">w3w 한글 -> 경도</div>
	<div id="w3w_lng">w3w 한글 -> 위도</div>
	<!-- <div id="clickLatlng">클릭 시 위도 경도 표시되는 곳</div> -->
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=09843fbfff4ebe148f2dfff78831886e&libraries=services,clusterer,drawing"></script>
<!-- w3w api 로드 -->
	<script src="https://assets.what3words.com/sdk/v3/what3words.js?key=JXHF9IW0"></script>
	
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
			
			/* var message = '클릭한 위치의 위도 : ' + latlng.getLat() + "\n경도 : " + latlng.getLng();
			
			var resultDiv = document.getElementById('clickLatlng');
			resultDiv.innerHTML = message; */
			
			//영어 주소 출력 함수
			getW3w(latlng.getLat(), latlng.getLng());
			
			//한글 주소 json 요청 구문
			var get_ko = {
					"async": true, //동기방식
					//"async": false, //비동기방식
					  "crossDomain": true, //크로스 도메인 : 외부 서버에 ajax 접근 가능하게 해줌
					  "url": "https://api.what3words.com/v3/convert-to-3wa?key=JXHF9IW0&coordinates="+latlng.getLat()+"%2C"+latlng.getLng()+"&language=ko&format=json",
							  //요청 대상 url - 마커의 좌표를 이용하여 한글 주소를 요청한 뒤 결과를 json으로 받는 url
					  "method": "GET", //요청 방식
					  "headers": {} //헤더 없음????
			}
			
			// get_ko구문을 요청시키고, 요청이 성공했을 때 실행되는 함수
			$.ajax(get_ko).done(function (response) { 
				  console.log(response);//콘솔확인용
				  var resultDiv = document.getElementById('w3w_ko');//div를찾아서
					resultDiv.innerHTML = "w3w_ko : " + response['words'];//웹에 출력
					
					var ko_latlng = {//한글 -> 좌표 받기 구문
							"async": true,
							  "crossDomain": true,
							  //url에 한글 주소를 바로 넣어줌
							  "url": "https://api.what3words.com/v3/convert-to-coordinates?key=JXHF9IW0&words="+response['words']+"&format=json",
							  "method": "GET",
							  "headers": {}
					}
					
					// 요청이 성공 했을 때, 위도 경도를 띄워주는 함수
					$.ajax(ko_latlng).done(function (response) {
						  console.log(response);
						  var resultDiv_lat = document.getElementById('w3w_lat');
						  var resultDiv_lng = document.getElementById('w3w_lng');
							resultDiv_lat.innerHTML = "위도 : "+ response['coordinates']['lat'];
							resultDiv_lng.innerHTML = "경도 : "+ response['coordinates']['lng'];
						});
				});
			
			
			
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
		
		//--------------------------------------------------------
		//w3w javascript
		var w3w_result = {};
		console.log("[result 초기값]",w3w_result)
		
		function getW3w(mouse_lat,mouse_lng){
			//위도 경도 -> 세단어 주소
			 /* what3words.api.convertTo3wa({lat:marker_latlng.getLat(), lng:marker_latlng.getLat()}).then(function(response){
				console.log("[convertTo3wa]", response);
				var resultDiv = document.getElementById('w3w');
				resultDiv.innerHTML = response['words'];
			}); */
			
			what3words.api.convertTo3wa({lat:mouse_lat, lng:mouse_lng}).then(function(response){
				console.log("[convertTo3wa]", response);
				var resultDiv = document.getElementById('w3w');
				resultDiv.innerHTML = "w3w_en : " + response['words'];
			});
			
		}
	</script>

	</body>
</html>