package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.CoupungOptions;

@Repository
public class CoupungOptionsDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.coupungOption.";
	
	public List<CoupungOptions> selectOptions (int coupungNumber) {
		return sqlSession.selectList(NAMESPACE + "selectOptions", coupungNumber);
	}

	public List<CoupungOptions> getOptionByOptionId(int optionNumber) {
		return sqlSession.selectList(NAMESPACE + "getOptionByOptionId", optionNumber);
	}

	public int insertOption(CoupungOptions option) {
		return sqlSession.insert(NAMESPACE + "insertOption", option);
	}

	public int updateOption(CoupungOptions option) {
		return sqlSession.update(NAMESPACE + "updateOption", option);
	}

	public int deleteOption(int coupungNumber) {
		return sqlSession.delete(NAMESPACE + "deleteOption", coupungNumber);
	}
}
