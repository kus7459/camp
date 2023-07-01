package logic;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import dao.BoardDao;
import dao.CampDao;
import dao.CartDao;
import dao.CommentDao;
import dao.GoodDao;
import dao.ItemDao;
import dao.SaleDao;
import dao.UserDao;

@Service
public class CampService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private CampDao campDao;
	
	@Autowired
	private ItemDao itemDao;
	
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private SaleDao saleDao;


	public void campinsert(Camp camp) {
		campDao.insert(camp);
	}
	
	public void userInsert(User user) {
		userDao.insert(user);
	}

	public User selectUserOne(String id) {
		return userDao.selectUserOne(id);
	}

	public void userUpdate(User user) {
		userDao.update(user);
	}

	public void chgpass(String id, String chgpass) {
		userDao.chgpass(id, chgpass);
	}

	public void logupdate(String id) {
		userDao.logupdate(id);
	}

	public void userDelete(String id) {
		userDao.delete(id);
	}

	public String getSearch(User user) {
		return userDao.search(user);
	}

	// admin - 회원 목록 조회
	public int usercount(String searchtype, String searchcontent) {
		return userDao.count(searchtype,searchcontent);
	}

	public List<User> userlist(Integer pageNum, int limit, String searchtype, String searchcontent) {
		return userDao.userlist(pageNum,limit,searchtype,searchcontent);
	}

	public void userRest(String id, Integer restNum) {
		userDao.rest(id,restNum);
	}

	public List<User> loglist() {
		return userDao.loglist();
	}

	public void userPasschg(String id, String passwordHash) {
		userDao.chgpass(id, passwordHash);
	}

	public List<User> getUserlist(String tel, String email) {
		return userDao.idsearch(email, tel);
	}

	// 쇼핑몰
	public void itemadd(Item item, HttpServletRequest request) {
		if(item.getPicture() != null && !item.getPicture().isEmpty()) { 
			// 사진이 없는 경우 경로 설정
			String path = request.getServletContext().getRealPath("/") +"img/";
			uploadFileCreate(item.getPicture(), path);
			item.setPictureUrl(item.getPicture().getOriginalFilename());
		}
		int maxid = itemDao.maxId();
		item.setId(maxid+1);
		itemDao.insert(item);
	}

	private void uploadFileCreate(MultipartFile file, String path) {
		String orgFile = file.getOriginalFilename();
		File f = new File(path);
		if(!f.exists()) f.mkdir();
		try {
			file.transferTo(new File(path+orgFile));
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public List<Item> itemlist() {
		return itemDao.list();
	}

	public Item itemOne(Integer id) {
		return itemDao.getItem(id);
	}

	public void itemUpdate(Item item, HttpServletRequest request) {
		// 사진이 없는 경우
		if(item.getPicture() != null && !item.getPicture().isEmpty()) {
			String path = request.getServletContext().getRealPath("/") +"img/";
			uploadFileCreate(item.getPicture(), path);
			item.setPictureUrl(item.getPicture().getOriginalFilename());
		}
		itemDao.update(item);
	}

	public void itemDelete(Integer id) {
		itemDao.delete(id);
	}

	public int itemcount() {
		return itemDao.itemcount();
	}

	public void cartadd(Integer itemid, Item item, String userid, Integer quantity) {
		cartDao.insert(itemid, item, userid, quantity);
	}

	public List<Cart> getuserCart(String userid, Integer itemid) {
		return cartDao.select(userid, itemid);
	}

	public void cartupdate(Integer itemid, Integer quan, String id) {
		cartDao.update(itemid, id, quan);
	}

	public void cartdelete(Integer itemid, String userid) {
		cartDao.delete(itemid, userid);
	}

	public Integer getMax() {
		return saleDao.maxId();
	}

	public void saleinsert(Integer saleid, String userid, Integer itemid, Integer quantity, Integer total,
			Integer postcode, String address, String detailaddress) {
		saleDao.insert(saleid, userid, itemid, quantity, total, postcode, address, detailaddress);
	}


}