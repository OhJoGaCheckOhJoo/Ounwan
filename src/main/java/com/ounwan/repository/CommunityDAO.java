package com.ounwan.repository;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.AetaBoards;

@Repository
public class CommunityDAO {

	@Autowired
	SqlSession sqlsession;
	private static final String NAMESPACE = "net.ounwan.community.";
	
	
	public List<AetaBoards> aetaBoardList() {
		return sqlsession.selectList(NAMESPACE + "AetaList");
	}
	public List<AetaBoards> aetaSearchAll(String searchWord){
		searchWord="%"+searchWord+"%";
		return sqlsession.selectList(NAMESPACE+"AetaSearchAll",searchWord);
	}
	public List<AetaBoards> aetaSearchTitle(String searchWord){
		searchWord="%"+searchWord+"%";
		return sqlsession.selectList(NAMESPACE+"AetaSearchTitle",searchWord);
	}
	public List<AetaBoards> aetaSearchId(String searchWord){
		searchWord= "%"+searchWord+"%";
		return sqlsession.selectList(NAMESPACE+"AetaSearchId",searchWord);
	}
	
}




