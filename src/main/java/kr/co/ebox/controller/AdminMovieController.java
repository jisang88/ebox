package kr.co.ebox.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.ImageVO;
import kr.co.ebox.domain.MovieVO;
import kr.co.ebox.domain.PageMaker;
import kr.co.ebox.service.ImageService;
import kr.co.ebox.service.MovieService;
import kr.co.ebox.util.MediaUtils;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/movie")
public class AdminMovieController {

	private static final Logger logger = LoggerFactory.getLogger(AdminMovieController.class);

	@Inject
	MovieService movieService;
	@Inject
	ImageService imageService;

	// C:/zzz/upload
	@Resource(name = "uploadPath") // bean id값으로 주입받아진다.
	private String uploadPath;



	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listGET(Model model, PageMaker pageMaker, Criteria cri) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> listGET....");
		System.out.println("Criteria\t" + cri);
		System.out.println("PageMaker\t" + pageMaker);

		cri.setPerPageNum(10);
		pageMaker.setCri(cri);
		pageMaker.setDisplayPageNum(5);
		pageMaker.setTotalCnt(movieService.countPaging(cri));

		model.addAttribute("movieList", movieService.readAll(cri));
		model.addAttribute("pageMaker", pageMaker);

		System.out.println("\n\n");
		return "/admin/movieList";
	}



	@RequestMapping(value = "/image/list", method = RequestMethod.GET)
	public String imageListGET(Model model, Criteria cri, int mNo) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> imageListGET....");
		System.out.println("Criteria\t" + cri);
		System.out.println("movie\t" + movieService.read(mNo));

		model.addAttribute("movie", movieService.read(mNo));
		model.addAttribute("cri", cri);

		model.addAttribute("posterList", imageService.readAll(mNo, ImageVO.TYPE_POSTER));
		model.addAttribute("hPosterList", imageService.readAll(mNo, ImageVO.TYPE_H_POSTER));
		model.addAttribute("stillCutList", imageService.readAll(mNo, ImageVO.TYPE_STILLCUT));
		model.addAttribute("eventList", imageService.readAll(mNo, ImageVO.TYPE_EVENT));
		model.addAttribute("videoList", imageService.readAll(mNo, ImageVO.TYPE_VIDEO));

		System.out.println("\n\n");

		return "/admin/movieImage";
	}



	@Transactional
	@ResponseBody
	@RequestMapping(value = "/image/write", method = RequestMethod.POST)
	public ResponseEntity<String> imageWritePOST(List<MultipartFile> posterList, List<MultipartFile> hPosterList, List<MultipartFile> stillCutList, List<MultipartFile> eventList,
			List<MultipartFile> videoList, int mNo) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> imageWritePOST....");
		ResponseEntity<String> entity = null;

		try {

			MovieVO vo = movieService.read(mNo);

			if (isValid(posterList)) {
				System.out.println("poster OK");
				imageService.write(posterList, ImageVO.TYPE_POSTER, vo);

			} else {
				System.out.println("poster fail");
			}

			System.out.println("\n\n");
			if (isValid(hPosterList)) {
				System.out.println("poster OK");
				imageService.write(hPosterList, ImageVO.TYPE_H_POSTER, vo);

			} else {
				System.out.println("poster fail");
			}

			System.out.println("\n\n");
			if (isValid(stillCutList)) {
				System.out.println("poster OK");
				imageService.write(stillCutList, ImageVO.TYPE_STILLCUT, vo);

			} else {
				System.out.println("poster fail");
			}

			System.out.println("\n\n");

			if (isValid(eventList)) {
				System.out.println("photo OK");
				imageService.write(eventList, ImageVO.TYPE_EVENT, vo);
			} else {
				System.out.println("photo fail");
			}
			System.out.println("\n\n");

			if (isValid(videoList)) {
				System.out.println("video OK");
				imageService.write(videoList, ImageVO.TYPE_VIDEO, vo);
			} else {
				System.out.println("video fail");
			}

			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;

	}



	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String mainGET(Model model, PageMaker pageMaker, Criteria cri) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> mainGET....");

		System.out.println("\n\n");

		return "/admin/movieWrite";
	}



	@ResponseBody
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> searchGET(Criteria cri) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> searchGET....");
		System.out.println("Criteria\t" + cri);
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("list", movieService.readAllByName(cri));
			map.put("total", movieService.countPagingByName(cri));
			map.put("result", "SUCCESS");

			entity = new ResponseEntity<>(map, HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}



	@ResponseBody
	@RequestMapping(value = "/image/delete", method = RequestMethod.POST)
	public ResponseEntity<String> imageDeletePOST(int iNo) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> imageDeletePOST....");
		ResponseEntity<String> entity = null;

		try {
			imageService.remove(iNo);
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}



	@Transactional
	@ResponseBody
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public ResponseEntity<String> writePOST2(List<MultipartFile> posterList, List<MultipartFile> hPosterList, List<MultipartFile> stillCutList, List<MultipartFile> eventList,
			List<MultipartFile> videoList, MovieVO movie) {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> writePOST2....");

		System.out.println("\n");
		System.out.println("MovieVO\t" + movie);

		ResponseEntity<String> entity = null;

		try {
			movieService.write(movie);
			MovieVO vo = movieService.getLastRow();
			if (isValid(posterList)) {
				System.out.println("poster OK");
				imageService.write(posterList, ImageVO.TYPE_POSTER, vo);

			} else {
				System.out.println("poster fail");
			}

			System.out.println("\n\n");
			if (isValid(hPosterList)) {
				System.out.println("poster OK");
				imageService.write(hPosterList, ImageVO.TYPE_H_POSTER, vo);

			} else {
				System.out.println("poster fail");
			}

			System.out.println("\n\n");
			if (isValid(stillCutList)) {
				System.out.println("poster OK");
				imageService.write(stillCutList, ImageVO.TYPE_STILLCUT, vo);

			} else {
				System.out.println("poster fail");
			}

			System.out.println("\n\n");

			if (isValid(eventList)) {
				System.out.println("photo OK");
				imageService.write(eventList, ImageVO.TYPE_EVENT, vo);
			} else {
				System.out.println("photo fail");
			}
			System.out.println("\n\n");

			if (isValid(videoList)) {
				System.out.println("video OK");
				imageService.write(videoList, ImageVO.TYPE_VIDEO, vo);
			} else {
				System.out.println("video fail");
			}

			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}



	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String filename) throws Exception {

		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		System.out.println("filename\t" + filename);
		logger.info("[displayFile] filename: " + filename);

		// 파일 확장자만 뽑기
		try {
			String format = filename.substring(filename.lastIndexOf(".") + 1);
			MediaType mType = MediaUtils.getMediaType(format);

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mType);

			in = new FileInputStream(uploadPath + "/" + filename);

			// IOUtils.toByteArray(in)

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}



	@ResponseBody
	@RequestMapping("/displayOrinFile")
	public ResponseEntity<byte[]> displayOrinFile(String filename) throws Exception {

		System.out.println("filename\t" + filename);
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;

		logger.info("[displayFile] filename: " + filename);

		// 파일 확장자만 뽑기
		try {
			String format = filename.substring(filename.lastIndexOf(".") + 1);
			MediaType mType = MediaUtils.getMediaType(format);

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mType);

			String front = filename.substring(0, 12);
			String end = filename.substring(14);

			in = new FileInputStream(uploadPath + "/" + (front + end));

			// IOUtils.toByteArray(in)

			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}



	public boolean isValid(List<MultipartFile> list) {

		if (list != null) {
			System.out.println("ARRAY NOT NULL");
			if (!list.isEmpty()) {
				System.out.println("ARRAY NOT EMPTY");
				System.out.println("ARRAY SIZE\t" + list.size());

				for (MultipartFile multipartFile : list) {
					System.out.println("\n");
					System.out.println(multipartFile.getSize());
					System.out.println(multipartFile.getContentType());
					System.out.println(multipartFile.getOriginalFilename());
					System.out.println("\n");
				}
				return true;

			} else {
				System.out.println("ARRAY EMPTY");
				return false;
			}
		} else {
			System.out.println("ARRAY NULL");
			return false;
		}

	}

}
