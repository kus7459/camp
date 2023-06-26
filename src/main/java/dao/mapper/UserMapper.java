package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {

	@Insert("insert into user(id,pass,name,gender,tel,email,birth)"
			+ " values(#{id},#{pass},#{name},#{gender},#{tel},#{email},#{birth})")
	void insert(User user);

	@Select("select * from user where id = #{value}")
	User selectUserOne(String id);

	@Update("update user set name=#{name}, pass=#{pass}, birth=#{birth}, "
			+ "tel=#{tel}, email=#{email} where id=#{id}")
	void update(User user);

	@Update("update user set pass=#{pass} where id=#{id}")
	void chgpass(Map<String, Object> param);

	@Update("update user set lastlog=now() where id=#{value}")
	void logupdate(String id);

	@Delete("delete from user where id=#{id}")
	void delete(Map<String, Object> param);

	@Select({"<script>",
		"select ${col} from user where email=#{email} and tel=#{tel} ",
		"<if test='id !=null'> and id=#{id}</if> ",
		"</script>"
	})
	String search(Map<String, Object> param);
	
}
