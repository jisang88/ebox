package kr.co.ebox.persistence;

import java.util.List;

import kr.co.ebox.domain.ImageVO;

public interface ImageDAO {
	void insert(ImageVO image);



	void delete(int iNo);



	void deleteByMno(int mNo);



	ImageVO selectById(int iNo);



	List<ImageVO> selectAll(int mNo);



	List<ImageVO> selectAll(int mNo, String iType);

}
