package com.ounwan.repository;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.dto.AetaDTO;
import com.ounwan.entity.Aeta;
import com.ounwan.entity.AetaImages;
import com.ounwan.entity.AetaLikes;
import com.ounwan.entity.Comments;  

@Repository
public class CommunityDAO {

	@Autowired
	SqlSession sqlsession;
	private static final String NAMESPACE = "net.ounwan.community.";
	
	//게시판 조회
	public List<AetaDTO> AetaList(Map<String, Object> paginateParams) {
		return sqlsession.selectList(NAMESPACE+"AetaList",paginateParams );
	}
	
	//게시판 검색기능
	public List<Aeta> aetaSearchAll(Map<String, Object> paginateParams){		
		return sqlsession.selectList(NAMESPACE+"AetaSearchAll",paginateParams);
	}
	public List<Aeta> aetaSearchTitle(Map<String, Object> paginateParams){
		return sqlsession.selectList(NAMESPACE+"AetaSearchTitle",paginateParams);
	}
	public List<Aeta> aetaSearchId(Map<String, Object> paginateParams){
		return sqlsession.selectList(NAMESPACE+"AetaSearchId",paginateParams);
	}
	
	
	
	//게시글 조회
	public List<Map<String, Object>> aetaReadPost(int boardNumber){
		
		return sqlsession.selectList(NAMESPACE+"AetaReadPost", boardNumber);
	}
	public int aetaCountLikes(int boardNumber) {
		return sqlsession.selectOne(NAMESPACE+"AetaCountLikes",boardNumber);
	}
	public int aetaLikesCheck(AetaLikes aetaLikesDTO) {
		return sqlsession.selectOne(NAMESPACE+"AetaLikesCheck",aetaLikesDTO);
	}
	public int aetaLike(AetaLikes aetaLikesDTO) {
		return sqlsession.insert(NAMESPACE+"AetaLike",aetaLikesDTO);
	}
	public int aetaDislike(AetaLikes aetaLikesDTO) {
		return sqlsession.delete(NAMESPACE+"AetaDislike",aetaLikesDTO);
	}
	
	//게시글 등록
	public int aetaInsertPost(Aeta post) {
		return sqlsession.insert(NAMESPACE+"AetaInsertPost",post);
	}
	public int aetaInsertImageURL(String images) {
		return sqlsession.insert(NAMESPACE+"AetaInsertImageURL",images);
	}
	
	//게시글 조회수 증가
	public int aetaUpdateViews(int boardNumber) {
		return sqlsession.update(NAMESPACE+"AetaUpdateView",boardNumber);
	}
	
	//게시글 댓글 등록/삭제
	public int aetaInsertComment(Comments comment) {
		return sqlsession.insert(NAMESPACE+"AetaInsertComment", comment);
	}
	public int aetaDeleteComment(Comments comment) {
		return sqlsession.delete(NAMESPACE+"AetaDeleteComment",comment);
	}
	

	//게시글 수정 시 보여줄 데이터
	public List<Map<String, Object>> aetaPostToBeUpdated(int boardNumber){
		return sqlsession.selectList(NAMESPACE+"AetaPostToBeUpdated",boardNumber);
	}
	//게시글 수정 // title,contents,boardNumber 
	public int aetaUpdatePost(Aeta post) {
		return sqlsession.update(NAMESPACE+"AetaUpdatePost", post);
	}
	//게시글 이미지url 수정 // imageUrl,boardNumber
	public int aetaUpdatePostURL(AetaImages aetaImages) {
		return sqlsession.update(NAMESPACE+"AetaUpdatePostURL",aetaImages);
	}
	

	
	//게시글 삭제
	public int aetaDeletePost(int boardNumber) {
		return sqlsession.delete(NAMESPACE+"AetaDeletePost",boardNumber);
	}



	
	public int CountAllPosts() {
		return sqlsession.selectOne(NAMESPACE+"AetaCountAllPosts");
	}
	public int CountSearchAll(String inputValue) {
		return sqlsession.selectOne(NAMESPACE+"AetaCountSearchAll",inputValue);
	}
	public int CountSearchTitle(String inputValue) {
		return sqlsession.selectOne(NAMESPACE+"AetaCountSearchTitle",inputValue);
	}
	public int CountSearchId(String inputValue) {
		return sqlsession.selectOne(NAMESPACE+"AetaCountSearchId",inputValue);
	}
	
	
	private String addPercentage(String inputValue) {
		return "%"+inputValue+"%";
	}

	
	public String findClientId(int boardNumber) {
		return sqlsession.selectOne(NAMESPACE+"FindClientId"+boardNumber);
	}
}
	
	





