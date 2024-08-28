package com.pro.sync.plan.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.plan.vo.ScheduleVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ScheduleDaoImpl implements IScheduleDao {
	
	private final SqlSessionTemplate session;
	private final String NS = "com.pro.sync.plan.mapper.ScheduleDaoImpl.";
	
	@Override
	public List<ScheduleVo> selectScd() {
		return session.selectList(NS +"selectScd");
	}

	@Override
	public int addScd(ScheduleVo vo) {
		return session.insert(NS + "addScd", vo);
	}

	@Override
	public ScheduleVo detailScd(int scd_no) {
		return session.selectOne(NS + "detailScd", scd_no);
	}

	@Override
	public int delScd(int scd_no) {
		return session.delete(NS + "delScd", scd_no);
	}

	@Override
	public boolean updateScd(Map<String, Object> map) {
		int n = session.update(NS + "updateScd", map);
		return (n==1)?true:false;
	}


	


}
