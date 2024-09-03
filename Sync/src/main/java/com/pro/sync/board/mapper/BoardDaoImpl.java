package com.pro.sync.board.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.board.vo.BoardVo;
import com.pro.sync.board.vo.FileBoardVo;

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

	@Override
	public boolean insertBoard(BoardVo bvo) {
		int n = session.insert(NS + "insertBoard", bvo);
		return (n>0)?true:false;
	}

	@Override
	public boolean fileInsert(List<FileBoardVo> fileList, int bd_seq, String emp_id) {
		
		 Map<String, Object> params = new HashMap<>();
		 params.put("list", fileList);
		 params.put("bd_seq", bd_seq);
		 params.put("emp_id", emp_id);
		
		int m = session.insert(NS + "fileInsert", params);
		return (m>0)?true:false;
	}

	@Override
	public boolean modifyBoard(Map<String, Object> map) {
		int n = session.update(NS + "modifyBoard", map);
		return (n>0)?true:false;
	}

	@Override
	public int deleteFile(int file_seq) {	
		return session.delete(NS + "deleteFile", file_seq);
	}

	@Override
	public FileBoardVo selectFile(int file_seq) {
		return session.selectOne(NS + "selectFile", file_seq);
	}
	


	

}
