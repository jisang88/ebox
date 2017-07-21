package kr.co.ebox.persistence;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.ebox.domain.ImageVO;

@Repository
public class ImageDAOImpl implements ImageDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "kr.co.ebox.mapper.ImageMapper";



	@Override
	public void insert(ImageVO image) {

		session.insert(namespace + ".insert", image);
	}



	@Override
	public void delete(int ino) {

		session.delete(namespace + ".delete", ino);
	}



	@Override
	public void deleteByMno(int mNo) {

		session.delete(namespace + ".deleteByMno", mNo);
	}



	@Override
	public ImageVO selectById(int iNo) {

		return session.selectOne(namespace + ".selectById", iNo);
	}



	@Override
	public List<ImageVO> selectAll(int mNo, String type) {

		Map<String, Object> paramMap = new HashMap<>();

		paramMap.put("mNo", mNo);
		paramMap.put("iType", type);

		return session.selectList(namespace + ".selectWithMnoAndType", paramMap);
	}



	@Override
	public List<ImageVO> selectAll(int mNo) {

		try {
			return session.selectList(namespace + ".selectAll", mNo);
		} catch (Exception e) {
			return Collections.EMPTY_LIST;
		}

	}

}
