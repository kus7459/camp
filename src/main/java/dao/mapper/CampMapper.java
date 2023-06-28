package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import logic.Camp;

public interface CampMapper {

	@Insert("insert ignore into campdetail "
			+ "(contentId,brazierCl,sbrsCl,posblFcltyCl,hvofBgnde,caravAcmpnyAt,toiletCo,"
			+ "swrmCo,hvofEnddle,featureNm,induty,lctCl,doNm,sigunguNm,addr1,"
			+ "tel,homepage,resveUrl,gnrlSiteCo,autoSiteCo,glampSiteCo,caravSiteCo,"
			+ "indvdlCaravSiteCo,siteBottomCl1,siteBottomCl2,siteBottomCl3,siteBottomCl4,siteBottomCl5,"
			+ "glampInnerFclty,caravInnerFclty,prmisnDe,operPdCl,operDeCl,intro,extshrCo,"
			+ "frprvtWrppCo,fireSensorCo,themaEnvrnCl,eqpmnLendCl,animalCmgCl,firstImageUrl,"
			+ "facltNm,lineIntro,bizrno,facltDivNm)"
			+ " values(#{contentId},#{brazierCl},#{sbrsCl},#{posblFcltyCl},#{hvofBgnde},#{caravAcmpnyAt},#{toiletCo},"
			+ "#{swrmCo},#{hvofEnddle},#{featureNm},#{induty},#{lctCl},#{doNm},#{sigunguNm},#{addr1},"
			+ "#{tel},#{homepage},#{resveUrl},#{gnrlSiteCo},#{autoSiteCo},#{glampSiteCo},#{caravSiteCo},"
			+ "#{indvdlCaravSiteCo},#{siteBottomCl1},#{siteBottomCl2},#{siteBottomCl3},#{siteBottomCl4},#{siteBottomCl5},"
			+ "#{glampInnerFclty},#{caravInnerFclty},#{prmisnDe},#{operPdCl},#{operDeCl},#{intro},#{extshrCo},"
			+ "#{frprvtWrppCo},#{fireSensorCo},#{themaEnvrnCl},#{eqpmnLendCl},#{animalCmgCl},#{firstImageUrl},"
			+ "#{facltNm},#{lineIntro},#{bizrno},#{facltDivNm})")
	void insert(Camp camp);

	@Select("<script> "
			+ "select * from campdetail where lctCl regexp #{loc} "
			+ " and induty like '%${csite}%'"
			+ " <if test='bot != null '> and ${bot} != '0' </if> "
			+ " <if test='operlist != null '> and facltDivNm REGEXP #{operlist} </if> "
			+ " <if test='themelist != null '> and themaEnvrnCl REGEXP #{themelist} </if> "
			+ " <if test='addlist != null '> and sbrsCl REGEXP #{addlist} </if>"
			+ " <if test='carav != null '> and caravAcmpnyAt = #{carav} </if> "
			+ " <if test='pet != null '> and animalCmgCl like '${pet}%' </if>"
//			+ " <if test='#{oper1}!= null'> and (facltDivNm like '%${oper1}%'"
//			+ " <if test='#{oper2}!= null'> or facltDivNm like '%${oper2}%'</if>"
//			+ " <if test='#{oper3}!= null'> or facltDivNm like '%${oper3}%'</if>"
//			+ " <if test='#{oper4}!= null'> or facltDivNm like '%${oper4}%'</if>"
//			+ " <if test='#{oper5}!= null'> or facltDivNm like '%${oper5}%'</if>"
//			+ ")</if>"
			+ " limit #{startrow}, #{limit}"
			+ " </script>")
	List<Camp> list(Map<String, Object> param2);

	@Select("<script> "
			+ "select count(*) from campdetail where lctCl regexp #{loc} "
			+ " and induty like '%${csite}%'"
			+ " <if test='bot != null '> and ${bot} != '0' </if> "
			+ " <if test='operlist != null '> and facltDivNm REGEXP #{operlist} </if> "
			+ " <if test='themelist != null '> and themaEnvrnCl REGEXP #{themelist} </if> "
			+ " <if test='addlist != null '> and sbrsCl REGEXP #{addlist} </if>"
			+ " <if test='carav != null '> and caravAcmpnyAt = #{carav} </if> "
			+ " <if test='pet != null '> and animalCmgCl like '${pet}%' </if>"
			+ " </script>")
	int count(Map<String, Object> param2);


}
