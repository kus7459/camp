package controller;

import java.nio.file.spi.FileSystemProvider;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Spliterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import controller.BoardController.readcntComparator;
import logic.Board;
import logic.BoardService;
import logic.Camp;
import logic.CampingService;
import logic.Good;
import logic.User;

@Controller
@RequestMapping("site")
public class CampController {
	@Autowired
	private CampingService service;
	@Autowired
	private BoardService bservice;

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
	public ModelAndView search(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request)
			throws Exception {
		System.out.println(param);
		try {
			if(param.get("sort").equals("")) {
				param.put("sort", null);
			}
		}catch(NullPointerException e) {
			e.printStackTrace();
		}
		ModelAndView mav = new ModelAndView();
		if (param.get("bot") != null) {
			if (param.get("bot").equals("잔디")) {
				param.put("bot", "siteBottomCl1");
			} else if (param.get("bot").equals("파쇄석")) {
				param.put("bot", "siteBottomCl2");
			} else if (param.get("bot").equals("데크")) {
				param.put("bot", "siteBottomCl3");
			} else if (param.get("bot").equals("자갈")) {
				param.put("bot", "siteBottomCl4");
			} else if (param.get("bot").equals("흙")) {
				param.put("bot", "siteBottomCl5");
			} else {
				param.put("bot", null);
			}
		}
		if (param.size() == 0) {
			param.put("loc", "");
			param.put("ciste", "");
			param.put("bot", null);
		}
		if (param.get("loc") != null) {
			param.put("loc", ((String) param.get("loc")).replace(",", "|"));
		}
		String[] list;
		List<Camp> camplist = null;
		try {
			list = request.getParameterValues("oper");
			if (list != null) {
				String operlist = String.join("|", list);
				param.put("operlist", operlist);
			}
			list = request.getParameterValues("theme");
			if (list != null) {
				String themelist = String.join("|", list);
				param.put("themelist", themelist);
			}
			list = request.getParameterValues("add");
			if (list != null) {
				String addlist = String.join("|", list);
				param.put("addlist", addlist);
			}
			list = request.getParameterValues("etc");
			if (list.length == 2) {
				param.put("carav", "Y");
				param.put("pet", "가능");
			} else if (list.length == 1) {
				if (list[0].equals("카라반")) {
					param.put("carav", "Y");
				} else if (list[0].equals("반려동물")) {
					param.put("pet", "가능");
				}
			}

		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		param.put("test", "조회순");
		Integer pageNum = null;
		if (param.get("pageNum") != null) {
			pageNum = Integer.parseInt((String) param.get("pageNum"));
		}
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10; // 한페이지당 보여줄 게시물 건수
		int listcount = service.campcount(param); // 등록된 게시물 건수
		int maxpage = (int) ((double) listcount / limit + 0.95); // 등록 건수에 따른 최대 페이지 수
		int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1; // 페이지의 시작 번호
		int endpage = startpage + 9; // 페이지의 끝 번호
		if (endpage > maxpage)
			endpage = maxpage;
		param.put("pageNum", pageNum);
		param.put("limit", limit);
		param.put("startrow", (pageNum - 1) * limit);
		camplist = service.camplist(param);
		for(Camp c : camplist) {
			Good good = new Good();
			good.setGoodno(c.getContentId());
			int lovecnt=bservice.goodcount(good);
			c.setLovecnt(lovecnt);
		}
		try {
			if(param.get("sort").equals("추천순")) {
				Collections.sort(camplist,new lovecntComparator());
				System.out.println("정렬완료");
				System.out.println(camplist);
			}
		}catch(NullPointerException e) {
			e.printStackTrace();
			System.out.println("정렬실패");
		}
		mav.addObject("camplist", camplist);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("search","1");
		mav.addObject("listcount", listcount);
		mav.addObject("sort", param.get("sort"));
		return mav;
	}
	
	@PostMapping("search2")
	public ModelAndView search2(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("/site/search");
		System.out.println(param);
		try {
			if(param.get("sort").equals("")) {
				param.put("sort", null);
			}
		}catch(NullPointerException e) {
			e.printStackTrace();
		}
		String[] theme =null;
		List<String> list = new ArrayList<>();
		String themelist = "";
		String aroundlist = "";
		String pet = null;
		if(!param.get("themelist").equals("")) {
			theme = ((String) param.get("themelist")).split(",");
			list = new ArrayList<>(Arrays.asList(theme));
			if(list.contains("반려동물")) {
				pet="가능";
				list.remove(list.indexOf("반려동물"));
			}
			themelist = String.join("|", list);
		}
		if(!param.get("aroundlist").equals("")) {
			theme = ((String) param.get("aroundlist")).split(",");
			list = new ArrayList<>(Arrays.asList(theme));
			aroundlist = String.join("|", list);
		}
		Integer pageNum = null;
		if (param.get("pageNum") != null) {
			pageNum = Integer.parseInt((String) param.get("pageNum"));
		}
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10; // 한페이지당 보여줄 게시물 건수
		int listcount = service.campcount2(themelist,pet,aroundlist); // 등록된 게시물 건수
		int maxpage = (int) ((double) listcount / limit + 0.95); // 등록 건수에 따른 최대 페이지 수
		int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1; // 페이지의 시작 번호
		int endpage = startpage + 9; // 페이지의 끝 번호
		if (endpage > maxpage)	endpage = maxpage;
		int startrow = (pageNum-1) *limit;
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("search","2");
		mav.addObject("listcount", listcount);
		List<Camp> camplist = service.camplist2(themelist,pet,aroundlist,pageNum,limit,startrow,param.get("sort"));
		mav.addObject("camplist", camplist);
		System.out.println(themelist);
		System.out.println(aroundlist);
			if(pet !=null) {
				themelist +=",반려동물";
			}
			
		System.out.println(themelist);
		mav.addObject("themelist", themelist);
		mav.addObject("aroundlist",aroundlist);
		mav.addObject("sort", param.get("sort"));
		return mav;
	}
	
	class lovecntComparator implements Comparator<Camp> {
	    @Override
	    public int compare(Camp c1, Camp c2) {
	        if (c1.getLovecnt() < c2.getLovecnt()) {
	            return 1;
	        } else if (c1.getLovecnt() > c2.getLovecnt()) {
	            return -1;
	        }
	        return 0;
	    }
	}
	
	@RequestMapping("detail")
	public ModelAndView detail(int contentId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Camp camp = service.selectOne(contentId);
		service.addcnt(contentId);
		System.out.println(contentId);
		try{
			User loginUser = (User)session.getAttribute("loginUser");
			System.out.println(loginUser);
			Good like = new Good();
			like.setGoodno(contentId);
			like.setUserId(loginUser.getId());
			like.setGoodtype(2);
			int likeselect = bservice.goodselect(like); // 좋아요눌렀는지 확인
			if(likeselect == 0) {
				mav.addObject("likeselect",0);
			}else {
				mav.addObject("likeselect",1);
			}
			Good love = new Good();
			love.setGoodno(contentId);
			love.setUserId(loginUser.getId());
			love.setGoodtype(3);
			int loveselect = bservice.goodselect(love); // 좋아요눌렀는지 확인
			if(loveselect == 0) {
				mav.addObject("loveselect",0);
			}else {
				mav.addObject("loveselect",1);
			}
		}catch(NullPointerException e) {
			e.printStackTrace();
			mav.addObject("likeselect", 0);
			mav.addObject("loveselect", 0);
		}
		mav.addObject("camp", camp);
		return mav;
	}
	@RequestMapping("change")
	@ResponseBody
	public Map<String,Integer> change(Integer contentId, String userId, String type,HttpServletRequest request) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		System.out.println(contentId);
		System.out.println(userId);
		int ty =0;
		if(type.equals("like")) { ty=2;}
		if(type.equals("love")) { ty=3;}
		Good good = new Good();
		good.setGoodno(contentId);
		good.setUserId(userId);
		good.setGoodtype(ty);
		try {
			bservice.goodinsert(good);
			map.put("check", 0);
		} catch (Exception e) {
			bservice.gooddelete(good);
			map.put("check", 1);
		}
		map.put("type", ty);
		return map;
	}

}
