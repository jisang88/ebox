package kr.co.ebox.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.MovieVO;
import kr.co.ebox.domain.PageMaker;
import kr.co.ebox.domain.ScheduleVO;
import kr.co.ebox.domain.ScreenVO;
import kr.co.ebox.service.ScreenService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/screen")
public class AdminScreenController {

	private static final Logger logger = LoggerFactory.getLogger(AdminScreenController.class);

	@Inject
	ScreenService screenService;



	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String mainGET(Model model, PageMaker pageMaker, Criteria cri) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminScreenController -> mainGET....");
		System.out.println("Criteria\t" + cri);
		System.out.println("PageMaker\t" + pageMaker);

		cri.setPerPageNum(10);
		pageMaker.setCri(cri);
		pageMaker.setDisplayPageNum(5);
		pageMaker.setTotalCnt(screenService.countPaging(cri));

		// model.addAttribute("audiList", audiService.readAll(cri));
		model.addAttribute("pageMaker", pageMaker);

		System.out.println("\n\n");
		return "/admin/screenWrite";
	}



	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String writePOST(Criteria cri, ScreenVO screen, MovieVO movie) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminScreenController -> writePOST....");
		System.out.println(screen);
		System.out.println(movie);
		// model.addAttribute("audiList", audiService.readAll(cri));
		screen.setMovie(movie);
		screenService.write(screen);

		System.out.println("\n\n");
		// return "/admin/screenWrite";
		return "redirect:/admin/screen/write";
	}



	@ResponseBody
	@RequestMapping(value = "/search/list", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> searchListGET(Criteria cri) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminScreenController -> searchListGET....");
		System.out.println("Criteria\t" + cri);

		System.out.println("\n\n");

		ResponseEntity<Map<String, Object>> entity = null;

		try {

			Map<String, Object> map = new HashMap<>();
			map.put("list", screenService.getSelectList(cri));
			map.put("total", screenService.countPagingForInputList(cri));

			List<ScreenVO> list = screenService.getSelectList(cri);
			for (ScreenVO screen : list) {
				System.out.println(screen);
			}

			entity = new ResponseEntity<>(map, HttpStatus.OK);// 200
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 400
		}
		System.out.println("\n\n");

		return entity;
	}

}
