package kr.co.ebox.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.MovieVO;

public interface MovieService {

	public void write(MovieVO movie) throws Exception;



	public MovieVO read(Integer no) throws Exception;



	public MovieVO getLastRow() throws Exception;



	public void modify(MovieVO movie) throws Exception;



	public void modify(MovieVO movie, Map<String, List<MultipartFile>> map) throws Exception;



	public void remove(String[] anoArr) throws Exception;



	public List<MovieVO> readAll(Criteria cri) throws Exception;



	public List<MovieVO> readAllByName(Criteria cri) throws Exception;



	public List<MovieVO> readAll() throws Exception;



	public List<MovieVO> readAll(String keyword) throws Exception;



	public int countPaging(Criteria cri) throws Exception;



	public int countPagingByName(Criteria cri) throws Exception;
}
