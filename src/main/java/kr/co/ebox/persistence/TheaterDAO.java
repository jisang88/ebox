package kr.co.ebox.persistence;

import java.util.List;
import java.util.Map;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.TheaterVO;

public interface TheaterDAO {

	void insert(TheaterVO theater);



	void delete(int tno);



	void update(TheaterVO theater);



	List<TheaterVO> select();



	List<TheaterVO> selectByVO(TheaterVO theater);



	List<TheaterVO> searchTnameByKeyWord(Criteria cri);



	TheaterVO selectByAttr(TheaterVO theater);



	TheaterVO selectByTname(TheaterVO theater);



	TheaterVO selectByTno(int tNo);

	/*-------------------------------------------------*/



	List<TheaterVO> selectAll(Criteria cri);



	List<TheaterVO> selectAllWithoutCri();



	List<TheaterVO> selectByRegion(Map<String, Object> mapRegion);



	List<Map<String, Object>> getTheaterWithAudiCnt(String keyword);



	int countPaging(Criteria cri);



	int countPagingByLikeTname(Criteria cri);
}
