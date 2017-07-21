package kr.co.ebox.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.ebox.domain.AuditoriumVO;
import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.TheaterVO;

@Repository
public class AuditoriumDAOImpl implements AuditoriumDAO {
	@Inject
	private SqlSession session;

	private static String namespace = "kr.co.ebox.mapper.AudiMapper";



	@Override
	public void insert(AuditoriumVO audi) {

		session.insert(namespace + ".insert", audi);
	}



	@Override
	public void delete(int ano) {

		session.delete(namespace + ".delete", ano);
	}



	@Override
	public void update(AuditoriumVO audi) {

		session.update(namespace + ".update", audi);
	}



	@Override
	public List<AuditoriumVO> selectAll(Criteria cri) {

		return session.selectList(namespace + ".selectAll", cri);
	}



	@Override
	public int countPaging(Criteria cri) {

		return session.selectOne(namespace + ".countPaging", cri);
	}



	@Override
	public AuditoriumVO selectByAttr(AuditoriumVO audi) {

		return session.selectOne(namespace + ".selectByVO", audi);
	}



	@Override
	public AuditoriumVO selectByAno(int aNo) {

		return session.selectOne(namespace + ".selectByAno", aNo);
	}



	@Override
	public List<AuditoriumVO> selectAllByTno(int tNo) {

		return session.selectList(namespace + ".selectByTno", tNo);
	}

}
