package kr.co.ebox.service;

import java.util.List;
import java.util.Map;

import kr.co.ebox.domain.ScheduleVO;

public interface ScheduleService {

	public void write(ScheduleVO schedule) throws Exception;



	public void write(List<ScheduleVO> list) throws Exception;



	public ScheduleVO read(Integer schNo) throws Exception;



	public void modify(ScheduleVO screen) throws Exception;



	public void remove(String[] noArr) throws Exception;



	public List<ScheduleVO> readAll() throws Exception;



	public List<ScheduleVO> getListByAno(Map<String, Object> map) throws Exception;

	// public List<ScheduleVO> readForBooking(Booking booking) throws Exception;

}
