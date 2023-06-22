package dao;

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
	
	
	public void insert(Camp camp) {
		template.getMapper(cls).insert(camp);
	}
}
