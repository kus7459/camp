package dao.mapper;

import org.apache.ibatis.annotations.Insert;

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

}
