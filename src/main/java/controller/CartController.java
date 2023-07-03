package controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import exception.ItemException;
import logic.CampService;
import logic.Cart;
import logic.Item;
import logic.Sale;
import logic.User;

@Controller
@RequestMapping("cart")
public class CartController {
	
	@Autowired
	private CampService service;
	
	@GetMapping("*")
	public ModelAndView cart(Integer id) {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Cart());
		return mav;
	}
	
	// 장바구니 추가
	@RequestMapping("addcart")
	public ModelAndView addcart(Integer id, Integer quantity, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser == null) {		// 장바구니 기능 일반 로그인 사용자만 가능.
			throw new ItemException("로그인이 필요한 서비스입니다.", "../user/login");
		} else if (loginUser.getId().equals("admin")) {
			throw new ItemException("관리자는 주문하실 수 없습니다.", "detail?id="+id);
		}
		
		// 장바구니에 넣을 아이템 정보
		Item item = service.itemOne(id);
		List<Cart> cartlist = service.getuserCart(loginUser.getId(), 0);
		
		Map<Integer, Integer> map = new HashMap<>();
		for(Cart cart : cartlist) {
			map.put(cart.getItemid(), cart.getQuantity());
		}
		// 장바구니에 정보 있을 때
		if(cartlist.size() > 0) {
			if(map.containsKey(id) == true) {	// 기존에 있는 상품이면
				if(quantity == null || quantity == 0) {	// list에서 추가할 때
					Integer quan = map.get(id)+1;
					service.cartupdate(id, quan, loginUser.getId());
					throw new ItemException("장바구니에 상품이 추가됐습니다.", "../shop/list");
				} else {	// detail 에서 추가할 때
					Integer quan = map.get(id) + quantity;
					service.cartupdate(id, quan, loginUser.getId());
					throw new ItemException("장바구니에 상품이 추가됐습니다.", "../shop/detail?id="+item.getId());
				}
			} else if (map.containsKey(id) == false){	// 없는 상품이면
				if(quantity == null || quantity == 0) {	// list에서 추가할 때
					quantity = 1;
					service.cartadd(id, item, loginUser.getId(), quantity);
					throw new ItemException("장바구니에 상품이 추가됐습니다.", "../shop/list");
				} else {	// detail에서 추가할 때
					service.cartadd(id, item, loginUser.getId(), quantity);
					throw new ItemException("장바구니에 상품이 추가됐습니다.", "../shop/detail?id="+item.getId());
				}
			}
		}
		// 장바구니에 정보 없을 때
		if(cartlist.size() == 0) {
			if(quantity == null || quantity == 0) {	// list에서 추가할 때
				quantity = 1;
				service.cartadd(id, item, loginUser.getId(), quantity);
				throw new ItemException("장바구니에 상품이 추가됐습니다.", "../shop/list");
			} else {	// detail 에서 추가할 때
				service.cartadd(id, item, loginUser.getId(), quantity);
				throw new ItemException("장바구니에 상품이 추가됐습니다.", "../shop/detail?id="+item.getId());
			}
		}
		return mav;
	}

	@GetMapping("delete")
	public String delete(Integer id, HttpSession session) {
		User loginUser = (User)session.getAttribute("loginUser");
		service.cartdelete(id, loginUser.getId());
		return "redirect:/user/mypage?id="+loginUser.getId();
	}
	// 주문 
	@RequestMapping("saleitem")
	public ModelAndView loginChecksaleitem(String userid, Integer id, Integer quantity, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		// user의 cart 테이블에서 조회
		List<Cart> cartlist = service.getuserCart(loginUser.getId(), id);
		Integer total = 0;
		Integer sum = 0;
		if(cartlist.size() > 0) {
			for(Cart c : cartlist) {
				if(cartlist.size() == 1) { // 한 개의 아이템
					total += c.getQuantity() * c.getPrice();
					mav.addObject("itemid",1);
				} else {	// 아이템 여러개
					total += c.getQuantity() * c.getPrice();
					mav.addObject("itemid", 0);
				}
			}
		}
		
		// 제품 detail 에서 바로 구매 시
		Integer itemid = id;
		Item Item = service.itemOne(itemid);
		mav.addObject("saleitem", Item);
		mav.addObject("quantity", quantity);
		
		mav.addObject("total", total);
		mav.addObject("user", loginUser);
		mav.addObject("cartlist", cartlist);
		return mav;
	}
	
	@RequestMapping("order")
	public ModelAndView loginCheckorder(@RequestParam Map<String, String> param, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("loginUser");
		
		Integer max = service.getMax();
		Integer saleid;
		if(max == 0 || max == null || max.toString().trim().equals("")) {
			saleid = 1;
		} else {
			saleid = max+1;
		}
		
		Integer itemid = Integer.parseInt(param.get("itemid"));	//itemid 파라미터값
		System.out.println(itemid);
		int sum = 0;
		
		// mypage에서 주문
		// 장바구니
		if (itemid == 0) {	// 여러개인 경우
			List<Cart> citemid = service.getuserCart(loginUser.getId(), 0);
			mav.addObject("cartlist", citemid);
			for(Cart c : citemid) {
				sum += c.getPrice() * c.getQuantity();
				service.saleinsert(saleid, loginUser.getId(), c.getItemid(), c.getName(),
						c.getQuantity(), c.getPictureUrl(), c.getPrice() * c.getQuantity(), 
					Integer.parseInt(param.get("postcode")), param.get("address"), param.get("detailAddress"));
			}
		} else {	// 한 개인 경우
			// 바로구매
			if(param.get("quantity") != null || !param.get("quantity").toString().trim().equals("")) {
				Item item = service.itemOne(itemid);
				service.saleinsert(saleid, loginUser.getId(), item.getId(), item.getName(),
						Integer.parseInt(param.get("quantity")), item.getPictureUrl(), item.getPrice() * Integer.parseInt(param.get("quantity")), 
					Integer.parseInt(param.get("postcode")), param.get("address"), param.get("detailAddress"));
				List<Sale> saleitem = service.saleitemList(loginUser.getId(), saleid);
				mav.addObject("cartlist", saleitem);
			} else {	// 장바구니 구매
				List<Cart> cart = service.getuserCart(loginUser.getId(), itemid);
				mav.addObject("cartlist", cart);
				sum += cart.get(0).getPrice() * cart.get(0).getQuantity();
				service.saleinsert(saleid, loginUser.getId(), cart.get(0).getItemid(), cart.get(0).getName(),
						cart.get(0).getQuantity(), cart.get(0).getPictureUrl(), cart.get(0).getPrice() * cart.get(0).getQuantity(), 
						Integer.parseInt(param.get("postcode")), param.get("address"), param.get("detailAddress"));
			} 
			
		}
		System.out.println("saleid"+saleid);
		List<Sale> salelist = service.saleitemList(loginUser.getId(), saleid);
		mav.addObject("saleid", saleid);
		mav.addObject("postcode", salelist.get(0).getPostcode());
		mav.addObject("address", salelist.get(0).getAddress());
		mav.addObject("detailAddress", salelist.get(0).getDetailAddress());
		mav.addObject("user",loginUser);
		mav.addObject("sum", sum);
		return mav;
	}
	
	@RequestMapping("kakao")
	@ResponseBody
	public Map<String, Object> kakao(HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		
		User loginUser = (User)session.getAttribute("loginUser");
		List<Sale> saleid = service.selectsaleid(loginUser.getId()); 
		System.out.println("카카오 saleid" + saleid);
		List<Sale> salelist = service.saleitemList(loginUser.getId(), saleid.get(0).getSaleid());
		System.out.println(salelist);
		
		// 주문 정보
		map.put("merchant_uid", loginUser.getId()+"-"+session.getId()); // 주문 번호
		if(salelist.size() > 1) {
			map.put("name", salelist.get(0).getName()+"외 "+(salelist.size()-1));	// 상품명
		} else {
			map.put("name", salelist.get(0).getName());	// 상품명
		}
		int sum = 0;
		for(Sale s : salelist) {
			sum += s.getPrice();
		}
		map.put("amount", sum);
		// ↓ 주문자 정보
		map.put("uid", saleid.get(0).getSaleid());
		map.put("buyer_userid", loginUser.getName());
		map.put("buyer_email", loginUser.getEmail());
		map.put("buyer_tel", loginUser.getTel());
		map.put("buyer_addr", salelist.get(0).getAddress()+","+salelist.get(0).getDetailAddress());
		map.put("buyer_postcode", salelist.get(0).getPostcode());
		return map;		// 클라이언트는 json 객체로 전달
	}
	
	@RequestMapping("salecheck")
	public ModelAndView logingChecksalecheck(Integer saleid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			User loginUser = (User)session.getAttribute("loginUser");
			List<Cart> salelist = service.getuserCart(loginUser.getId(), 0);
			if(salelist.size() == 0) {
				
			} else if(salelist.size() > 1) {	// 주문 아이템이 1개보다 많으면
				// 카트리스트 전체 삭제
				service.cartdelete(0, loginUser.getId());
			} else {	// 1개면
				service.cartdelete(salelist.get(0).getItemid(), loginUser.getId());
			}
			throw new ItemException("결제되었습니다.", "../user/mypage?id="+loginUser.getId());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping("saledelete")
	public String loginChecksaledelete(Integer saleid, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		service.saledelete(loginUser.getId(), saleid);
		return "redirect:/user/mypage?id="+loginUser.getId();
	}
}
