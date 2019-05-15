package spring_test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.what3words.javawrapper.What3WordsV3;
import com.what3words.javawrapper.request.Coordinates;
import com.what3words.javawrapper.response.Autosuggest;
import com.what3words.javawrapper.response.ConvertTo3WA;
import com.what3words.javawrapper.response.ConvertToCoordinates;

@Controller
public class MainController {
	What3WordsV3 api = new What3WordsV3("JXHF9IW0");
	@RequestMapping("/")
	public String goMain(Model model) {
		//api 인스턴스화

		//위도 경도 입력해서 3단어 주소로 변경
		ConvertTo3WA words = api.convertTo3wa(new Coordinates(37.501444, 127.028269)).language("ko").execute();
		//		ConvertTo3WA words = api.convertTo3wa(new Coordinates(37.501444, 127.028269)).language("en").execute();
		System.out.println("words : "+words);
		//3단어 주소 입력해서 위도 경도로 변경
		ConvertToCoordinates coordinates = api.convertToCoordinates("bubbles.firm.minder").execute(); 
		System.out.println("Coordinates : "+coordinates);
		System.out.println(coordinates.getMap()); 
		//주소만 추출해서 보내주기
		model.addAttribute("url", coordinates.getMap());
		//자동 제안
		Autosuggest autosuggest = api.autosuggest("bubbles.firm.minder").clipToCountry("FR", "KO").execute();
		System.out.println("Autosuggest: "+autosuggest);

		return "index";
	}

	@RequestMapping("/map")
	public String DaumMap() {
		return "map_daum";
	}

	@RequestMapping("/map_marker")
	public String DaumMap_marker() {
		return "map_daum_marker";
	}

	@RequestMapping("/map_zoom")
	public String DaumMap_zoom() {
		return "map_daum_zoom";
	}

	//	//마커의 경도 위도를 w3w주소로 변환시켜 출력하기
	@RequestMapping("/map_w3w")
	public String DaumMap_w3w() {
		return "map_daum_w3w";
	}
	
	//지도에 컨트롤 추가 
	@RequestMapping("/map_control")
	public String DaumMap_control() {
		return "map_daum_control";
	}
	
	//geolocation 추가
	@RequestMapping("/map_geo")
	public String DaumMap_geo() {
		return "map_daum_geo";
	}
	
	//마커 이미지 추가
	@RequestMapping("/map_image")
	public String DaumMap_image() {
		return "map_daum_image";
	}
	
	//다중 마커
	@RequestMapping("/map_image_multi")
	public String DaumMap_image_multi() {
		return "map_daum_image_multi";
	}
	
	//보이기 감추기, 마커 배열
	@RequestMapping("/map_hide")
	public String DaumMap_hide() {
		return "map_daum_hide";
	}
	
	// 마우스오버 시 주소 출력
	@RequestMapping("/map_mouseover")
	public String DaumMap_mouseover() {
		return "map_daum_mouseover";
	}
	
	// 마우스오버 시 확대
	@RequestMapping("/map_mouseover2")
	public String DaumMap_mouseover2() {
		return "map_daum_mouseover2";
	}
}
