package kr.co.ebox.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MovieVO {
	int mNo;
	String mNm;
	String mNmEn;
	String mDirector;
	String mActors;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date mOpenDt;

	String mShowTm;
	String mWatchGradeNm;
	String mNationNm;
	String mGenreNm;
	String mStory;



	public int getmNo() {

		return mNo;
	}



	public void setmNo(int mNo) {

		this.mNo = mNo;
	}



	public String getmNm() {

		return mNm;
	}



	public void setmNm(String mNm) {

		this.mNm = mNm;
	}



	public String getmNmEn() {

		return mNmEn;
	}



	public void setmNmEn(String mNmEn) {

		this.mNmEn = mNmEn;
	}



	public String getmDirector() {

		return mDirector;
	}



	public void setmDirector(String mDirector) {

		this.mDirector = mDirector;
	}



	public String getmActors() {

		return mActors;
	}



	public void setmActors(String mActors) {

		this.mActors = mActors;
	}



	public Date getmOpenDt() {

		return mOpenDt;
	}



	public void setmOpenDt(Date mOpenDt) {

		this.mOpenDt = mOpenDt;
	}



	public String getmShowTm() {

		return mShowTm;
	}



	public void setmShowTm(String mShowTm) {

		this.mShowTm = mShowTm;
	}



	public String getmWatchGradeNm() {

		return mWatchGradeNm;
	}



	public void setmWatchGradeNm(String mWatchGradeNm) {

		this.mWatchGradeNm = mWatchGradeNm;
	}



	public String getmNationNm() {

		return mNationNm;
	}



	public void setmNationNm(String mNationNm) {

		this.mNationNm = mNationNm;
	}



	public String getmGenreNm() {

		return mGenreNm;
	}



	public void setmGenreNm(String mGenreNm) {

		this.mGenreNm = mGenreNm;
	}



	public String getmStory() {

		return mStory;
	}



	public void setmStory(String mStory) {

		this.mStory = mStory;
	}



	@Override
	public String toString() {

		return "MovieVO [mNo=" + mNo + ", mNm=" + mNm + ", mNmEn=" + mNmEn + ", mDirector=" + mDirector + ", mActors=" + mActors + ", mOpenDt=" + mOpenDt + ", mShowTm=" + mShowTm
				+ ", mWatchGradeNm=" + mWatchGradeNm + ", mNationNm=" + mNationNm + ", mGenreNm=" + mGenreNm + ", mStory=" + mStory + "]";
	}

}
