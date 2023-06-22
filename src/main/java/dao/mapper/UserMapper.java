package dao.mapper;

import org.apache.ibatis.annotations.Insert;

import logic.User;

public interface UserMapper {

	@Insert("insert into user(id,pass,name,gender,tel,email,birth)"
			+ " values(#{id},#{pass},#{name},#{gender},#{tel},#{email},#{birth})")
	void insert(User user);

}
