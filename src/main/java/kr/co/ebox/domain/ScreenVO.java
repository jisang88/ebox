package kr.co.ebox.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ScreenVO {

	int scrNo;

	String scrType;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date scrBuyDt;// 구입날짜
	long scrPrice;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date scrSdate;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date scrEdate;

	MovieVO movie;



	public int getScrNo() {

		return scrNo;
	}



	public void setScrNo(int scrNo) {

		this.scrNo = scrNo;
	}



	public String getScrType() {

		return scrType;
	}



	public void setScrType(String scrType) {

		this.scrType = scrType;
	}



	public Date getScrBuyDt() {

		return scrBuyDt;
	}



	public void setScrBuyDt(Date scrBuyDt) {

		this.scrBuyDt = scrBuyDt;
	}



	public long getScrPrice() {

		return scrPrice;
	}



	public void setScrPrice(long scrPrice) {

		this.scrPrice = scrPrice;
	}



	public Date getScrSdate() {

		return scrSdate;
	}



	public void setScrSdate(Date scrSdate) {

		this.scrSdate = scrSdate;
	}



	public Date getScrEdate() {

		return scrEdate;
	}



	public void setScrEdate(Date scrEdate) {

		this.scrEdate = scrEdate;
	}



	public MovieVO getMovie() {

		return movie;
	}



	public void setMovie(MovieVO movie) {

		this.movie = movie;
	}



	@Override
	public String toString() {

		return "ScreenVO [scrNo=" + scrNo + ", scrType=" + scrType + ", scrBuyDt=" + scrBuyDt + ", scrPrice=" + scrPrice + ", scrSdate=" + scrSdate + ", scrEdate=" + scrEdate
				+ ", movie=" + movie + "]";
	}

}
