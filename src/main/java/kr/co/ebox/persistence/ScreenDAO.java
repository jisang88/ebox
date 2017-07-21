package kr.co.ebox.persistence;

import java.util.List;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.ScreenVO;

public interface ScreenDAO {

	void insert(ScreenVO screen);



	void delete(int scrno);



	void update(ScreenVO screen);



	ScreenVO select(int scrNo);



	List<ScreenVO> selectWithQnty(int qnty);



	List<ScreenVO> selectAll(Criteria cri);



	List<ScreenVO> selectWithCriForInputList(Criteria cri);



	int countPaging(Criteria cri);



	int countPagingForInputList(Criteria cri) throws Exception;

}
