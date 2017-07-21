package kr.co.ebox.service;

import java.util.List;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.ScreenVO;

public interface ScreenService {

	public void write(ScreenVO screen) throws Exception;



	public ScreenVO read(int scrNo) throws Exception;



	public void modify(ScreenVO screen) throws Exception;



	public void remove(String[] noArr) throws Exception;



	public List<ScreenVO> readWithQnty(int qnty) throws Exception;



	public List<ScreenVO> readAll(Criteria cri) throws Exception;



	public List<ScreenVO> getSelectList(Criteria cri) throws Exception;



	public int countPaging(Criteria cri) throws Exception;



	public int countPagingForInputList(Criteria cri) throws Exception;

}
