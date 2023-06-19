package controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("ajax")
public class AjaxController {
	
	@RequestMapping(value = "select", produces = "text/plain; charset=utf-8")        // 클라이언트로 문자열 전송. 인코딩 설정이 필요.
	public String select(String si, String gu, HttpServletRequest request) {
		BufferedReader fr = null;
		String path = request.getServletContext().getRealPath("/") + "file/sido.txt";

		try {
			fr = new BufferedReader(new FileReader(path));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Set<String> set = new LinkedHashSet<>();
		String data = null;
		if (si == null && gu == null) {
			try {
				while ((data = fr.readLine()) != null) {
					String[] arr = data.split("\\s+");
					if (arr.length >= 3) set.add(arr[0].trim());
				}
			} catch (IOException e) {
				e.printStackTrace();
	            }
		}
		List<String> list = new ArrayList<>(set);    // Set 객체를 List 객체로 변경
		return list.toString();    // 리스트 객체가 바로 브라우저에 전달 됨. view가 없음. data가 직접 내려감.
		// pom.xml의 fasterxml.jackson... 설정에 의해서 브라우저는 배열로 인식함.
		// ["서울특별시","경기도" ...]
	}
}
