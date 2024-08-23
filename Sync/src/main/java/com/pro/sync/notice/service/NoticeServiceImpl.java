package com.pro.sync.notice.service;

import java.util.List;

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
	public List<NoticeVo> selectNotice() {
		log.info("전체글 보기");
		return dao.selectNotice();
	}

	
	
}
