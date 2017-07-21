package kr.co.ebox.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.ScreenVO;

@Repository
public class ScreenDAOImpl implements ScreenDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "kr.co.ebox.mapper.ScreenMapper";



	@Override
	public void insert(ScreenVO screen) {

		session.insert(namespace + ".insert", screen);
	}



	@Override
	public void delete(int scrno) {

		session.delete(namespace + ".delete", scrno);
	}



	@Override
	public void update(ScreenVO screen) {

		session.update(namespace + ".update", screen);
	}



	@Override
	public List<ScreenVO> selectWithQnty(int qnty) {

		return session.selectList(namespace + ".selectWithQnty", qnty);
	}



	@Override
	public ScreenVO select(int scrNo) {

		return session.selectOne(namespace + ".selectById", scrNo);
	}



	@Override
	public List<ScreenVO> selectAll(Criteria cri) {

		return session.selectList(namespace + ".selectWithCri", cri);
	}



	@Override
	public int countPaging(Criteria cri) {

		return session.selectOne(namespace + ".countPaging", cri);
	}



	@Override
	public int countPagingForInputList(Criteria cri) throws Exception {

		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".countPagingForInputList", cri);
	}



	@Override
	public List<ScreenVO> selectWithCriForInputList(Criteria cri) {

		return session.selectList(namespace + ".selectWithCriForInputList", cri);
	}

}
