package kr.co.ebox.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ebox.domain.ImageVO;
import kr.co.ebox.domain.MovieVO;
import kr.co.ebox.persistence.ImageDAO;
import kr.co.ebox.util.UploadFileUtils;

@Service
public class ImageServiceImpl implements ImageService {
	private static final Logger logger = LoggerFactory.getLogger(ImageServiceImpl.class);

	@Autowired
	private ImageDAO dao;

	@Autowired
	private MovieService movieservice;

	// C:/zzz/upload
	@Resource(name = "uploadPath") // bean id값으로 주입받아진다.
	private String uploadPath;



	@Override
	public void write(ImageVO image) throws Exception {

		dao.insert(image);
	}



	@Override
	public void write(List<ImageVO> list) throws Exception {

		for (ImageVO image : list) {
			this.write(image);
		}
	}



	@Transactional
	@Override
	public void write(List<MultipartFile> list, String type, MovieVO movie) throws Exception {

		ArrayList<ImageVO> images = new ArrayList<ImageVO>();
		ImageVO vo;
		Map<String, Object> map;

		for (MultipartFile file : list) {

			if (!file.getContentType().contains("image")) continue;
			logger.info("originalName : " + file.getOriginalFilename());
			logger.info("size : " + file.getSize() + "");
			logger.info("contentType : " + file.getContentType());

			vo = new ImageVO();
			vo.setRefMno(movie.getmNo());

			if (type.equals(ImageVO.TYPE_POSTER)) vo.setiType(ImageVO.TYPE_POSTER);
			else if (type.equals(ImageVO.TYPE_H_POSTER)) vo.setiType(ImageVO.TYPE_H_POSTER);
			else if (type.equals(ImageVO.TYPE_EVENT)) vo.setiType(ImageVO.TYPE_EVENT);
			else if (type.equals(ImageVO.TYPE_STILLCUT)) vo.setiType(ImageVO.TYPE_STILLCUT);
			else if (type.equals(ImageVO.TYPE_VIDEO)) vo.setiType(ImageVO.TYPE_VIDEO);

			map = new HashMap<>();
			map.put("file", file);
			map.put("uploadPath", uploadPath);
			map.put("movie", movie);
			map.put("type", type);

			String savedName = UploadFileUtils.uploadFile(map);
			vo.setiPath(savedName);

			images.add(vo);
		}

		this.write(images);
	}



	@Override
	public ImageVO read(Integer ino) throws Exception {

		return dao.selectById(ino);
	}



	@Transactional
	@Override
	public void remove(String[] noArr) throws Exception {

		logger.info("@Service remove..........");
		int[] noIntArr = Arrays.stream(noArr).mapToInt(Integer::parseInt).toArray();

		for (int no : noIntArr) {
			ImageVO vo = read(no);
			String filename = vo.getiPath();

			String front = filename.substring(0, 12);
			String end = filename.substring(14);

			System.out.println("-----------------------------------");
			System.out.println(filename);
			System.out.println(front + end);
			System.out.println("-----------------------------------");

			// 썸네일 삭제
			new File(uploadPath + front + end).delete();
			// 원본 삭제
			new File(uploadPath + filename).delete();

			remove(no);
		}

	}



	@Override // ino로 삭제
	public void remove(int no) throws Exception {

		ImageVO vo = read(no);
		String filename = vo.getiPath();

		String[] splitArray = filename.split("/");

		int len = splitArray.length - 1;

		for (int i = 0; i < splitArray.length - 1; i++) {
			System.out.print("\n");
			System.out.print("str\t" + splitArray[i]);
			System.out.print("\n");
			System.out.print("len\t" + splitArray[i].length());
			System.out.print("\n");
			len += splitArray[i].length();
		}

		System.out.println();
		System.out.println("total filename \t" + filename);
		System.out.println("total filename len\t" + filename.length());
		System.out.println("total filename calc len\t" + len);
		String front = filename.substring(0, len);
		String end = filename.substring(len + 2);

		System.out.println();
		System.out.print("front\t" + front);
		System.out.print("end\t" + end);

		System.out.println("-----------------------------------");
		System.out.println(filename);
		System.out.println(front + end);
		System.out.println("-----------------------------------");

		
		// 썸네일 삭제
		new File(uploadPath + front + end).delete();
		
		// 원본 삭제
		new File(uploadPath + filename).delete();

		dao.delete(no);
	}



	@Override
	public void removeByMno(int no) throws Exception {

		// mno로 불러와서 해당 경로 이미지 삭제 후 db에서 삭제
		List<ImageVO> list = readAll(no);

		for (ImageVO image : list) {
			String filename = image.getiPath();

			String front = filename.substring(0, 12);
			String end = filename.substring(14);

			// 썸네일 삭제
			new File(uploadPath + front + end).delete();
			// 원본 삭제
			new File(uploadPath + filename).delete();
		}
		// mno로 여러개 삭제
		dao.deleteByMno(no);
	}



	@Override
	public List<ImageVO> readAll(int mNo, String type) {

		return dao.selectAll(mNo, type);
	}



	@Override
	public List<ImageVO> readAll(int mNo) throws Exception {

		// TODO Auto-generated method stub
		return dao.selectAll(mNo);
	}

}
