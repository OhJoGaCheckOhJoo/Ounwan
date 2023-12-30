package com.ounwan.repository;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Aeta;
import com.ounwan.entity.AetaImages;
import com.ounwan.entity.AetaLikes;
import com.ounwan.entity.Comments;
import com.ounwan.entity.Inbody;
import com.ounwan.entity.OunwanGram;
import com.ounwan.entity.OunwanGramLikes;

@Repository
public class CommunityDAO {

	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.community.";

	// 게시판 조회
	public List<Aeta> AetaList(Map<String, Object> paginateParams) {
		return sqlSession.selectList(NAMESPACE + "AetaList", paginateParams);
	}

	// 게시판 검색기능
	public List<Aeta> aetaSearchAll(Map<String, Object> paginateParams) {
		return sqlSession.selectList(NAMESPACE + "AetaSearchAll", paginateParams);
	}

	public List<Aeta> aetaSearchTitle(Map<String, Object> paginateParams) {
		return sqlSession.selectList(NAMESPACE + "AetaSearchTitle", paginateParams);
	}

	public List<Aeta> aetaSearchId(Map<String, Object> paginateParams) {
		return sqlSession.selectList(NAMESPACE + "AetaSearchId", paginateParams);
	}

	// 게시글 조회
	public List<Map<String, Object>> aetaReadPost(int aetaNumber) {
		return sqlSession.selectList(NAMESPACE + "AetaReadPost", aetaNumber);
	}

	public int aetaCountLikes(int boardNumber) {
		return sqlSession.selectOne(NAMESPACE + "AetaCountLikes", boardNumber);
	}

	public int aetaLikesCheck(AetaLikes aetaLikes) {
		return sqlSession.selectOne(NAMESPACE + "AetaLikesCheck", aetaLikes);
	}

	public int aetaLike(AetaLikes aetaLikes) {
		return sqlSession.insert(NAMESPACE + "AetaLike", aetaLikes);
	}

	public int aetaDislike(AetaLikes aetaLikes) {
		return sqlSession.delete(NAMESPACE + "AetaDislike", aetaLikes);
	}

	// 게시글 등록
	public int aetaInsertPost(Aeta post) {
		return sqlSession.insert(NAMESPACE + "AetaInsertPost", post);
	}

	public int aetaInsertImageUrls(Map<String, Object> url) {
		return sqlSession.insert(NAMESPACE + "AetaInsertImageUrls", url);
	}

	// 게시글 조회수 증가
	public int aetaUpdateViews(int boardNumber) {
		return sqlSession.update(NAMESPACE + "AetaUpdateView", boardNumber);
	}

	// 게시글 수정 시 보여줄 데이터
	public List<Map<String, Object>> aetaPostToBeUpdated(int boardNumber) {
		return sqlSession.selectList(NAMESPACE + "AetaPostToBeUpdated", boardNumber);
	}

	// 게시글 수정 // title,contents,boardNumber
	public int aetaUpdatePost(Aeta post) {
		return sqlSession.update(NAMESPACE + "AetaUpdatePost", post);
	}

	// 게시글 이미지url 수정 // imageUrl,boardNumber
	public int aetaDeleteImageUrls(int aetaNumber) {
		return sqlSession.delete(NAMESPACE + "AetaDeleteImageUrls", aetaNumber);
	}

	// 게시글 신고 (update visibility to 0, Reason(null)to reason)
	public int aetaReport(Aeta aeta) {
		return sqlSession.update(NAMESPACE + "AetaUpdateVisibilityAndReason", aeta);
	}

	// 게시글 삭제
	public int aetaDeletePost(int boardNumber) {
		return sqlSession.delete(NAMESPACE + "AetaDeletePost", boardNumber);
	}

	// 댓글 조회
	public List<Map<String, Object>> aetaReadComments(int aetaNumber) {
		return sqlSession.selectList(NAMESPACE + "AetaReadComments", aetaNumber);
	}

	// 댓글 갯수
	public int aetaCountComments(int aetaNumber) {
		return sqlSession.selectOne(NAMESPACE + "AetaCountComments", aetaNumber);
	}

	// 게시글 댓글 등록/삭제
	public int aetaInsertComment(Comments comment) {
		return sqlSession.insert(NAMESPACE + "AetaInsertComment", comment);
	}

	public int aetaDeleteComment(Comments comment) {
		return sqlSession.delete(NAMESPACE + "AetaDeleteComment", comment);
	}

	public int CountAllPosts() {
		return sqlSession.selectOne(NAMESPACE + "AetaCountAllPosts");
	}

	public int CountSearchAll(String inputValue) {
		return sqlSession.selectOne(NAMESPACE + "AetaCountSearchAll", inputValue);
	}

	public int CountSearchTitle(String inputValue) {
		return sqlSession.selectOne(NAMESPACE + "AetaCountSearchTitle", inputValue);
	}

	public int CountSearchId(String inputValue) {
		return sqlSession.selectOne(NAMESPACE + "AetaCountSearchId", inputValue);
	}

	public String findClientId(int aetaNumber) {
		return sqlSession.selectOne(NAMESPACE + "FindClientId" + aetaNumber);
	}

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

	public List<Map<String, Object>> selectFollowerList(Map<String, Object> data) {
		return sqlSession.selectList(NAMESPACE + "selectFollowerList", data);
	}

	public List<Map<String, Object>> selectFollowingList(Map<String, Object> data) {
		return sqlSession.selectList(NAMESPACE + "selectFollowingList", data);
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

	public String getProfileImage(String profileId) {
		return sqlSession.selectOne(NAMESPACE + "getProfileImage", profileId);
	}

	public OunwanGram selectOunwangramBoardDetail(Map<String, Object> data) {
		return sqlSession.selectOne(NAMESPACE + "selectOunwangramBoardDetail", data);
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

	public int insertInbody(Inbody inbody) {
		return sqlSession.insert(NAMESPACE + "insertInbody", inbody);
	}

	public int addFollowing(Map<String, Object> data) {
		return sqlSession.insert(NAMESPACE + "addFollowing", data);
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

	public int cancelFollowing(Map<String, Object> data) {
		return sqlSession.delete(NAMESPACE + "cancelFollowing", data);
	}

	public int updateGramBoard(OunwanGram board) {
		return sqlSession.update(NAMESPACE + "updateGramBoard", board);
	}

	public int updateInbody(Inbody inbody) {
		return sqlSession.update(NAMESPACE + "updateInbody", inbody);
	}

}
