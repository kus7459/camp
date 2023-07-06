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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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
	public String select2(String si, String gu, String dong, HttpServletRequest request) throws IOException, ParseException{
		// 시도 읽어서 x축 y축
		BufferedReader fr = null;
		BufferedReader fr2 = null;
		BufferedReader fr3 = null;
		
		String path = request.getServletContext().getRealPath("/")+"file/sido2.txt";
		String path2 = request.getServletContext().getRealPath("/")+"file/rain.txt"; // 중기 육상 예보 조회 (강수)
		String path3 = request.getServletContext().getRealPath("/")+"file/temp.txt"; // 중기 기온 조회 (기온)
	
		try {
			fr = new BufferedReader(new FileReader(path));
			fr2 = new BufferedReader(new FileReader(path2));	// 육상
			fr3 = new BufferedReader(new FileReader(path3));	// 기온
		} catch(Exception e) {	
			e.printStackTrace();	
		}
		
		// 초단기 예보
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
		
		String selTime = null;
		// 2시, 5시, 8시, 11시, 14시, 17시, 20시, 23시
		if(2 <= hour && hour < 5) {
			
		}
		
		
		System.out.println("hour: "+hour);
		System.out.println("date: "+ date);
		System.out.println("selTime: "+selTime);
	
	        
		// 단기 예보	:	http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=nY07X%2FnosUoRk5vTJtPdwtlLfVdD2WrLlSNhY3TYcPJdHHo7VHz7svJAp8N7fYhxqf48iOlhi11dRIqL7eg%2F9g%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("200", "UTF-8")); /*한 페이지 결과 수*/
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
        
        
	    // 중기 예보: 육상 
    	String regId = null;
		String stnData = null;
		try {
			while ((stnData = fr2.readLine()) != null) {
				String[] arr = stnData.split("\\s+");
				if (si.contains(arr[0])) {
					regId = arr[1].trim();
				}
				if (si.contains("강원")) {
					if (gu.equals("고성군") || gu.equals("속초시") || gu.equals("양양군") || gu.equals("강릉시") || gu.equals("동해시")
							|| gu.equals("삼척시") || gu.equals("태백시")) {
						regId = "11D20000"; // 영동
					} else {
						regId = "11D10000"; // 영서
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("regid=" + regId);
		String tmFc = null;
		if(hour < 18) {
			tmFc = date+"0600";
		} else {
			tmFc = date+"1800";
		}
		System.out.println("강수 regid: "+regId);
		System.out.println("날짜 시간: "+tmFc);
		StringBuilder urlBuil = new StringBuilder("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst");
		urlBuil.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=nY07X%2FnosUoRk5vTJtPdwtlLfVdD2WrLlSNhY3TYcPJdHHo7VHz7svJAp8N7fYhxqf48iOlhi11dRIqL7eg%2F9g%3D%3D");
		urlBuil.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		urlBuil.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
		urlBuil.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON)*/
		urlBuil.append("&" + URLEncoder.encode("regId","UTF-8") + "=" + URLEncoder.encode(regId, "UTF-8")); /* 지점번호 */
		urlBuil.append("&" + URLEncoder.encode("tmFc","UTF-8") + "=" + URLEncoder.encode(tmFc, "UTF-8")); /*요청자료형식(XML/JSON)*/
	         
        URL url2 = new URL(urlBuil.toString());
        HttpURLConnection con = (HttpURLConnection) url2.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Content-type", "application/json");
        System.out.println("중기 Response code: " + con.getResponseCode());
        BufferedReader rd2;
        if(con.getResponseCode() >= 200 && con.getResponseCode() <= 300) {
            rd2 = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {
            rd2 = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        StringBuilder sb2 = new StringBuilder();
        String line2;
        while ((line2 = rd2.readLine()) != null) {
            sb2.append(line2);
        }
        rd2.close();
        con.disconnect();
        
        
     	// 중기 : 기온
		String regid = null;
		String tempData = null;
		try {
			while((tempData = fr3.readLine()) != null) {
				String[] arr = tempData.split("\\s+");
				if (gu.indexOf(arr[0]) == 0) {
					regid = arr[1].trim();
					break; // 양구군
				} else if (si.contains(arr[0])) {
					regid = arr[1].trim();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	StringBuilder urlBu = new StringBuilder("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa");
    	urlBu.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=nY07X%2FnosUoRk5vTJtPdwtlLfVdD2WrLlSNhY3TYcPJdHHo7VHz7svJAp8N7fYhxqf48iOlhi11dRIqL7eg%2F9g%3D%3D");
    	urlBu.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
    	urlBu.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
    	urlBu.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON)*/
    	urlBu.append("&" + URLEncoder.encode("regId","UTF-8") + "=" + URLEncoder.encode(regid, "UTF-8")); /* 지점번호 */
    	urlBu.append("&" + URLEncoder.encode("tmFc","UTF-8") + "=" + URLEncoder.encode(tmFc, "UTF-8")); /*요청자료형식(XML/JSON)*/
	         
        URL url3 = new URL(urlBu.toString());
        HttpURLConnection co = (HttpURLConnection) url3.openConnection();
        co.setRequestMethod("GET");
        co.setRequestProperty("Content-type", "application/json");
        System.out.println("중기 기온 Response code: " + co.getResponseCode());
        BufferedReader rd3;
        if(co.getResponseCode() >= 200 && co.getResponseCode() <= 300) {
            rd3 = new BufferedReader(new InputStreamReader(co.getInputStream()));
        } else {
            rd3 = new BufferedReader(new InputStreamReader(co.getErrorStream()));
        }
        StringBuilder sb3 = new StringBuilder();
        String line3;
        while ((line3 = rd3.readLine()) != null) {
            sb3.append(line3);
        }
        rd3.close();
        co.disconnect();
        
        System.out.println("초단기: "+sb.toString());
        System.out.println("중기 강수: " + sb2.toString());
        System.out.println("중기 기온: " + sb3.toString());
        
        
        data = sb.toString();
    
        // 문자열 데이터 객체화
        JSONParser parser = new JSONParser();
        JSONObject obj = (JSONObject) parser.parse(data);

        // 초단기
        JSONObject parse_response = (JSONObject) obj.get("response");
        JSONObject parse_body = (JSONObject) parse_response.get("body");
        JSONObject parse_items = (JSONObject) parse_body.get("items");
        JSONArray parse_item = (JSONArray) parse_items.get("item");
        
        // 중기 강수
        
        // 중기 기온
        
        JSONObject weather = new JSONObject();
//      Object fcstDate;
        Object fcstTime;
        Object category;
        Object value;
        
        int dataSize = parse_item.size()/12;
        
        for(int i=0; i<dataSize; i++) {
        	for(int j=0; j<12; j++) {
        		weather = (JSONObject) parse_item.get((i*dataSize)+j);
//        		fcstDate = weather.get("fcstDate");
        		if(j==0 || j== 5 || j==6 || j==7 || j==10) {
        			fcstTime = weather.get("fcstTime");
            		category = weather.get("category");
            		value = weather.get("fcstValue");
        		}
        	}
        }
        return weather.toString();
	}
}