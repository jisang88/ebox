package kr.co.ebox.service;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.ScreenVO;
import kr.co.ebox.persistence.ScreenDAO;

@Service
public class ScreenServiceImpl implements ScreenService {

	private static final Logger logger = LoggerFactory.getLogger(ScreenServiceImpl.class);

	@Autowired
	private ScreenDAO dao;



	@Override
	public void write(ScreenVO screen) throws Exception {

		dao.insert(screen);
	}



	@Override
	public void modify(ScreenVO screen) throws Exception {

		dao.update(screen);
	}



	@Override
	public void remove(String[] noArr) throws Exception {

		int[] noIntArr = Arrays.stream(noArr).mapToInt(Integer::parseInt).toArray();
		for (int scrno : noIntArr) {
			dao.delete(scrno);
		}
	}



	@Override
	public List<ScreenVO> readWithQnty(int qnty) throws Exception {

		return dao.selectWithQnty(qnty);
	}



	@Override
	public ScreenVO read(int scrNo) throws Exception {

		return dao.select(scrNo);

	}



	@Override
	public List<ScreenVO> readAll(Criteria cri) throws Exception {

		return dao.selectAll(cri);
	}



	@Override
	public int countPaging(Criteria cri) throws Exception {

		return dao.countPaging(cri);
	}



	@Override
	public int countPagingForInputList(Criteria cri) throws Exception {

		return dao.countPagingForInputList(cri);
	}



	@Override
	public List<ScreenVO> getSelectList(Criteria cri) throws Exception {

		return dao.selectWithCriForInputList(cri);
	}

}
