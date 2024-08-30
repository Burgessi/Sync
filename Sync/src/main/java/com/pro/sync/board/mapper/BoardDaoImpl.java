package com.pro.sync.board.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.board.vo.BoardVo;

import lombok.RequiredArgsConstructor;



@Repository
@RequiredArgsConstructor
public class BoardDaoImpl implements IBoardDao {
	
	private final SqlSessionTemplate session;
	private final String NS ="com.pro.sync.board.mapper.BoardDaoImpl.";
	
	@Override
	public List<BoardVo> selectBoard(int startIndex, int pageSize) {
		int endIndex = startIndex + pageSize - 1;
		return session.selectList(NS + "selectBoard", Map.of("startIndex", startIndex, "endIndex", endIndex));
	}

	@Override
	public int totalCount() {
		return session.selectOne(NS + "totalCount");
	}

	@Override
	public BoardVo detailBoard(String bd_seq) {
		return session.selectOne(NS + "detailBoard", bd_seq);
	}

	@Override
	public int deleteBoard(List<String> bd_seqs) {
		return session.delete(NS + "deleteBoard", bd_seqs);
	}

	@Override
	public int insertComment(BoardVo vo) {
		return session.insert(NS + "insertComment", vo);
	}

	@Override
	public List<BoardVo> selectComment(String bd_seq) {
		return session.selectList(NS + "selectComment", bd_seq);
	}

	@Override
	public int deleteComment(Map<String, Object> map) {
		return session.delete(NS + "deleteComment", map);
	}

	@Override
	public int modifyComment(Map<String, Object> map) {
		return session.update(NS + "modifyComment", map);
	}

	@Override
	public List<BoardVo> searchBoard(Map<String, Object> map) {
		return session.selectList(NS +"searchBoard", map);
	}
	


	

}
