package com.pro.sync.notice.mapper;

import java.util.List;

import com.pro.sync.notice.vo.NoticeVo;

public interface INoticeDao {
	
	//전체글 보기
	public List<NoticeVo> selectNotice();

}
