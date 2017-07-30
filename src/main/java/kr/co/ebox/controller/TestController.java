package kr.co.ebox.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.ebox.domain.ImageVO;
import kr.co.ebox.service.ImageService;
import kr.co.ebox.service.MovieService;
import kr.co.ebox.util.MediaUtils;
import kr.co.ebox.util.MultipartFileSender;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/test")
public class TestController {

	private static final Logger logger = LoggerFactory.getLogger(TestController.class);

	@Inject
	MovieService movieService;

	@Inject
	ImageService imageService;

	// C:/zzz/upload
	@Resource(name = "uploadPath") // bean id값으로 주입받아진다.
	private String uploadPath;



	@RequestMapping(value = "/video_test", method = RequestMethod.GET)
	public String videoTestGET(Model model) throws Exception {

		System.out.println("\n\n");
		logger.info("TestController -> videoTestGET....");

		model.addAttribute("movie", movieService.read(2172));
		model.addAttribute("videoList", imageService.readAll(2172, ImageVO.TYPE_VIDEO));

		System.out.println("\n\n");

		return "/admin/videoTest_1";
	}



	@ResponseBody
	@RequestMapping("/playOrinFile1")
	public ResponseEntity<byte[]> playOrinFile(String filename) throws Exception {

		System.out.println("filename\t" + filename);
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;

		logger.info("[displayFile] filename: " + filename);

		// 파일 확장자만 뽑기
		try {
			String format = filename.substring(filename.lastIndexOf(".") + 1);
			MediaType mType = MediaUtils.getMediaType(format);

			HttpHeaders headers = new HttpHeaders();
			// headers.setContentType(mType);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

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



	@RequestMapping(value = "/playOrinFile", method = RequestMethod.GET)
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



	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<String> deletePOST(@RequestParam(value = "aNo[]") int[] arrNo) {

		System.out.println("\n\n");
		logger.info("TestController -> deletePOST....");
		ResponseEntity<String> entity = null;

		try {
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}

}
