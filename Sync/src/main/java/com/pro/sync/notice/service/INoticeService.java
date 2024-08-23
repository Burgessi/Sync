package com.pro.sync.notice.service;

import java.util.List;

import com.pro.sync.notice.vo.NoticeVo;

public interface INoticeService {
	
	//전체글 보기
	public List<NoticeVo> selectNotice();

}
