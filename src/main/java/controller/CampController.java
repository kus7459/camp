package controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import logic.Camp;
import logic.CampService;

@Controller
@RequestMapping("site")
public class CampController {
	@Autowired
	private CampService service;
	
//	@GetMapping("search")
//	public ModelAndView search1() {
//		ModelAndView mav = new ModelAndView();
//		Map<String, String> map = null;
//		map.put("loc", null);
//		map.put("csite", null);
//		map.put("bot", null);
//		List<Camp> camplist = service.camplist(map);
//		mav.addObject("camplist", camplist);
//		System.out.println(camplist);
//		return mav;
//	}

	@RequestMapping("search")
	public ModelAndView search(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(param.get("bot")!=null) {
		if(param.get("bot").equals("잔디")) { param.put("bot", "siteBottomCl1");}
		else if(param.get("bot").equals("파쇄석")) { param.put("bot", "siteBottomCl2");}
		else if(param.get("bot").equals("데크")) { param.put("bot", "siteBottomCl3");}
		else if(param.get("bot").equals("자갈")) { param.put("bot", "siteBottomCl4");}
		else if(param.get("bot").equals("흙")) { param.put("bot", "siteBottomCl5");}
		else {param.put("bot", null);}
		}
		if(param.size()==0) {
			System.out.println("아무것도 없다");
			param.put("loc", "");
			param.put("ciste", "");
			param.put("bot", null);
		}
		if(param.get("loc") !=null) {param.put("loc", ((String) param.get("loc")).replace(",", "|"));}
		String[] list;
		List<Camp> camplist = null;
		try{
			list = request.getParameterValues("oper");
			if(list !=null) {
				String operlist = String.join("|", list);
				param.put("operlist", operlist);
			}
			list = request.getParameterValues("theme");
			if(list !=null) {
				String themelist = String.join("|", list);
				param.put("themelist", themelist);
			}
			list = request.getParameterValues("add");
			if(list !=null) {
				String addlist = String.join("|", list);
				param.put("addlist", addlist);
			}
			list = request.getParameterValues("etc");
			if(list.length == 2) {
				param.put("carav", "Y");
				param.put("pet", "가능");
			}else if(list.length ==1 ) {
				if(list[0].equals("카라반")) {param.put("carav", "Y");}
				else if(list[0].equals("반려동물")){param.put("pet", "가능");}
			}
			
		}catch (NullPointerException e) {
			e.printStackTrace();
		}
		Integer pageNum = null;
		if(param.get("pageNum") != null) {
			pageNum = Integer.parseInt((String) param.get("pageNum"));
		}
		if(pageNum ==null || pageNum.toString().equals("")) {
			pageNum =1;
		}
		int limit = 10; // 한페이지당 보여줄 게시물 건수
		int listcount = service.campcount(param); //등록된 게시물 건수
		int maxpage = (int)((double)listcount/limit+0.95); //등록 건수에 따른 최대 페이지 수
		int startpage = (int)((pageNum/10.0 +0.9)-1) *10 +1; // 페이지의 시작 번호
		int endpage = startpage +9; // 페이지의 끝 번호 
		if(endpage > maxpage) endpage = maxpage;
		param.put("pageNum", pageNum);
		param.put("limit", limit);
		param.put("startrow", (pageNum-1)*limit);
		camplist = service.camplist(param);
		mav.addObject("camplist", camplist);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listcount",listcount);
		return mav;
	}
	@PostMapping("search2")
	public ModelAndView search2(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("/site/search");
		System.out.println(param);
		return mav;
	}

}
