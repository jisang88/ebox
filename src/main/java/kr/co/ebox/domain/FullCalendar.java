package kr.co.ebox.domain;

import java.util.List;

public class FullCalendar {
	private int aNo;
	private int scrNo;
	private List<ScheduleVO> scheduleList;



	public int getScrNo() {

		return scrNo;
	}



	public void setScrNo(int scrNo) {

		this.scrNo = scrNo;
	}



	public int getaNo() {

		return aNo;
	}



	public void setaNo(int aNo) {

		this.aNo = aNo;
	}



	public List<ScheduleVO> getScheduleList() {

		return scheduleList;
	}



	public void setScheduleList(List<ScheduleVO> scheduleList) {

		this.scheduleList = scheduleList;
	}



	@Override
	public String toString() {

		return "FullCalendar [aNo=" + aNo + ", scrNo=" + scrNo + ", scheduleList=" + scheduleList + "]";
	}

}
