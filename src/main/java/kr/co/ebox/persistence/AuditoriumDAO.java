package kr.co.ebox.persistence;

import java.util.List;

import kr.co.ebox.domain.AuditoriumVO;
import kr.co.ebox.domain.Criteria;

public interface AuditoriumDAO {

	void insert(AuditoriumVO audi);



	void delete(int ano);



	void update(AuditoriumVO audi);



	AuditoriumVO selectByAttr(AuditoriumVO audi);



	AuditoriumVO selectByAno(int aNo);



	List<AuditoriumVO> selectAll(Criteria cri);



	List<AuditoriumVO> selectAllByTno(int tNo);



	int countPaging(Criteria cri);

}
