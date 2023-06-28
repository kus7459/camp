package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Good;
import lombok.Delegate;

public interface GoodMapper {

	@Insert("insert into good"
			+ "(goodno,userId ,goodtype)"
			+ "values(#{goodno},#{userId},#{goodtype})")
	void insert(Good good);

	@Select("select count(*) from good"
			+ " where goodno=#{goodno} and userId=#{userId} and goodtype=#{goodtype}")
	int select(Good good);

	@Delete("delete from good"
			+ " where goodno=#{goodno} and userId=#{userId} and goodtype=#{goodtype}")
	void delete(Good good);
	@Select("select count(*) from good"
			+ "	where goodno=#{goodno} and goodtype=1")
	int count(Good good);

	
}
