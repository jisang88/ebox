package kr.co.ebox.persistence;

import java.util.List;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.SeatingVO;

public interface SeatingDAO {

	void insertList(List<SeatingVO> seatList);



	void deleteByAudi(int ano);



	void update(SeatingVO vo);



	public SeatingVO selectBySno(int sno);



	int countPaging(Criteria cri);



	List<SeatingVO> selectByStype();



	List<SeatingVO> selectAll();



	List<SeatingVO> selectByAudi(int ano);



	List<SeatingVO> selectWithCri(Criteria cri);



	int getAbleSeatCnt(int ano);
}
