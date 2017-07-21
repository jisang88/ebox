package kr.co.ebox.persistence;

import java.util.List;
import java.util.Map;

import kr.co.ebox.domain.ScheduleVO;

public interface ScheduleDAO {

	void insert(ScheduleVO schedule);



	void insertList(List<ScheduleVO> list);



	void delete(int schNo);



	void update(ScheduleVO schedule);



	ScheduleVO selectById(int schNo);



	List<ScheduleVO> selectAll();



	List<ScheduleVO> selectByAno(Map<String, Object> map);

	// List<ScheduleVO> selectListForBooking(Booking booking);

}
