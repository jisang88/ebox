package kr.co.ebox.service;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.ebox.domain.AuditoriumVO;
import kr.co.ebox.domain.Criteria;
import kr.co.ebox.persistence.AuditoriumDAO;

@Service
public class AuditoriumServiceImpl implements AuditoriumService {
	private static final Logger logger = LoggerFactory.getLogger(AuditoriumServiceImpl.class);

	@Autowired
	private AuditoriumDAO dao;



	@Override
	public void register(AuditoriumVO theater) throws Exception {

		dao.insert(theater);
	}



	@Override
	public List<AuditoriumVO> readAll(Criteria cri) throws Exception {

		return dao.selectAll(cri);
	}



	@Override
	public void modify(AuditoriumVO theater) throws Exception {

		dao.update(theater);
	}



	@Transactional
	@Override
	public void remove(String[] arrStrNo) throws Exception {

		int[] arrNo = Arrays.stream(arrStrNo).mapToInt(Integer::parseInt).toArray();
		for (int aNo : arrNo) {
			dao.delete(aNo);
		}
	}



	@Override
	public void remove(int[] arrNo) throws Exception {

		for (int aNo : arrNo) {
			dao.delete(aNo);
		}
	}



	@Override
	public AuditoriumVO read(AuditoriumVO audi) throws Exception {

		return dao.selectByAttr(audi);
	}



	@Override
	public int countPaging(Criteria cri) throws Exception {

		return dao.countPaging(cri);
	}



	@Override
	public AuditoriumVO read(int aNo) throws Exception {

		return dao.selectByAno(aNo);
	}



	@Override
	public List<AuditoriumVO> listByTno(int tNo) throws Exception {

		return dao.selectAllByTno(tNo);
	}

}
