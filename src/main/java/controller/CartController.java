package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.ItemException;
import logic.CampService;
import logic.Cart;
import logic.Item;
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
}
