package com.pro.sync.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pro.sync.notice.mapper.INoticeDao;
import com.pro.sync.notice.vo.NoticeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements INoticeService {
	
	private final INoticeDao dao;
	
	@Override
	public List<NoticeVo> selectNotice(int page, int countRow) {
	    log.info("공지사항 전체글 보기");
	    
	    // 현재 페이지의 첫 번째 항목 인덱스를 계산(페이지 번호가 1부터 시작한다고 가정)
	    int startIndex = (page - 1) * countRow + 1; 
	    return dao.selectNotice(startIndex, countRow);
	}

	@Override
	public int totalCount() {
		return dao.totalCount();
	}

	@Override
	public int deleteNotice(List<String> seqs) {
		log.info("게시글 삭제");
		return dao.deleteNotice(seqs);
	}

	@Override
	public NoticeVo detailNotice(String notice_seq) {
		log.info("게시글 선택");
		return dao.detailNotice(notice_seq);
	}

	@Override
	public boolean modifyNotice(Map<String, Object> map) {
		log.info("게시글 수정");
		return dao.modifyNotice(map);
	}
	
	@Override
	public int insertNotice(NoticeVo vo) {
		log.info("게시글 작성");
		return dao.insertNotice(vo);
	}

	@Override
	public int cntPin() {
		log.info("PIN의 갯수");
		return dao.cntPin();
	}

	@Override
	public int noticePin(List<String> seq) {
		log.info("공지사항 고정");
		return dao.noticePin(seq);
	}

	@Override
	public int noticePinCancel(List<String> seq) {
		log.info("공지사항 고정 내리기");
		return dao.noticePinCancel(seq);
	}

	@Override
	public List<NoticeVo> searchNotice(Map<String, Object> map) {
		log.info("공지 검색");
		return dao.searchNotice(map);
	}

	
	
	
	
	

	
	
	
}
