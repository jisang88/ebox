package kr.co.ebox.service;

import java.util.List;
import java.util.Map;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.TheaterVO;

public interface TheaterService {

	public void register(TheaterVO theater) throws Exception;



	public TheaterVO read(TheaterVO theater) throws Exception;



	public TheaterVO read(int tNo) throws Exception;



	public TheaterVO getMatchItemByTname(TheaterVO theater) throws Exception;



	public void modify(TheaterVO theater) throws Exception;



	public void remove(String[] arr) throws Exception;



	public void remove(int[] arr) throws Exception;



	public List<TheaterVO> readAll() throws Exception;



	public List<TheaterVO> readAllByVO(TheaterVO theater) throws Exception;



	public List<TheaterVO> searchTnameByKeyWord(Criteria cri) throws Exception;



	public List<TheaterVO> readAll(Criteria cri) throws Exception;



	/*-----------------------------------------------------------------------------*/

	public List<TheaterVO> readByRegion(String region) throws Exception;



	public List<TheaterVO> readAllWithoutCri() throws Exception;



	public int countPaging(Criteria cri) throws Exception;



	public int countPagingByLikeTname(Criteria cri) throws Exception;



	public void updateViewCount(int tno) throws Exception;



	public List<Map<String, Object>> readTheaterWithAudiCnt(String keyword) throws Exception;

}
