<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 테스트</title>
</head>
<body style="font-size:15px">
<a href="${url}">W3W 지도 링크</a><br>
<a href="<%= request.getContextPath()%>/map">1.다음 지도 출력</a><br>
<a href="<%= request.getContextPath()%>/map_marker">2.다음 지도 마커 표시</a><br>
<a href="<%= request.getContextPath()%>/map_zoom">3.다음 지도 확대 축소</a><br>
<a href="<%= request.getContextPath()%>/map_w3w">4.마커 -> w3w</a><br>
<a href="<%= request.getContextPath()%>/map_control">5.마커 컨트롤 추가</a><br>
<a href="<%= request.getContextPath()%>/map_geo">6.geolocation 추가</a><br>
<h3>pull test</h3>
</body>
</html>