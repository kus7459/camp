package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mchange.v2.csv.MalformedCsvException;

@Controller
@RequestMapping("naver")
public class NaverController {
	@GetMapping("*")	// localhost:8080/naver/search	라는 요청이 들어오면 view의 이름은 /WEB-INF/view/naver/search.jsp 뷰가 선택
	public String naver() {
		return null;	// 뷰의 이름. null => url과 같은 이름의 view를 선택
	}
	
	@RequestMapping("naversearch")	// naver/search.jsp 페이지에서 ajax으로 요청 됨. 
	@ResponseBody	// 뷰 없이 바로 데이터를 클라이언트에게 전송해라.
	public JSONObject naversearch(String data, int display, int start, String type) {
		// 자바스크립트에서 직접 jsonobject로 접속
		String clientId = "jtLAQzVD33dfD_4IxaXV";		// 애플리케이션 클라이언트 아이디값
		String clientSecret = "HO0PVjpjoj"; 	// 애플리케이션 클라이언트 시크릿값
		StringBuffer json = new StringBuffer();
		int cnt = (start-1)*display+1;		// 네이버에 시작 건수를 요청 (page)
		String text = null;

        try {
        	text = URLEncoder.encode(data, "UTF-8");
        	String apiURL = "https://openapi.naver.com/v1/search/"+type+".json?query="+text+"&display="+display+"&start="+cnt;
       
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();	// apiURL에 접속됨
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();	// 네이버에서 설정한 응답 코드
			BufferedReader br;
			if(responseCode == 200) {		// 결과 connection의 inputStream으로, EUC-KR로 인식해서 변경
				br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
															// └ 입력 스트림. 외부(네이버)에 있는 데이터가 들어옴. 네이버 데이터 수신.
			} else {	// 에러 발생. 검색 시 오류 발생. - 네이버에 응답 오류 코드 있음
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
															// └ 입력 스트림. 외부(네이버)에 있는 데이터가 들어옴. 네이버 오류 데이터 수신.
			}

			String inputLine = null;
			while((inputLine = br.readLine()) != null) {
				json.append(inputLine);		// 네이버에서 전송한 데이터 저장
			}
			br.close();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch(MalformedURLException e1) {
			e1.printStackTrace();
		} catch(IOException e1) {
			e1.printStackTrace();
		}
        // json : 동적 문자열 객체. 네이버에서 전송한 json 형태의 문자열 데이터
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = null;
		try {
			// json.toString() : String 객체. 문자열 객체
			// jsonData : json객체
			jsonObj = (JSONObject)parser.parse(json.toString());
		} catch(ParseException e) {
			e.printStackTrace();
		}
		return jsonObj;		//return 타입 jsonObject 타입
	}


}
