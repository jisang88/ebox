package kr.co.ebox.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.TheaterVO;
import kr.co.ebox.persistence.TheaterDAO;

@Service
public class TheaterServiceImpl implements TheaterService {

	private static final Logger logger = LoggerFactory.getLogger(TheaterServiceImpl.class);

	@Autowired
	private TheaterDAO dao;



	@Override
	public void register(TheaterVO theater) throws Exception {

		dao.insert(theater);
	}



	@Override
	public void modify(TheaterVO theater) throws Exception {

		dao.update(theater);
	}



	@Override
	public void remove(int[] arr) throws Exception {

		for (int tno : arr) {
			dao.delete(tno);
		}
	}



	@Transactional
	@Override
	public void remove(String[] arr) throws Exception {

		int[] intArr = Arrays.stream(arr).mapToInt(Integer::parseInt).toArray();
		for (int tno : intArr) {
			dao.delete(tno);
		}
	}



	@Override
	public List<TheaterVO> readAll() throws Exception {

		return dao.select();
	}



	@Override
	public List<TheaterVO> readAllByVO(TheaterVO theater) throws Exception {

		return dao.selectByVO(theater);
	}



	@Override
	public List<TheaterVO> searchTnameByKeyWord(Criteria cri) throws Exception {

		return dao.searchTnameByKeyWord(cri);

	}



	@Override
	public TheaterVO read(TheaterVO theater) throws Exception {

		return dao.selectByAttr(theater);
	}



	@Override
	public TheaterVO read(int tNo) throws Exception {

		return dao.selectByTno(tNo);
	}



	@Override
	public TheaterVO getMatchItemByTname(TheaterVO theater) throws Exception {

		return dao.selectByTname(theater);
	}



	@Override
	public List<TheaterVO> readAll(Criteria cri) throws Exception {

		return dao.selectAll(cri);
	}



	@Override
	public int countPaging(Criteria cri) throws Exception {

		return dao.countPaging(cri);
	}



	@Override
	public int countPagingByLikeTname(Criteria cri) throws Exception {

		return dao.countPagingByLikeTname(cri);
	}



	@Override
	public void updateViewCount(int tno) throws Exception {

	}



	@Override
	public List<TheaterVO> readAllWithoutCri() throws Exception {

		return dao.selectAllWithoutCri();
	}



	@Override
	public List<TheaterVO> readByRegion(String region) throws Exception {

		System.out.println("--------------------------------------------region check");

		String[] regionArr = region.split("/");
		Map<String, Object> map = new HashMap<String, Object>();

		int idx = 1;
		for (String str : regionArr) {
			map.put("region" + idx, str);
			idx++;
		}
		System.out.println(map);
		System.out.println("--------------------------------------------region check");
		return dao.selectByRegion(map);
	}



	@Override
	public List<Map<String, Object>> readTheaterWithAudiCnt(String keyword) throws Exception {

		return dao.getTheaterWithAudiCnt(keyword);
	}

}
