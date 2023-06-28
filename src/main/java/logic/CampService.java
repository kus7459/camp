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

import dao.BoardDao;
import dao.CampDao;
import dao.CommentDao;
import dao.GoodDao;
import dao.UserDao;

@Service
public class CampService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private CampDao campDao;



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
	
}