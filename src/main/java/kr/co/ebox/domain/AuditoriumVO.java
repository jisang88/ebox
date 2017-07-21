package kr.co.ebox.domain;

public class AuditoriumVO {

	int aNo;
	String aName;

	String aSType;
	String aVType;

	String aTheme;
	String aThemeSubInfo;

	String floor;

	TheaterVO theater;



	public int getaNo() {

		return aNo;
	}



	public void setaNo(int aNo) {

		this.aNo = aNo;
	}



	public String getaName() {

		return aName;
	}



	public void setaName(String aName) {

		this.aName = aName.trim();
	}



	public String getaSType() {

		return aSType;
	}



	public void setaSType(String aSType) {

		this.aSType = aSType.trim();
	}



	public String getaVType() {

		return aVType;
	}



	public void setaVType(String aVType) {

		this.aVType = aVType.trim();
	}



	public String getaTheme() {

		return aTheme;
	}



	public void setaTheme(String aTheme) {

		this.aTheme = aTheme.trim();
	}



	public String getaThemeSubInfo() {

		return aThemeSubInfo;
	}



	public void setaThemeSubInfo(String aThemeSubInfo) {

		this.aThemeSubInfo = aThemeSubInfo.trim();
	}



	public String getFloor() {

		return floor;
	}



	public void setFloor(String floor) {

		this.floor = floor.trim();
	}



	public TheaterVO getTheater() {

		return theater;
	}



	public void setTheater(TheaterVO theater) {

		this.theater = theater;
	}



	@Override
	public String toString() {

		return "AuditoriumVO [aNo=" + aNo + ", aName=" + aName + ", aSType=" + aSType + ", aVType=" + aVType + ", aTheme=" + aTheme + ", aThemeSubInfo=" + aThemeSubInfo
				+ ", floor=" + floor + ", theater=" + theater + "]";
	}

}
