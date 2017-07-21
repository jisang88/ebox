package kr.co.ebox.domain;

import java.util.Calendar;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ScheduleVO {

	int schNo;
	String schStart;
	String schEnd;
	String schType;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date schDate;

	AuditoriumVO audi;
	ScreenVO screen;



	public String getSchType() {

		return schType;
	}



	public void setSchType(String schType) {

		this.schType = schType;
	}



	public int getSchNo() {

		return schNo;
	}



	public void setSchNo(int schNo) {

		this.schNo = schNo;
	}



	public String getSchStart() {

		return schStart;
	}



	public void setSchStart(String schStart) {

		this.schStart = schStart;
	}



	public String getSchEnd() {

		return schEnd;
	}



	public void setSchEnd(String schEnd) {

		this.schEnd = schEnd;
	}



	public Date getSchDate() {

		return schDate;
	}



	public void setSchDate(Date schDate) {

		this.schDate = removeTime(schDate);

	}



	public static Date removeTime(Date date) {

		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}



	public AuditoriumVO getAudi() {

		return audi;
	}



	public void setAudi(AuditoriumVO audi) {

		this.audi = audi;
	}



	public ScreenVO getScreen() {

		return screen;
	}



	public void setScreen(ScreenVO screen) {

		this.screen = screen;
	}



	@Override
	public String toString() {

		return "ScheduleVO [schNo=" + schNo + ", schStart=" + schStart + ", schEnd=" + schEnd + ", schType=" + schType + ", schDate=" + schDate + ", audi=" + audi + ", screen="
				+ screen + "]";
	}

}
