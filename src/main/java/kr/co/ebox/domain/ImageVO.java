package kr.co.ebox.domain;

import java.util.Date;

public class ImageVO {

	int iNo;
	String iPath;
	Date iRegdate;
	String iType;
	int refMno;

	public static final String TYPE_POSTER = "poster";
	public static final String TYPE_H_POSTER = "horizontal poster";
	public static final String TYPE_STILLCUT = "still cut";

	public static final String TYPE_EVENT = "event";
	public static final String TYPE_VIDEO = "video";

	

	public int getiNo() {

		return iNo;
	}



	public void setiNo(int iNo) {

		this.iNo = iNo;
	}



	public String getiPath() {

		return iPath;
	}



	public void setiPath(String iPath) {

		this.iPath = iPath;
	}



	public Date getiRegdate() {

		return iRegdate;
	}



	public void setiRegdate(Date iRegdate) {

		this.iRegdate = iRegdate;
	}



	public String getiType() {

		return iType;
	}



	public void setiType(String iType) {

		this.iType = iType;
	}



	public int getRefMno() {

		return refMno;
	}



	public void setRefMno(int refMno) {

		this.refMno = refMno;
	}



	@Override
	public String toString() {

		return "ImageVO [iNo=" + iNo + ", iPath=" + iPath + ", iRegdate=" + iRegdate + ", iType=" + iType + ", refMno=" + refMno + "]";
	}

}
