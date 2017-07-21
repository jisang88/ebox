package kr.co.ebox.domain;

public class TheaterVO {

	int tNo;
	String tName;
	String tAddrNum;
	String tAddrSt;
	String tManager;
	String tTel;



	public int gettNo() {

		return tNo;
	}



	public void settNo(int tNo) {

		this.tNo = tNo;
	}



	public String gettName() {

		return tName;
	}



	public void settName(String tName) {

		this.tName = tName;
	}



	public String gettAddrNum() {

		return tAddrNum;
	}



	public void settAddrNum(String tAddrNum) {

		this.tAddrNum = tAddrNum;
	}



	public String gettAddrSt() {

		return tAddrSt;
	}



	public void settAddrSt(String tAddrSt) {

		this.tAddrSt = tAddrSt;
	}



	public String gettManager() {

		return tManager;
	}



	public void settManager(String tManager) {

		this.tManager = tManager;
	}



	public String gettTel() {

		return tTel;
	}



	public void settTel(String tTel) {

		this.tTel = tTel;
	}



	@Override
	public String toString() {

		return "TheaterVO [tNo=" + tNo + ", tName=" + tName + ", tAddrNum=" + tAddrNum + ", tAddrSt=" + tAddrSt + ", tManager=" + tManager + ", tTel=" + tTel + "]";
	}

}
