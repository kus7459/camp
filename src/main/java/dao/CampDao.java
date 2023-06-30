package dao;

import java.nio.file.spi.FileSystemProvider;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CampMapper;
import logic.Camp;

@Repository
public class CampDao {
	@Autowired
	private SqlSessionTemplate template;
	private Class<CampMapper> cls = CampMapper.class;
	private Map<String, Object> param = new HashMap<>();
	
	
	public void insert(Camp camp) {
		template.getMapper(cls).insert(camp);
	}


	public List<Camp> list(Map<String, Object> param2) {
		return template.getMapper(cls).list(param2);
	}


	public int count(Map<String, Object> param2) {
		System.out.println();
		return template.getMapper(cls).count(param2);
	}


	public List<Camp> list2(String themelist, String pet, String aroundlist, Integer pageNum, int limit, int startrow, Object object) {
		param.clear();
		param.put("themelist", themelist);
		param.put("pet", pet);
		System.out.println(pet);
		param.put("aroundlist", aroundlist);
		param.put("pageNum", pageNum);
		param.put("limit", limit);
		param.put("startrow", startrow);
		System.out.println(object);
		param.put("sort", object);
		param.put("test", "조회순");
		return template.getMapper(cls).list2(param);
	}


	public int count2(String themelist, String pet, String aroundlist) {
		return template.getMapper(cls).count2(themelist,pet,aroundlist);
	}


	public Camp selectOne(int contentId) {
		return template.getMapper(cls).selectOne(contentId);
	}


	public void addcnt(int contentId) {
		template.getMapper(cls).addcnt(contentId);
	}


	public List<Camp> lovelist(Map<String, Object> param) {
		return template.getMapper(cls).lovelist(param);
	}

}
