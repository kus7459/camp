package controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.FetchProfile.Item;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.format.datetime.joda.DateTimeParser;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StreamUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mchange.v2.cfg.PropertiesConfigSource.Parse;

import exception.LoginException;
import logic.Board;
import logic.BoardService;
import logic.CampService;
import logic.Cart;
import logic.Comment;
import logic.Good;
import logic.Sale;
import logic.User;
import util.CipherUtil;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private CampService service;
	
	@Autowired
	private BoardService bservice;
	
	@Autowired
	private CipherUtil util;
	
	private String passwordHash(String pass) {
		try {
			return util.makehash(pass, "SHA-512");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@GetMapping("*")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		List<Board> boardlist = bservice.mainlist(2);
		List<Board> noticelist = bservice.mainlist(1);
		mav.addObject("boardlist",boardlist);
		mav.addObject("noticelist", noticelist);
		return mav;
	}
	
	@PostMapping("search")
	public ModelAndView search() {
		ModelAndView mav = new ModelAndView("../site/search");
		return mav;
	}
	
	@PostMapping("join")
	public ModelAndView userAdd(@Valid User user, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.user");
			bresult.reject("error.input.check");
			return mav;
		}
		try {
			user.setPass(passwordHash(user.getPass()));
			service.userInsert(user); //db에 insert
			mav.addObject("user",user);
		} catch(DataIntegrityViolationException e) {
			e.printStackTrace();
			bresult.reject("error.duplicate.user");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:login");
		return mav;
	}
	
	// naver로그인
	@GetMapping("login")
	public ModelAndView login(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		// 네이버
		String clientId = "jtLAQzVD33dfD_4IxaXV";
		String redirectURL = null;
		try {
			redirectURL = URLEncoder.encode("http://localhost:8080/camp/user/naverlogin","UTF-8");
		} catch(Exception e) {
			e.printStackTrace();
		}
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130,random).toString();
		String apiURL = "http://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id="+clientId;
		apiURL += "&redirect_uri="+redirectURL;
		apiURL += "&state="+state;
		
		// 카카오
		String client_Id = "79d4f0b8f1a64393195daac005b9ecef";	// 카카오
		String redirectURL2 = null;
		try {
			redirectURL2 = URLEncoder.encode("http://localhost:8080/camp/user/kakaologin","UTF-8");
		} catch(Exception e) {
			e.printStackTrace();
		}
		String apiURL2 = "https://kauth.kakao.com/oauth/authorize?&response_type=code";
		apiURL2 += "&client_id="+client_Id;
		apiURL2 += "&redirect_uri="+redirectURL2;

		
		mav.addObject(new User());	//user 객체 전달
		mav.addObject("apiURL", apiURL);	// 네이버
		mav.addObject("kakaoApiURL", apiURL2);	// 카카오
		session.getServletContext().setAttribute("session", session);
		return mav;
	}
	

	
	// 네이버 로그인
	@RequestMapping("naverlogin")
	public String naverlogin(String code, String state, HttpSession session) {
		System.out.println("2. session.id="+session.getId());
		String clientId = "jtLAQzVD33dfD_4IxaXV";
		String clientSecret = "HO0PVjpjoj";
		String redirectURI=null;
		try {
			redirectURI = URLEncoder.encode("YOUR_CALLBACK_URL", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String apiURL;
		apiURL =  "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id="+clientId;
		apiURL += "&client_secret="+clientSecret; 
		apiURL += "&redirect_uri="+redirectURI;
		apiURL += "&code="+code;	// 네이버에서 전달해준 파라미터값
		apiURL += "&state=" + state;	// 네이버에서 전달해준 파라미터값. 초기에는 로그인 시작 시 개발자가 전달한 임의의 수
		// 내가 전달한 값을 다시 받음.
		System.out.println("code="+code+", state="+state);
		String access_token = "";
		String refresh_token = "";
		StringBuffer res = new StringBuffer();
		System.out.println("apiURL="+apiURL);
		try {
			URL url = new URL(apiURL); 
			// 네이버에 접속 => 토큰 전달 
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.print("responseCode="+responseCode);
			if(responseCode == 200) {	// 정상호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			// res: JSON 형태의 문자열 
			// {"access_token":"AAAAOolWTPpBht8Drpzznw1Y33gVkmwJIeEae1ndjI_Jc6qkiFZcm9z3rMNeI7IaovZMk5cJ4UYrv3gl33vHvgBglz4",...}
			if(responseCode == 200) {
				System.out.println("\n================res 1:");	// 네이버로부터 첫번째 요청에 대한 응답 메시지
				System.out.println("res: " +res.toString());
			}
		} catch(Exception e) {
			System.out.println(e);
		}
		
		// json 형태의 문자열 데이터 => json 객체로 변경
		JSONParser parser = new JSONParser();	// json-siple-1.1.1.jar 파일 설정 필요 -> pom.xml
		JSONObject json = null;;
		try {
			json = (JSONObject)parser.parse(res.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}	// res(네이버 응답 데이터)를 json 객체로 생성. - java에서도 쓸 수 있음
		String token = (String)json.get("access_token");	// 정상적인 로그인 요청인 경우 네이버가 발생한 코드값
		System.out.println("\n================token: "+token);
		String header = "Bearer " + token ;	//Bearer 다음에 공백 추가 : 공백을 넣어야 인증 정보를 확인해줌
		try {
			apiURL = "https://openapi.naver.com/v1/nid/me";		// 2번째 요청 URL. 토큰값 전송
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);	// header 값에 인증 정보 넣음
			int responseCode = con.getResponseCode();
			BufferedReader br;
			res = new StringBuffer();
			if(responseCode == 200) { // 정상 호출
				System.out.println("로그인 정보 정상 수신");
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				System.out.println("로그인 정보 오류 수신");
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			System.out.println(res.toString());
		} catch(Exception e) {
			System.out.println(e);
		}
		try {
			json = (JSONObject) parser.parse(res.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println(json);	// 네이버 사용자 정보 수신
		JSONObject jsondetail = (JSONObject)json.get("response");
		
		// == naver로부터 정보를 얻어 온 부분 ↓ ==
		String id = jsondetail.get("id").toString();
		User user = service.selectUserOne(id);
		if(user == null) {
			user = new User();
			user.setId(id);
			user.setName(jsondetail.get("name").toString());
			user.setEmail(jsondetail.get("email").toString());
			user.setTel(jsondetail.get("mobile").toString());
			String naver_birth =  jsondetail.get("birthyear").toString()+"-"+jsondetail.get("birthday").toString();
			SimpleDateFormat dateParser = new SimpleDateFormat("yyyy-MM-dd");
			Date date;
			try {
				date = dateParser.parse(naver_birth);
				user.setBirth(date);
			} catch (java.text.ParseException e) {
				e.printStackTrace();
			}
			if(jsondetail.get("gender").toString().equals("F")) {
				user.setGender(2);
			} else {
				user.setGender(1);
			}
			System.out.println("네이버 성별"+jsondetail.get("gender").toString());
			service.userInsert(user);
		}
		session.setAttribute("loginUser", user);
		return "redirect:mypage?id="+user.getId();
	}
	
	// 카카오 로그인
	@SuppressWarnings("unused")
	@RequestMapping("kakaologin")
	public String kakaologin(String code, HttpSession session) {
		System.out.println("2. session.id="+session.getId());
		
		HashMap<String, Object> userInfo = new HashMap<>();

		String client_Id = "79d4f0b8f1a64393195daac005b9ecef";
		String redirect_uri = null;
		try {
			redirect_uri = URLEncoder.encode("http://localhost:8080/camp/user/kakaologin", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String kakaoApiURL;
		kakaoApiURL =  "https://kauth.kakao.com/oauth/token?grant_type=authorization_code";
		kakaoApiURL += "&client_id="+client_Id;
		kakaoApiURL += "&redirect_uri="+redirect_uri;
		kakaoApiURL += "&code="+code;	// 카카오에서 전달해준 코드값
		
		// 내가 전달한 값을 다시 받음.
		System.out.println("code="+code);
		
		StringBuffer res = new StringBuffer();
		System.out.println("kakaoApiURL="+kakaoApiURL);
	
		try {
			URL url = new URL(kakaoApiURL); 
			// 카카오 접속 => 토큰 전달 
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			int responseCode = conn.getResponseCode();
			System.out.print("responseCode="+responseCode);
			
			BufferedReader br;
			if(responseCode == 200) {	// 정상호출
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
			String inputLine;
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if(responseCode == 200) {
				System.out.println("\n================res 1:");	// 첫번째 요청에 대한 응답 메시지
				System.out.println("res: " +res.toString());
			}
		} catch(Exception e) {
			System.out.println(e);
		}
		
		// json 형태의 문자열 데이터 => json 객체로 변경
		JSONParser parser = new JSONParser();
		JSONObject json = null;
		
		try {
			json = (JSONObject)parser.parse(res.toString());
			
		} catch(ParseException e) {
			e.printStackTrace();
		}
		
		String access_token = (String) json.get("access_token");
		System.out.println("###### access_token: "+access_token);
		String refresh_token = "";	// 사용자 리프레스 토큰값
		String token_type = "bearer"; // 토큰 타입 (고정)
		try {
			kakaoApiURL = "https://kapi.kakao.com/v2/user/me";
			URL url = new URL(kakaoApiURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode: "+ responseCode);
			BufferedReader br;
			
			String inputLine;
			String result = "";
			
			if(responseCode == 200) { // 정상 호출
				System.out.println("로그인 정보 정상 수신");
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else { // 에러 발생
				System.out.println("로그인 정보 오류 수신");
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
				result += inputLine;
			}
			System.out.println("정상 정보: "+res.toString());
			
			System.out.println("response body : " + result);
			JsonParser parser2 = new JsonParser();
	        JsonElement element = parser2.parse(result);
	        
	        JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
	        JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	        
	        String id = element.getAsJsonObject().get("id").getAsString();
	        String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	        String email = kakao_account.getAsJsonObject().get("email").getAsString();
	        String gender = kakao_account.getAsJsonObject().get("gender").getAsString();
	        userInfo.put("id", id);
	        userInfo.put("nickname", nickname);
	        userInfo.put("email", email);
	        userInfo.put("gender", gender);
			
			br.close();
			
//			 == 카카오 정보를 얻어 온 부분  db에 ==
			User user = service.selectUserOne((String)userInfo.get("id"));
			if(user == null) {
				user = new User();
				user.setId((String)userInfo.get("id"));
				user.setName((String)userInfo.get("nickname"));
				user.setEmail((String)userInfo.get("email"));
				if(userInfo.get("gender").equals("female")) {
					user.setGender(2);
				} else {
					user.setGender(1);
				}
				System.out.println("카카오 성별: "+userInfo.get("gender"));
				service.userInsert(user);
			}
			session.setAttribute("loginUser", user);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:mypage?id=" + userInfo.get("id");
	}

	// 일반 로그인
	@PostMapping("login")
	public ModelAndView login(@Valid User user, BindingResult bresult, HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.login.id");
			return mav;
		}
		User dbUser = service.selectUserOne(user.getId());
		// id 조회
		if(dbUser == null) {
			bresult.reject("error.login.id");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		
		String id = user.getId();
		int restNum = 1;
		
		// pw 조회
		if(passwordHash(user.getPass()).equals(dbUser.getPass())) {
			if(dbUser.getRest() == 2) {	//성공, 휴면 계정
				service.userRest(id, restNum);
				throw new LoginException("휴면 계정이 해지되었습니다. 다시 로그인 해주세요.", "login");
			} else {
				session.setAttribute("loginUser", dbUser);
				service.logupdate(user.getId());
				mav.setViewName("redirect:mypage?id="+user.getId());
				return mav;
			}
		} else {
			bresult.reject("error.login.id");
			mav.getModel().putAll(bresult.getModel());
		}
		return mav;
	}
	
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login";
	}
	
	@RequestMapping("mypage")
	public ModelAndView idCheckmypage(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUserOne(id);
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 주문내역 불러오기
		List<Sale> salelist = service.saleSelect(loginUser.getId());
		Integer size = salelist.size();
		
		// 게시판 등록 글
//		List<Board> boardlist = service.boardlist(id);
		
		// 등록 댓글
		
		// 좋아요
		
		// 구매 내역
		List<Cart> cartlist = service.getuserCart(id, 0);

		// 총 금액
		List<Integer> sumprice = new ArrayList<>();
		Integer sum = 0;
		for(int i = 0; salelist.size() > i; i++) {
			Integer sid = salelist.get(i).getSaleid();
			sum = 0;
			for(Sale s : salelist) {
				if(sid == s.getSaleid()) {
					sum += s.getPrice();
				}
			}
			sumprice.add(sum);
		}
		mav.addObject("size", size);
		mav.addObject("salelist", salelist);
		mav.addObject("sumprice", sumprice);
		mav.addObject("cartlist", cartlist);
		mav.addObject("user", user);
		List<Board> mpblist = bservice.mpblist(id);
		List<Comment> mpclist = bservice.mpclist(id);
		mav.addObject("mpblist", mpblist);
		mav.addObject("mpclist", mpclist);
		List<Good> goodlist = bservice.goodlist(id);
		List<Board> boardlist = new ArrayList<>();
		try {
			for(Good g : goodlist) { 
				boardlist.add(bservice.mpglist(g.getGoodno()));
			}
		}catch (NullPointerException e) {
			e.printStackTrace();
		}
		mav.addObject("boardlist", boardlist);
		return mav;
	}
	
	@GetMapping({"update","delete"})
	public ModelAndView idCheckUser(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.selectUserOne(id);
		mav.addObject("user", user);
		return mav;
	}
	
	@PostMapping("update")
	public ModelAndView update(@Valid User user, BindingResult bresult, String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		// 유효성 검사
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.update.user");
			return mav;
		}
		// 비밀번호 비교
		User loginUser = (User)session.getAttribute("loginUser");
		if(!loginUser.getPass().equals(this.passwordHash(user.getPass()))) {
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		// 유효성 검사 완료, 비밀번호 일치
		try {
			service.userUpdate(user);
			if(loginUser.getId().equals(user.getId())) {
				session.setAttribute("loginUser", user);
			}
			mav.setViewName("redirect:mypage?id="+user.getId());
		} catch(Exception e) {
			e.printStackTrace();
			throw new LoginException("회원 정보 수정 실패", "update?id="+user.getId());
		}
		return mav;
	}
	
	@PostMapping("mypwForm")
	public String loginCheckPw(String pass, String chgpass, HttpSession session) {
		User loginUser = (User)session.getAttribute("loginUser");
		if(!passwordHash(pass).equals(loginUser.getPass())) {
			throw new LoginException("비밀번호가 틀렸습니다.", "mypwForm");
		}
		// 일치
		try {
			service.chgpass(loginUser.getId(), passwordHash(chgpass));
			loginUser.setPass(passwordHash(chgpass));
		} catch(Exception e) {
			e.printStackTrace();
			throw new LoginException("비밀번호 수정 시 오류 발생", "mypwForm?id="+loginUser.getId());
		}
		return "redirect:mypage?id="+loginUser.getId();
	}
	
	@PostMapping("delete")
	public String idCheckdelete(String pass, String id, HttpSession session) {
		// 관리자 탈퇴 불가능
		if(id.equals("admin")) {
			throw new LoginException("관리자는 탈퇴할 수 없습니다.", "mypage?id="+id);
		}
		// 세션 비밀번호 값과 비교
		User loginUser = (User)session.getAttribute("loginUser");
		if(!passwordHash(pass).equals(loginUser.getPass())) {
			throw new LoginException("비밀번호가 틀렸습니다.", "deleteForm?id="+loginUser.getId());
		}
		
		// 비밀번호 일치, 관리자 아닌 경우
		try {
			service.userDelete(id);
		} catch(DataIntegrityViolationException e) {
			throw new LoginException("주문 정보가 존재 해 탈퇴가 불가능합니다. 관리자에게 문의주세요.", "mypage?id="+loginUser.getId());
		} catch(Exception e) {
			e.printStackTrace();
			throw new LoginException("탈퇴 시 오류가 발생했습니다.", "deleteForm?id="+loginUser.getId());
		}
		
		// admin 회원정보 탈퇴
		if(loginUser.getId().equals("admin")) {
			return "redirect:../admin/list";
		} else {
			session.invalidate();
			return "redirect:login";
		}
	}

	@PostMapping("{url}search")
	public ModelAndView search(User user, BindingResult bresult, @PathVariable String url) {
		ModelAndView mav = new ModelAndView();
		String code = "error.userid.search";
		String title = "아이디";
		if(url.equals("pw")) {	// 비밀번호 검증
			title = "비밀번호";
			code = "error.password.search";
			if(user.getId() == null || user.getId().trim().equals("")) {
				bresult.rejectValue("id","error.required");
			}
		}
		//  email 없는 경우
		if(user.getEmail() == null || user.getEmail().trim().equals("")) {
			bresult.rejectValue("email", "error.required");
		}
		//  tel 없는 경우
		if(user.getTel() == null || user.getTel().trim().equals("")) {
			bresult.rejectValue("tel", "error.required");
		}
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		// 입력 값 검증 완료
		if(user.getId() != null && user.getId().trim().equals("")) {
			user.setId(null);
		}
		
		// 아이디 찾기
		String result = null;
		if(user.getId() == null) {	// 아이디 없는 경우 => 아이디 찾기
			List<User> list = service.getUserlist(user.getTel(), user.getEmail());
			System.out.println("아이디 찾기 list: "+list);
			for(User u : list) {
				if(u != null) {
					result = u.getId();
				}
			}
		} else {	// 아이디 있는 경우 => 비밀번호 초기화 하기
			result = service.getSearch(user);
			if(result != null) {
				String pass = null;
			}
			service.userPasschg(user.getId(), passwordHash(result));
			mav.addObject("result");
			mav.addObject("title", title);
			mav.addObject("id", user.getId());
			mav.setViewName("loginpass");
			return mav;
		}
		if(result == null) {	// 아이디 또는 비밀번호 검색 실패
			bresult.reject(code);
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.addObject("result");
		mav.addObject("title", title);
		mav.setViewName("search");
		return mav;
	}
	
	@RequestMapping("loginpass")
	public String loginpass(String id, String pass) {
		User dbUser = service.selectUserOne(id);
		System.out.println(dbUser.getPass());
		System.out.println(passwordHash(pass));
		if(dbUser.getPass().equals(passwordHash(pass))) {
			throw new LoginException("현재 비밀번호와 새로운 비밀번호가 같습니다.", "redirect:loginpass");
		} else {
			service.userPasschg(id, passwordHash(pass));
			throw new LoginException("비밀번호가 변경 되었습니다.","login");
		}
	}
	
}
