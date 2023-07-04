package controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("ajax2")
public class Ajax2Controller {
	
	@RequestMapping("select")
	public List<String> select(String si, String gu, HttpServletRequest request) {
		BufferedReader fr = null;
		String path = request.getServletContext().getRealPath("/")+"file/sido2.txt";
		try {
			fr = new BufferedReader(new FileReader(path));
		}catch(Exception e) {
			e.printStackTrace();
		}
		//Set : 중복불가
		//LinkedHashSet : 순서유지. 중복불가. 리스트아님(첨자사용안됨).
		Set<String> set = new LinkedHashSet<>();
		String data= null;
		if(si==null && gu==null) {  //시도 선택
			try {
				//fr.readLine() : 한줄씩 read
				while((data=fr.readLine()) != null) {
					// \\s+ : \\s(공백) +(1개이상) 
					String[] arr = data.split("\\s+");
					if(arr.length >= 5) set.add(arr[0].trim()); //중복제거됨. 
				}
			} catch(IOException e) {
				e.printStackTrace();
			}
		} else if(gu == null) { //si 파라미터 존재 => 시도선택 : 구군값 전송
		   si = si.trim();
		   try {
			  while ((data = fr.readLine()) != null) {
				 String[] arr = data.split("\\s+");
			  	 if(arr.length >= 5 && arr[0].equals(si) && !arr[1].contains(arr[0])) {
					 set.add(arr[1].trim()); //구정보 저장
				 }
			   }
		   } catch (IOException e) {
			   e.printStackTrace();
		   }
		} else { //si 파라미터,gu 파라미터 존재 => 구군선택 : 동값 전송
		   si = si.trim();
		   gu = gu.trim();
		   try {
			  while ((data = fr.readLine()) != null) {
				  String[] arr = data.split("\\s+");
				  if(arr.length >= 5 && arr[0].equals(si) &&
			    	 arr[1].equals(gu) && !arr[0].equals(arr[1]) && !arr[2].contains(arr[1])) {
					  set.add(arr[2].trim());
			      }
			  }
			} catch (IOException e) {
			    e.printStackTrace();
			}
		}
		List<String> list = new ArrayList<>(set); //Set 객체 => List 객체로 
		
		
		return list;
	}
	
	@RequestMapping("selectXy")
	public String select2(String si, String gu, String dong, HttpServletRequest request) throws IOException{
		// 시도 읽어서 x축 y축
		BufferedReader fr = null;
		String path = request.getServletContext().getRealPath("/")+"file/sido2.txt";
		try {
			fr = new BufferedReader(new FileReader(path));
		}catch(Exception e) {	e.printStackTrace();	}
//		List<Integer> xy = new ArrayList<>();
		String nx = null;
		String ny = null;
		String data= null;
		if(si != null && gu != null && dong != null) {
			try {
				while((data=fr.readLine()) != null) {
					String[] arr = data.split("\\s+");
					if(arr[0].equals(si) && arr[1].equals(gu) && arr[2].equals(dong)) {
						nx = arr[3].trim();
						ny = arr[4].trim();
					}
				}
			} catch(IOException e) { 
				e.printStackTrace();
			}
		}
		System.out.println("nx: "+nx+", ny: "+ny);
		// 기상청
		SimpleDateFormat f1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat f2 = new SimpleDateFormat("HHmm");
		Date nowDate = new Date();
		String date = f1.format(nowDate);
		String time = f2.format(nowDate);
		Integer hour = Integer.parseInt(time.substring(0, 2));		
		Integer minu = 	Integer.parseInt(time.substring(2, 4));
		System.out.println(hour+","+minu);
		// ex) 1시 45분이 넘었으면 1시 00분
		// 1시 45분이 넘지 않았으면 12시 00분으로 설정
		String selTime = null;
		if(minu >= 45) {
			selTime = hour.toString()+"00";
			System.out.println(selTime);
		} else if (minu < 45) {
			selTime = hour-1+"00";
			System.out.println(selTime);
		}

		// 초단기 예보	:	http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst
		// 단기 예보	:	http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=nY07X%2FnosUoRk5vTJtPdwtlLfVdD2WrLlSNhY3TYcPJdHHo7VHz7svJAp8N7fYhxqf48iOlhi11dRIqL7eg%2F9g%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("60", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON)*/
        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(date, "UTF-8")); 
        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(selTime, "UTF-8")); /* 정시단위 */
        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(nx,"UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(ny,"UTF-8"));
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
        return sb.toString();
	}
}

