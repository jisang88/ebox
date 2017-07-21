package kr.co.ebox.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.ebox.domain.ScheduleVO;
import kr.co.ebox.persistence.ScheduleDAO;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	private static final Logger logger = LoggerFactory.getLogger(ScheduleServiceImpl.class);

	@Autowired
	private ScheduleDAO dao;



	@Override
	public void write(ScheduleVO schedule) throws Exception {

		dao.insert(schedule);
	}



	@Override
	public void write(List<ScheduleVO> list) throws Exception {

		dao.insertList(list);
	}



	@Override
	public ScheduleVO read(Integer schNo) throws Exception {

		return dao.selectById(schNo);
	}



	@Override
	public void modify(ScheduleVO schedule) throws Exception {

		dao.update(schedule);
	}



	@Transactional
	@Override
	public void remove(String[] noArr) throws Exception {

		// TODO Auto-generated method stub
		int[] noIntArr = Arrays.stream(noArr).mapToInt(Integer::parseInt).toArray();
		for (int no : noIntArr) {
			dao.delete(no);
		}
	}



	@Override
	public List<ScheduleVO> readAll() throws Exception {

		return dao.selectAll();
	}



	@Override
	public List<ScheduleVO> getListByAno(Map<String, Object> map) throws Exception {

		return dao.selectByAno(map);
	}

	/*
	 * @Override public List<ScheduleVO> readForBooking(Booking booking) throws
	 * Exception {
	 * 
	 * return dao.selectListForBooking(booking); }
	 */

}
