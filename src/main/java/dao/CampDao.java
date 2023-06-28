package dao;

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
		return template.getMapper(cls).count(param2);
	}


	public List<Camp> list2(String themelist, String pet, String aroundlist, Integer pageNum, int limit, int startrow) {
		param.clear();
		param.put("themelist", themelist);
		param.put("pet", pet);
		param.put("aroundlist", aroundlist);
		param.put("pageNum", pageNum);
		param.put("limit", limit);
		param.put("startrow", startrow);
		return template.getMapper(cls).list2(themelist,pet,aroundlist,pageNum,limit,startrow);
	}


	public int count2(String themelist, String pet, String aroundlist) {
		return template.getMapper(cls).count2(themelist,pet,aroundlist);
	}

}
