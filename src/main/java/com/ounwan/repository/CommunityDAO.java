package com.ounwan.repository;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.AetaBoards;
import com.ounwan.entity.AetaImages;
import com.ounwan.entity.Comments;

@Repository
public class CommunityDAO {

	@Autowired
	SqlSession sqlsession;
	private static final String NAMESPACE = "net.ounwan.community.";
	
	
	public List<AetaBoards> aetaBoardList() {
		return sqlsession.selectList(NAMESPACE + "AetaList");
	}
	
	private String addPercentage(String inputValue) {
		return "%"+inputValue+"%";
	}
	public List<AetaBoards> aetaSearchAll(String inputValue){
		inputValue=addPercentage(inputValue);
		return sqlsession.selectList(NAMESPACE+"AetaSearchAll",inputValue);
	}
	public List<AetaBoards> aetaSearchTitle(String inputValue){
		inputValue=addPercentage(inputValue);
		return sqlsession.selectList(NAMESPACE+"AetaSearchTitle",inputValue);
	}
	public List<AetaBoards> aetaSearchId(String inputValue){
		inputValue=addPercentage(inputValue);
		return sqlsession.selectList(NAMESPACE+"AetaSearchId",inputValue);
	}
	public List<Map<String, Object>> aetaReadPost(int boardNumber){
		
		return sqlsession.selectList(NAMESPACE+"AetaReadPost", boardNumber);
	}
	public int aetaInsertComment(Comments comment) {
		return sqlsession.insert(NAMESPACE+"AetaInsertComment", comment);
	}
	public int aetaDeleteComment(int commentId) {
		return sqlsession.delete(NAMESPACE+"AetaDeleteComment",commentId);
	}
	public int aetaUpdateViews(int boardNumber) {
		return sqlsession.update(NAMESPACE+"AetaUpdateView",boardNumber);
	}
	public int aetaInsertPost(AetaBoards post) {
		System.out.println("insertPost dao");
		return sqlsession.insert(NAMESPACE+"AetaInsertPost",post);
	}
	public int aetaDeletePost(int boardNumber) {
		return sqlsession.delete(NAMESPACE+"AetaDeletePost",boardNumber);
	}
	
	public int aetaInsertImageURL(AetaImages images) {
		return sqlsession.insert(NAMESPACE+"AetaInsertImageURL",images);
	}
	
}




