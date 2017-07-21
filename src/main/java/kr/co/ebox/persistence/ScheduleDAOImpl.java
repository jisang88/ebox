package kr.co.ebox.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.ebox.domain.ScheduleVO;

@Repository
public class ScheduleDAOImpl implements ScheduleDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "kr.co.ebox.mapper.ScheduleMapper";



	@Override
	public void insert(ScheduleVO schedule) {

		session.insert(namespace + ".insert", schedule);
	}



	@Override
	public void insertList(List<ScheduleVO> list) {

		session.insert(namespace + ".insertList", list);
	}



	@Override
	public void delete(int schNo) {

		session.delete(namespace + ".delete", schNo);
	}



	@Override
	public void update(ScheduleVO schedule) {

		session.update(namespace + ".update", schedule);
	}



	@Override
	public ScheduleVO selectById(int schNo) {

		return session.selectOne(namespace + ".selectById", schNo);
	}



	@Override
	public List<ScheduleVO> selectAll() {

		return session.selectList(namespace + ".selectAll");
	}



	@Override
	public List<ScheduleVO> selectByAno(Map<String, Object> map) {

		return session.selectList(namespace + ".selectByAno", map);
	}

	/*
	 * @Override public List<ScheduleVO> selectListForBooking(Booking booking) {
	 * 
	 * // map에는 tno(영화관 기본키)와 selDate (선택한 날짜) 키를 가진 map 이다/ // TODO
	 * Auto-generated method stub return session.selectList(namespace +
	 * ".selectListForBooking", booking); }
	 */

}
