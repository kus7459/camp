package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Cart;
import logic.Item;

public interface CartMapper {
	
	@Insert("insert into cart (itemid, userid, name, price, pictureUrl, quantity) "
			+ "value(#{itemid},#{userid},#{name},#{price},#{pictureUrl},#{quantity})")
	void insert(Map<String, Object> param);

	@Select({"<script>",
			"select * from cart where userid = #{userid} ",
			"<if test='itemid != 0'> and itemid = #{itmeid}</if>",
			"</script>"})
	List<Cart> select(Map<String, Object> param);

	@Update("update cart set quantity = #{quantity} where userid=#{userid} and itemid=#{itemid}")
	void update(Map<String, Object> param);

	@Delete("delete from cart where itemid=#{itemid} and userid=#{userid}")
	void delete(Map<String, Object> param);
}
