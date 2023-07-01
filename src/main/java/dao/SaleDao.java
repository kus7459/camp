package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.SaleMapper;

@Repository
public class SaleDao {
	
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<String, Object>();
	private Class<SaleMapper> cls = SaleMapper.class;
	
	public int maxId() {
		return template.getMapper(cls).maxid();
	}

	public void insert(Integer saleid, String userid, Integer itemid, Integer quantity, Integer total,
			Integer postcode, String address, String detailaddress) {
		param.clear();
		param.put("saleid", saleid);
		param.put("userid",	userid);
		param.put("itemid", itemid);
		param.put("quantity", quantity);
		param.put("total", total);
		param.put("postcode", postcode);
		param.put("address", address);
		param.put("detailAddress", detailaddress);
		template.getMapper(cls).insert(param);
	}
}
