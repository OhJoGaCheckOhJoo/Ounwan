package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Inbody;
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
	
	public List<Map<String, Object>> searchGramClientId(String keyword) {
		return sqlSession.selectList(NAMESPACE + "searchGramClientId", keyword);
	}
	
	public List<Map<String, Object>> getProfileBoard(Map<String, Object> data) {
		return sqlSession.selectList(NAMESPACE + "getProfileBoard", data);
	}
	
	public List<OunwanGram> selectBoardsByTag(Map<String, Object> data) {
		return sqlSession.selectList(NAMESPACE + "selectBoardsByTag", data);
	}
	
	public List<Inbody> selectMyInbody(String clientId) {
		return sqlSession.selectList(NAMESPACE + "selectMyInbody", clientId);
	}
	
	public int checkFollow(Map<String, Object> data) {
		return sqlSession.selectOne(NAMESPACE + "checkFollow", data);
	}
	
	public Map<String, Object> searchHashTag(String keyword) {
		return sqlSession.selectOne(NAMESPACE + "searchHashTag", keyword); 
	}
	
	public OunwanGram aGramBoard(int communityNumber) {
		return sqlSession.selectOne(NAMESPACE + "selectOneBoard", communityNumber);
	}
	
	public OunwanGram selectBoardByCommunityNum(int communityNumber) {
		return sqlSession.selectOne(NAMESPACE + "selectBoardByCommunityNum", communityNumber);
	}
	
	public Map<String, Object> getUserProfileInfo(String profileId) {
		return sqlSession.selectOne(NAMESPACE + "getUserProfileInfo", profileId);
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

	public int reportBoard(Map<String, Object> data) {
		return sqlSession.insert(NAMESPACE + "reportGramBoard", data);
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
