package com.pro.sync.reservations.mapper;



import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.reservations.vo.ReservationsVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReservationDaoImpl implements IReservationDao {
	
	private final SqlSessionTemplate session;
	private final String NS="com.pro.sync.reservations.mapper.ReservationsDaoImpl.";

	@Override
	public boolean insertRev(ReservationsVo vo) {
		int n = session.insert(NS + "insertRev", vo);
		return (n>0)?true:false;
	}

	@Override
	public int selectOverlap(ReservationsVo vo) {
		return session.selectOne(NS + "selectOverlap" ,vo);
	}

	@Override
	public List<ReservationsVo> selectMyRev(String emp_id) {
		return session.selectList(NS + "selectMyRev", emp_id);
	}

	@Override
	public List<ReservationsVo> currentUseRev() {
		return session.selectList(NS + "currentUseRev");
	}

	@Override
	public int deleteRev(List<String> rev_id) {
		return session.delete(NS + "deleteRev",rev_id);
	}


}
