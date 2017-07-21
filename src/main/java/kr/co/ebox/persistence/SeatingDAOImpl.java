package kr.co.ebox.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.SeatingVO;

@Repository
public class SeatingDAOImpl implements SeatingDAO {
	@Inject
	private SqlSession session;

	// 매퍼파일에 설정된 네임스페이스 - 같게 해줘야됨.
	private static String namespace = "kr.co.megabox.mapper.SeatMapper";



	@Override
	public void insertList(List<SeatingVO> seatList) {

		session.insert(namespace + ".insertList", seatList);
	}



	@Override
	public void deleteByAudi(int ano) {

		session.delete(namespace + ".deleteByAudi", ano);
	}



	@Override
	public void update(SeatingVO vo) {

		session.update(namespace + ".update", vo);
	}



	@Override
	public List<SeatingVO> selectAll() {

		return session.selectList(namespace + ".selectAll");

	}



	@Override
	public SeatingVO selectBySno(int sno) {

		return session.selectOne(namespace + ".selectBySno", sno);

	}



	@Override
	public List<SeatingVO> selectByStype() {

		return session.selectList(namespace + ".selectByStype");
	}



	@Override
	public List<SeatingVO> selectWithCri(Criteria cri) {

		return session.selectList(namespace + ".selectWithCri", cri);
	}



	@Override
	public int countPaging(Criteria cri) {

		return session.selectOne(namespace + ".countPaging", cri);
	}



	@Override
	public int getAbleSeatCnt(int ano) {

		return session.selectOne(namespace + ".getAbleSeatCnt", ano);
	}



	@Override
	public List<SeatingVO> selectByAudi(int ano) {

		return session.selectList(namespace + ".selectByAudi", ano);
	}
}
