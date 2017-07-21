package kr.co.ebox.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.PageMaker;
import kr.co.ebox.domain.TheaterVO;
import kr.co.ebox.service.TheaterService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/theater")
public class AdminTheaterController {

	private static final Logger logger = LoggerFactory.getLogger(AdminTheaterController.class);

	@Inject
	TheaterService theaterService;



	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String mainGET(Model model, PageMaker pageMaker, Criteria cri) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> mainGET....");
		System.out.println("Criteria\t" + cri);
		System.out.println("PageMaker\t" + pageMaker);

		pageMaker.setCri(cri);
		pageMaker.setDisplayPageNum(5);
		pageMaker.setTotalCnt(theaterService.countPaging(cri));

		model.addAttribute("theaterList", theaterService.readAll(cri));
		model.addAttribute("pageMaker", pageMaker);
		System.out.println(pageMaker);

		List<TheaterVO> list = theaterService.readAll(cri);
		for (TheaterVO theaterVO : list) {
			System.out.println(theaterVO);
		}
		System.out.println("\n\n");
		return "/admin/theater";
	}



	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String writePOST(TheaterVO vo, RedirectAttributes rttr) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> writePOST....");
		System.out.println("vo\t " + vo);

		theaterService.register(vo);

		rttr.addFlashAttribute("result", "SUCCESS");

		System.out.println("\n\n");
		return "redirect:/admin/theater/list";
		// return "redirect:/";
	}



	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(TheaterVO vo, Criteria cri, RedirectAttributes rttr) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> updatePOST....");
		System.out.println("vo\t " + vo);

		theaterService.modify(vo);
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("page", cri.getPage());
		rttr.addFlashAttribute("result", "SUCCESS");

		System.out.println("\n\n");
		return "redirect:/admin/theater/list";
	}



	@ResponseBody
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public ResponseEntity<TheaterVO> readGET(int tNo) {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> readAllGET....");
		System.out.println("tNo\t " + tNo);
		ResponseEntity<TheaterVO> entity = null;

		try {
			System.out.println("tNo  - > " + tNo);
			System.out.println(theaterService.read(tNo));
			entity = new ResponseEntity<>(theaterService.read(tNo), HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}



	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<String> deletePOST(@RequestParam(value = "tNo[]") int[] arrNo) {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> deletePOST....");
		System.out.println("arrNo[]\t" + Arrays.toString(arrNo));

		ResponseEntity<String> entity = null;

		try {
			theaterService.remove(arrNo);
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/list", method = RequestMethod.GET) public
	 * ResponseEntity<Map<String, Object>> readAllGET(PageMaker pageMaker,
	 * Criteria cri) {
	 * 
	 * System.out.println("\n\n"); logger.info(
	 * "AdminTheaterController -> readAllGET....");
	 * System.out.println("Criteria\t" + cri); System.out.println("PageMaker\t"
	 * + pageMaker); ResponseEntity<Map<String, Object>> entity = null;
	 * 
	 * try {
	 * 
	 * cri.setPerPageNum(10); pageMaker.setCri(cri);
	 * pageMaker.setDisplayPageNum(5);
	 * pageMaker.setTotalCnt(theaterService.countPaging(cri));
	 * 
	 * Map<String, Object> map = new HashMap<>(); map.put("list",
	 * theaterService.readAll(cri)); map.put("pageMaker", pageMaker);
	 * 
	 * entity = new ResponseEntity<>(map, HttpStatus.OK);// 200
	 * 
	 * } catch (Exception e) { e.printStackTrace(); entity = new
	 * ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404 }
	 * System.out.println("\n\n"); return entity; }
	 */



	@ResponseBody
	@RequestMapping(value = "/match/name", method = RequestMethod.GET)
	public ResponseEntity<TheaterVO> matchNameGET(TheaterVO vo) {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> matchNameGET....");
		System.out.println("vo\t " + vo);
		ResponseEntity<TheaterVO> entity = null;

		try {
			System.out.println("vo  - > " + vo);
			System.out.println(theaterService.getMatchItemByTname(vo));

			entity = new ResponseEntity<>(theaterService.getMatchItemByTname(vo), HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}



	@ResponseBody
	@RequestMapping(value = "/search/name", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> searchByLikeName(Criteria cri) {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> searchByLikeName....");
		System.out.println("Criteria\t" + cri);
		// ResponseEntity<List<TheaterVO>> entity = null;
		ResponseEntity<Map<String, Object>> entity = null;

		try {
			Map<String, Object> map = new HashMap<>();
			map.put("list", theaterService.searchTnameByKeyWord(cri));
			map.put("total", theaterService.countPagingByLikeTname(cri));

			Iterator<String> iterator = map.keySet().iterator();
			while (iterator.hasNext()) {
				String key = (String) iterator.next();
				System.out.print("key=" + key);
				System.out.println(" value=" + map.get(key));
			}

			entity = new ResponseEntity<>(map, HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}

	/*
	 * @RequestMapping(value = "/delete", method = RequestMethod.POST) public
	 * String deletePOST(@RequestParam String json) throws Exception {
	 * 
	 * ObjectMapper om = new ObjectMapper(); JsonNode rootNode =
	 * om.readTree(json); Integer[] array =
	 * om.readValue(rootNode.get("arrNo").toString(), Integer[].class);
	 * System.out.println(Arrays.toString(array)); for (Integer integer : array)
	 * { System.out.println(integer); } // int[] array = //
	 * Arrays.stream(json).mapToInt(Integer::parseInt).toArray();
	 * 
	 * System.out.println("\n\n"); logger.info(
	 * "AdminTheaterController -> deletePOST...."); //
	 * System.out.println("arrNo[]\t" + Arrays.toString(arrNo));
	 * 
	 * int[] intArray =
	 * Arrays.stream(array).mapToInt(Integer::intValue).toArray();
	 * theaterService.remove(intArray);
	 * 
	 * System.out.println("\n\n"); return "redirect:/admin/theater"; }
	 */

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/update", method = RequestMethod.POST) public
	 * ResponseEntity<String> updatePOST(TheaterVO vo) {
	 * 
	 * System.out.println("\n\n"); logger.info(
	 * "AdminTheaterController -> updatePOST...."); System.out.println("vo\t " +
	 * vo);
	 * 
	 * ResponseEntity<String> entity = null;
	 * 
	 * try { theaterService.modify(vo); entity = new ResponseEntity<>("SUCCESS",
	 * HttpStatus.OK);// 200
	 * 
	 * } catch (Exception e) { e.printStackTrace(); entity = new
	 * ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404 }
	 * 
	 * 
	 * System.out.println("\n\n"); return entity; }
	 */
}
