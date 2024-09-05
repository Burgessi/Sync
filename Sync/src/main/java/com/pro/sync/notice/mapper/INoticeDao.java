package com.pro.sync.notice.mapper;

import java.util.List;
import java.util.Map;

import com.pro.sync.notice.vo.NoticeVo;

public interface INoticeDao {
	
	//전체글 보기
	public List<NoticeVo> selectNotice(int startIndex, int pageSize);
	
	//전체 공지사항 갯수
	public int totalCount();
	
	//게시글 삭제
	public int deleteNotice(List<String> seqs);
	
	//게시글 상세보기 
	public NoticeVo detailNotice(String notice_seq);
	
	//게시글 수정 
	public boolean modifyNotice(Map<String, Object> map);
	
	//게시글 작성
	public int insertNotice(NoticeVo vo);
	
	//핀 갯수 가져오기 
	public int cntPin();
	
	//공지 게시글 고정
	public int noticePin(List<String> seq);
	
	//공지 게시글 고정 내리기
	public int noticePinCancel(List<String> seq);
	
	//공지 게시글 검색
	public List<NoticeVo> searchNotice(Map<String, Object>map);
	
	//메인 공지
	public List<NoticeVo> mainNotice();
	
	
	

}
