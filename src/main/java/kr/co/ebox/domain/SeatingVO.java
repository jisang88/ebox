package kr.co.ebox.domain;

public class SeatingVO {

	int sno;
	int row;
	int col;
	String position;
	String stype;
	AuditoriumVO audi;



	public int getSno() {

		return sno;
	}



	public void setSno(int sno) {

		this.sno = sno;
	}



	public int getRow() {

		return row;
	}



	public void setRow(int row) {

		this.row = row;
	}



	public int getCol() {

		return col;
	}



	public void setCol(int col) {

		this.col = col;
	}



	public AuditoriumVO getAudi() {

		return audi;
	}



	public void setAudi(AuditoriumVO audi) {

		this.audi = audi;
	}



	public String getPosition() {

		return position;
	}



	public void setPosition(String position) {

		this.position = position;
	}



	public String getStype() {

		return stype;
	}



	public void setStype(String stype) {

		this.stype = stype;
	}



	@Override
	public String toString() {

		return "SeatingVO [sno=" + sno + ", row=" + row + ", col=" + col + ", position=" + position + ", stype=" + stype + ", audi=" + audi + "]";
	}

}
