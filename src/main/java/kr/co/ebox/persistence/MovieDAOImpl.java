package kr.co.ebox.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.MovieVO;

@Repository
public class MovieDAOImpl implements MovieDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "kr.co.ebox.mapper.MovieMapper";



	@Override
	public void insert(MovieVO movie) {

		session.insert(namespace + ".insert", movie);
	}



	@Override
	public void delete(int mno) {

		session.delete(namespace + ".delete", mno);
	}



	@Override
	public void update(MovieVO movie) {

		session.update(namespace + ".update", movie);
	}



	@Override
	public MovieVO selectById(int mno) {

		return session.selectOne(namespace + ".selectById", mno);
	}



	@Override
	public List<MovieVO> selectAll(Criteria cri) {

		return session.selectList(namespace + ".selectAllWithCri", cri);
	}



	@Override
	public List<MovieVO> selectAll() {

		return session.selectList(namespace + ".selectAll");
	}



	@Override
	public int countPaging(Criteria cri) {

		return session.selectOne(namespace + ".countPaging", cri);
	}
	
	@Override
	public int countPagingByName(Criteria cri) {

		return session.selectOne(namespace + ".countPagingByName", cri);
	}



	@Override
	public MovieVO selectLastRow() {

		return session.selectOne(namespace + ".selectLastRow");
	}



	@Override
	public List<MovieVO> selectAll(String keyword) {

		return session.selectList(namespace + ".selectAllWithQuery", keyword);
	}



	@Override
	public List<MovieVO> selectAllByName(Criteria cri) {

		return session.selectList(namespace + ".selectAllByName", cri);
	}



	
}