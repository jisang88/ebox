package kr.co.ebox.service;

import java.util.List;

import kr.co.ebox.domain.AuditoriumVO;
import kr.co.ebox.domain.Criteria;

public interface AuditoriumService {

	public void register(AuditoriumVO audi) throws Exception;



	public AuditoriumVO read(AuditoriumVO audi) throws Exception;



	public AuditoriumVO read(int aNo) throws Exception;



	public void modify(AuditoriumVO audi) throws Exception;



	public void remove(String[] arrStrNo) throws Exception;



	public void remove(int[] arrNo) throws Exception;



	public List<AuditoriumVO> readAll(Criteria cri) throws Exception;



	public List<AuditoriumVO> listByTno(int tNo) throws Exception;



	public int countPaging(Criteria cri) throws Exception;

}
