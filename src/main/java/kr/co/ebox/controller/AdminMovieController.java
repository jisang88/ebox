package kr.co.ebox.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.FileVO;
import kr.co.ebox.domain.ImageVO;
import kr.co.ebox.domain.MovieVO;
import kr.co.ebox.domain.PageMaker;
import kr.co.ebox.service.ImageService;
import kr.co.ebox.service.MovieService;
import kr.co.ebox.util.MediaUtils;
import kr.co.ebox.util.MultipartFileSender;

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

		pageMaker.setCri(cri);
		pageMaker.setTotalCnt(movieService.countPaging(cri));

		model.addAttribute("movieList", movieService.readAll(cri));
		model.addAttribute("pageMaker", pageMaker);

		System.out.println("\n\n");
		return "/admin/movie/list";
	}



	@Transactional
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String movieDeletePOST(@RequestParam(value = "mNo[]") int[] arrNo, Criteria cri, RedirectAttributes rttr) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminAudiController -> deletePOST....");

		// arrNo == mNo[]
		movieService.remove(arrNo);
		imageService.removeByMno(arrNo);

		rttr.addFlashAttribute("result", "SUCCESS");
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("searchType", cri.getSearchType());

		System.out.println("\n\n");
		return "redirect:/admin/movie/list";
	}



	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String movieWriteGET() throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> movieWriteGET....");
		// System.out.println("Criteria\t" + cri);
		// model.addAttribute("cri", cri);

		System.out.println("\n\n");
		return "/admin/movie/write";
	}



	@Transactional
	@ResponseBody
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public ResponseEntity<String> movieWritePOST(FileVO file, MovieVO movie) {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> movieWritePOST....");
		System.out.println("\nMovieVO\t\n\n" + movie);

		ResponseEntity<String> entity = null;
		try {
			movieService.write(movie);
			MovieVO vo = movieService.getLastRow();

			if (isValid(file.getPosterList())) imageService.write(file.getPosterList(), ImageVO.TYPE_POSTER, vo);
			else System.out.println("TYPE_POSTER File Upload Fail");

			if (isValid(file.gethPosterList())) imageService.write(file.gethPosterList(), ImageVO.TYPE_H_POSTER, vo);
			else System.out.println("TYPE_H_POSTER File Upload Fail");

			if (isValid(file.getStillCutList())) imageService.write(file.getStillCutList(), ImageVO.TYPE_STILLCUT, vo);
			else System.out.println("TYPE_STILLCUT File Upload Fail");

			if (isValid(file.getEventList())) imageService.write(file.getEventList(), ImageVO.TYPE_EVENT, vo);
			else System.out.println("TYPE_EVENT File Upload Fail");

			if (isValid(file.getVideoList())) imageService.write(file.getVideoList(), ImageVO.TYPE_VIDEO, vo);
			else System.out.println("TYPE_VIDEO File Upload Fail");

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
	@RequestMapping(value = "/image/write", method = RequestMethod.POST)
	public ResponseEntity<String> imageWritePOST(FileVO file, int mNo) {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> imageWritePOST....");
		System.out.println("\n mNo \t" + mNo);

		ResponseEntity<String> entity = null;

		MovieVO vo = new MovieVO();

		try {

			if (mNo == 0) throw new Exception();
			vo.setmNo(mNo);

			if (isValid(file.getPosterList())) imageService.write(file.getPosterList(), ImageVO.TYPE_POSTER, vo);
			else System.out.println("TYPE_POSTER File Upload Fail");

			if (isValid(file.gethPosterList())) imageService.write(file.gethPosterList(), ImageVO.TYPE_H_POSTER, vo);
			else System.out.println("TYPE_H_POSTER File Upload Fail");

			if (isValid(file.getStillCutList())) imageService.write(file.getStillCutList(), ImageVO.TYPE_STILLCUT, vo);
			else System.out.println("TYPE_STILLCUT File Upload Fail");

			if (isValid(file.getEventList())) imageService.write(file.getEventList(), ImageVO.TYPE_EVENT, vo);
			else System.out.println("TYPE_EVENT File Upload Fail");

			if (isValid(file.getVideoList())) imageService.write(file.getVideoList(), ImageVO.TYPE_VIDEO, vo);
			else System.out.println("TYPE_VIDEO File Upload Fail");

			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}



	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String movieModifyGET(Criteria cri, int mNo, Model model) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> movieModifyGET....");
		System.out.println("Criteria\t" + cri);
		System.out.println("mNo\t" + mNo);
		// model.addAttribute("cri", cri);

		System.out.println(movieService.read(mNo));
		model.addAttribute("movie", movieService.read(mNo));
		System.out.println("\n\n");
		return "/admin/movie/modify";
	}



	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String movieModifyPOST(Criteria cri, MovieVO movie, RedirectAttributes rttr) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> movieModifyGET....");
		System.out.println("Criteria\t" + cri);
		System.out.println("movie\t" + movie);

		movieService.modify(movie);

		rttr.addFlashAttribute("result", "SUCCESS");
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("searchType", cri.getSearchType());
		System.out.println("\n\n");

		return "redirect:/admin/movie/list";
	}



	@RequestMapping(value = "/image/list", method = RequestMethod.GET)
	public String imageListGET(Model model, Criteria cri, int mNo) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> imageListGET....");
		System.out.println("Criteria\t" + cri);
		System.out.println("movie\t" + movieService.read(mNo));

		model.addAttribute("movie", movieService.read(mNo));
		model.addAttribute("cri", cri);

		model.addAttribute("list", imageService.readAll(mNo));
		/*
		 * model.addAttribute("hPosterList", imageService.readAll(mNo,
		 * ImageVO.TYPE_H_POSTER)); model.addAttribute("stillCutList",
		 * imageService.readAll(mNo, ImageVO.TYPE_STILLCUT));
		 * model.addAttribute("eventList", imageService.readAll(mNo,
		 * ImageVO.TYPE_EVENT)); model.addAttribute("videoList",
		 * imageService.readAll(mNo, ImageVO.TYPE_VIDEO));
		 * model.addAttribute("imageList", imageService.readAll(mNo,
		 * ImageVO.TYPE_VIDEO));
		 */

		System.out.println("\n\n");

		return "/admin/movie/movie_image";
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
	public ResponseEntity<String> imageDeletePOST(@RequestParam(value = "iNo[]") int[] arrNo) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminMovieController -> imageDeletePOST....");
		ResponseEntity<String> entity = null;

		try {
			for (int iNo : arrNo) {
				System.out.println("iNo\t" + iNo);
				imageService.remove(iNo);
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



	@RequestMapping(value = "/playFile", method = RequestMethod.GET)
	public void getVideo(HttpServletRequest req, HttpServletResponse res, String filename) {

		logger.info("동영상 스트리밍 요청 : " + filename);
		File getFile = new File(uploadPath + filename);
		System.out.println(getFile.toPath());

		try {
			// 미디어 처리
			MultipartFileSender.fromFile(getFile).with(req).with(res).serveResource();
		} catch (Exception e) {
			// 사용자 취소 Exception 은 콘솔 출력 제외
			if (!e.getClass().getName().equals("org.apache.catalina.connector.ClientAbortException")) e.printStackTrace();
		}
	}



	public boolean isValid(List<MultipartFile> list) {

		if (list != null) {
			System.out.println("ARRAY NOT NULL");
			if (!list.isEmpty()) {
				System.out.println("ARRAY NOT EMPTY");
				System.out.println("ARRAY SIZE\t" + list.size());

				for (MultipartFile multipartFile : list) {

					// 해당 파일을 가지고 있는 변수 이름
					System.out.println(multipartFile.getName());

					// 파일 이름
					System.out.println(multipartFile.getOriginalFilename());

					// 파일 사이즈
					System.out.println(multipartFile.getSize());

					// 파일 타입
					System.out.println(multipartFile.getContentType());
					System.out.println("\n\n");
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
