package kr.co.ebox.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.TheaterVO;

@Repository
public class TheaterDAOImpl implements TheaterDAO {

	@Inject
	private SqlSession session;

	// 매퍼파일에 설정된 네임스페이스 - 같게 해줘야됨.
	private static String namespace = "kr.co.ebox.mapper.TheaterMapper";



	@Override
	public void insert(TheaterVO vo) {

		session.insert(namespace + ".insert", vo);
	}



	@Override
	public void delete(int tno) {

		session.delete(namespace + ".delete", tno);
	}



	@Override
	public void update(TheaterVO vo) {

		session.update(namespace + ".update", vo);
	}



	@Override
	public List<TheaterVO> select() {

		return session.selectList(namespace + ".select");
	}



	@Override
	public List<TheaterVO> selectByVO(TheaterVO theater) {

		return session.selectList(namespace + ".selectByVO", theater);
	}



	@Override
	public TheaterVO selectByAttr(TheaterVO theater) {

		return session.selectOne(namespace + ".selectByVO", theater);
	}



	@Override
	public List<TheaterVO> searchTnameByKeyWord(Criteria cri) {

		return session.selectList(namespace + ".searchTnameByKeyWord", cri);
	}



	@Override
	public List<TheaterVO> selectAll(Criteria cri) {

		return session.selectList(namespace + ".selectAll", cri);
	}



	@Override
	public int countPaging(Criteria cri) {

		return session.selectOne(namespace + ".countPaging", cri);
	}



	@Override
	public int countPagingByLikeTname(Criteria cri) {

		return session.selectOne(namespace + ".countPagingByLikeTname", cri);
	}



	@Override
	public TheaterVO selectByTname(TheaterVO theater) {

		return session.selectOne(namespace + ".selectByTname", theater);
	}



	@Override
	public TheaterVO selectByTno(int tNo) {

		return session.selectOne(namespace + ".selectByTno", tNo);
	}

	/*---------------------------------------------------------------------*/



	@Override
	public List<TheaterVO> selectByRegion(Map<String, Object> mapRegion) {

		return session.selectList(namespace + ".selectByRegion", mapRegion);
	}



	@Override
	public List<TheaterVO> selectAllWithoutCri() {

		// TODO Auto-generated method stub
		return session.selectList(namespace + ".selectAllWithoutCri");
	}



	@Override
	public List<Map<String, Object>> getTheaterWithAudiCnt(String keyword) {

		return session.selectList(namespace + ".getTheaterWithAudiCnt", keyword);

	}

}
