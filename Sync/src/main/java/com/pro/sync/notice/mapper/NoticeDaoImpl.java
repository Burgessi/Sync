package com.pro.sync.notice.mapper;

import java.util.List;

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
	public List<NoticeVo> selectNotice() {
		return session.selectList(NS + "selectNotice");
	}

}
