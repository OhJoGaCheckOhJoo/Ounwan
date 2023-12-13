package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.OunwanGram;
import com.ounwan.entity.OunwanGramLikes;

@Repository
public class CommunityDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.community.";

	public List<OunwanGram> gramFollowBoard(Map<String, Object> dataMap) {
		return sqlSession.selectList(NAMESPACE + "gramFollowBoard", dataMap);
	}

	public List<OunwanGram> gramWholeBoard(int rowNum) {
		return sqlSession.selectList(NAMESPACE + "gramWholeBoard", rowNum);
	}
	
	public List<Integer> gramLikeBoards(String clientId) {
		return sqlSession.selectList(NAMESPACE + "selectLikeBoards", clientId);
	}
	
	public List<String> hashTagsByNumber(int communityNumber) {
		return sqlSession.selectList(NAMESPACE + "selectHashTagsByNumber", communityNumber);
	}
	
	public OunwanGram aGramBoard(int communityNumber) {
		return sqlSession.selectOne(NAMESPACE + "selectOneBoard", communityNumber);
	}
	
	public OunwanGram selectBoardByCommunityNum(int communityNumber) {
		return sqlSession.selectOne(NAMESPACE + "selectBoardByCommunityNum", communityNumber);
	}
	
	public int addLikeOunwanBoard(OunwanGramLikes likes) {
		return sqlSession.insert(NAMESPACE + "insertgGramLikeBoard", likes);
	}

	public int writeGramBoard(OunwanGram board) {
		return sqlSession.insert(NAMESPACE + "insertGramBoard", board);
	}

	public int insertHashTagName(String name) {
		return sqlSession.insert(NAMESPACE + "insertHashTagName", name);
	}

	public int addHashTag(Map<String, Object> data) {
		return sqlSession.insert(NAMESPACE + "addHashTag", data);
	}
	
	public int cancelLikeOunwanBoard(String likesId) {
		return sqlSession.delete(NAMESPACE + "deleteGramLikeBoard", likesId);
	}

	public int removeTag(Map<String, Object> data) {
		return sqlSession.delete(NAMESPACE + "deleteHashTag", data);
	}
	
	public int deleteGramBoard(int communityNumber) {
		return sqlSession.delete(NAMESPACE + "deleteGramBoard", communityNumber);
	}
	
	public int updateGramBoard(OunwanGram board) {
		return sqlSession.update(NAMESPACE + "updateGramBoard", board);
	}
	
}
