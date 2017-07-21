package kr.co.ebox.service;

import java.util.List;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.SeatingVO;

public interface SeatingService {

	void register(String seatData, int ano) throws Exception;



	void modify(SeatingVO seat) throws Exception;



	void removeByAudi(int ano) throws Exception;



	SeatingVO read(int sno) throws Exception;



	List<SeatingVO> readAll(Criteria cri) throws Exception;



	List<SeatingVO> readAll() throws Exception;



	List<SeatingVO> readForBooking(int ano) throws Exception;



	List<SeatingVO> readForType() throws Exception;



	int countPaging(Criteria cri) throws Exception;



	int getAbleSeatCnt(int ano) throws Exception;

}
