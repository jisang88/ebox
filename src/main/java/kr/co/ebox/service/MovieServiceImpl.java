package kr.co.ebox.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.MovieVO;
import kr.co.ebox.persistence.MovieDAO;

@Service
public class MovieServiceImpl implements MovieService {
	private static final Logger logger = LoggerFactory.getLogger(MovieServiceImpl.class);

	@Autowired
	private MovieDAO movieDao;

	@Autowired
	private ImageService imageService;



	@Override
	public void write(MovieVO movie) throws Exception {

		logger.info("MovieServiceImpl START______________________");
		logger.info(movie.toString());
		movieDao.insert(movie);
		MovieVO vo = getLastRow();

		System.out.println(vo.getmNo());
		logger.info("MovieServiceImpl END________________________");

	}



	@Override
	public MovieVO read(Integer no) throws Exception {

		return movieDao.selectById(no);
	}



	@Override
	public void modify(MovieVO movie) throws Exception {

		movieDao.update(movie);
	}



	@Transactional
	@Override
	public void modify(MovieVO movie, Map<String, List<MultipartFile>> map) throws Exception {

		logger.info("gogo_______________________________________");
		logger.info(movie.toString());
		modify(movie);
		int mno = movie.getmNo();

		/*
		 * List<MultipartFile> filePoster = map.get("filePoster"); if
		 * (filePoster.size() != 0) { imageService.register(filePoster,
		 * ImageVO.TYPE_POSTER, mno); }
		 * 
		 * List<MultipartFile> fileEtc = map.get("fileEtc"); if (fileEtc.size()
		 * != 0) { imageService.register(fileEtc, ImageVO.TYPE_PHOTO, mno); }
		 */
	}



	@Override
	public void remove(String[] noArr) throws Exception {

		int[] noIntArr = Arrays.stream(noArr).mapToInt(Integer::parseInt).toArray();
		for (int no : noIntArr) {
			movieDao.delete(no);
			imageService.removeByMno(no);
		}
	}



	@Override
	public List<MovieVO> readAll(Criteria cri) throws Exception {

		return movieDao.selectAll(cri);
	}



	@Override
	public List<MovieVO> readAll() throws Exception {

		return movieDao.selectAll();
	}



	@Override
	public int countPaging(Criteria cri) throws Exception {

		return movieDao.countPaging(cri);
	}



	@Override
	public int countPagingByName(Criteria cri) throws Exception {

		return movieDao.countPagingByName(cri);
	}



	@Override
	public MovieVO getLastRow() throws Exception {

		return movieDao.selectLastRow();
	}



	@Override
	public List<MovieVO> readAll(String keyword) throws Exception {

		return movieDao.selectAll(keyword);
	}



	@Override
	public List<MovieVO> readAllByName(Criteria cri) throws Exception {

		return movieDao.selectAllByName(cri);
	}

}
