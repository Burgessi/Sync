package com.pro.sync.notice.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.notice.vo.NoticeVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NoticeDaoImpl implements INoticeDao {
	
	private final SqlSessionTemplate session;
	private final String NS = "com.pro.sync.notice.mapper.NoticeDaoImpl.";
	
	@Override
	public List<NoticeVo> selectNotice(int startIndex, int pageSize) {
	    int endIndex = startIndex + pageSize - 1; //현재 페이지의 마지막 항목 인덱스를 계산
	    return session.selectList(NS + "selectNotice", Map.of("startIndex", startIndex, "endIndex", endIndex));
	}

	@Override
	public int totalCount() {
		return session.selectOne(NS + "totalCount");
	}

	@Override
	public int deleteNotice(List<String> seqs) {
		return session.delete(NS + "deleteNotice", seqs);
	}

	@Override
	public NoticeVo detailNotice(String notice_seq) {
		return session.selectOne(NS + "detailNotice", notice_seq);
	}

	@Override
	public boolean modifyNotice(Map<String, Object> map) {
		int n = session.update(NS + "modifyNotice", map);
		return (n>0)?true:false;
	}
	
	@Override
	public int insertNotice(NoticeVo vo) {
		return session.insert(NS + "insertNotice", vo);
	}
	
	@Override
	public int cntPin() {		
		return session.selectOne(NS + "cntPin");
	}

	@Override
	public int noticePin(List<String> seq) {
		return session.update(NS + "noticePin",seq);
	}

	@Override
	public int noticePinCancel(List<String> seq) {
		return session.update(NS + "noticePinCancel",seq);
	}

	@Override
	public List<NoticeVo> searchNotice(Map<String, Object> map) {
		return session.selectList(NS + "searchNotice", map);
	}


	
}
