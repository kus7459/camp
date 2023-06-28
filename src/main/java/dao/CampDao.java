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
}
