package kr.co.ebox.persistence;

import java.util.List;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.MovieVO;

public interface MovieDAO {
	void insert(MovieVO movie);



	void delete(int mno);



	void update(MovieVO movie);



	MovieVO selectById(int mno);



	List<MovieVO> selectAll(Criteria cri);



	List<MovieVO> selectAllByName(Criteria cri);



	List<MovieVO> selectAll();



	List<MovieVO> selectAll(String keyword);



	int countPaging(Criteria cri);



	int countPagingByName(Criteria cri);



	MovieVO selectLastRow();
}
