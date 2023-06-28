package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.CampService;
import logic.Item;

@Controller
@RequestMapping("shop")
public class ShopController {

	@Autowired
	private CampService service;
	
	@GetMapping("*")
	public ModelAndView list() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Item());
		return mav;
	}
}
