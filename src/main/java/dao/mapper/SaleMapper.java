package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface SaleMapper {

	@Select("select ifnull(max(saleid),0) from sale")
	int maxid();

	@Insert("insert into sale (saleid, userid, itemid, quantity, total, postcode, address, detailAddress, saledate) "
			+ "value (#{saleid}, #{userid}, #{itemid}, #{quantity}, #{total}, #{postcode}, #{address}, #{detailAddress}, now())")
	void insert(Map<String, Object> param);


}
