package kr.co.ebox.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.ebox.domain.ImageVO;
import kr.co.ebox.domain.MovieVO;

public interface ImageService {
	public void write(ImageVO image) throws Exception;



	public void write(List<ImageVO> list) throws Exception;



	public void write(List<MultipartFile> list, String type, MovieVO movie) throws Exception;



	public ImageVO read(Integer iNo) throws Exception;



	public void remove(String[] noArr) throws Exception;



	public void remove(int no) throws Exception;



	public void removeByMno(int no) throws Exception;



	public void removeByMno(int[] no) throws Exception;



	public List<ImageVO> readAll(int mNo) throws Exception;



	public List<ImageVO> readAll(int mNo, String type) throws Exception;
}
