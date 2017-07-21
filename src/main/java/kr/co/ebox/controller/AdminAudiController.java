package kr.co.ebox.controller;

import java.util.List;

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

import kr.co.ebox.domain.AuditoriumVO;
import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.PageMaker;
import kr.co.ebox.domain.TheaterVO;
import kr.co.ebox.service.AuditoriumService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/audi")
public class AdminAudiController {

	private static final Logger logger = LoggerFactory.getLogger(AdminAudiController.class);

	@Inject
	AuditoriumService audiService;



	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String mainGET(Model model, PageMaker pageMaker, Criteria cri) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminAudiController -> mainGET....");
		System.out.println("Criteria\t" + cri);
		System.out.println("PageMaker\t" + pageMaker);

		pageMaker.setCri(cri);
		pageMaker.setDisplayPageNum(5);
		pageMaker.setTotalCnt(audiService.countPaging(cri));

		model.addAttribute("audiList", audiService.readAll(cri));
		model.addAttribute("pageMaker", pageMaker);

		System.out.println("\n\n");
		return "/admin/audi2";
	}



	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String writePOST(AuditoriumVO audi, TheaterVO theater, RedirectAttributes rttr) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminAudiController -> writePOST....");

		audi.setTheater(theater);
		System.out.println("audi  - > " + audi);
		audiService.register(audi);

		rttr.addFlashAttribute("result", "SUCCESS");

		System.out.println("\n\n");
		return "redirect:/admin/audi/list";
		// return "redirect:/";
	}



	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<String> deletePOST(@RequestParam(value = "aNo[]") int[] arrNo) {

		System.out.println("\n\n");
		logger.info("AdminAudiController -> deletePOST....");
		ResponseEntity<String> entity = null;

		try {
			audiService.remove(arrNo);
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}



	@ResponseBody
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public ResponseEntity<AuditoriumVO> readGET(int aNo) {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> readAllGET....");
		ResponseEntity<AuditoriumVO> entity = null;

		try {
			System.out.println("aNo  - > " + aNo);
			System.out.println(audiService.read(aNo));
			entity = new ResponseEntity<>(audiService.read(aNo), HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}



	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(AuditoriumVO audi, TheaterVO theater, Criteria cri, RedirectAttributes rttr) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminTheaterController -> updatePOST....");

		ResponseEntity<String> entity = null;

		audi.setTheater(theater);
		System.out.println(audi);

		audiService.modify(audi);

		rttr.addFlashAttribute("result", "SUCCESS");
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("page", cri.getPage());

		System.out.println("\n\n");
		return "redirect:/admin/audi/list";
	}
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/update", method = RequestMethod.POST) public
	 * ResponseEntity<String> updatePOST(AuditoriumVO audi, TheaterVO theater) {
	 * 
	 * System.out.println("\n\n"); logger.info(
	 * "AdminTheaterController -> updatePOST....");
	 * 
	 * ResponseEntity<String> entity = null;
	 * 
	 * audi.setTheater(theater); System.out.println(audi);
	 * 
	 * try { audiService.modify(audi); entity = new ResponseEntity<>("SUCCESS",
	 * HttpStatus.OK);// 200
	 * 
	 * } catch (Exception e) { e.printStackTrace(); entity = new
	 * ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404 }
	 * System.out.println("\n\n"); return entity; }
	 */



	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/list", method = RequestMethod.GET) public
	 * ResponseEntity<Map<String, Object>> readAllGET(PageMaker pageMaker,
	 * Criteria cri) {
	 * 
	 * System.out.println("\n\n"); logger.info(
	 * "AdminAudiController -> readAllGET...."); System.out.println("Criteria\t"
	 * + cri); System.out.println("PageMaker\t" + pageMaker);
	 * 
	 * ResponseEntity<Map<String, Object>> entity = null;
	 * 
	 * try { cri.setPerPageNum(10); pageMaker.setCri(cri);
	 * pageMaker.setDisplayPageNum(5);
	 * pageMaker.setTotalCnt(audiService.countPaging(cri));
	 * 
	 * Map<String, Object> map = new HashMap<>(); map.put("list",
	 * audiService.readAll(cri)); map.put("pageMaker", pageMaker);
	 * 
	 * entity = new ResponseEntity<>(map, HttpStatus.OK);// 200
	 * 
	 * } catch (Exception e) { e.printStackTrace(); entity = new
	 * ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404 }
	 * System.out.println("\n\n"); return entity; }
	 */

	@ResponseBody
	@RequestMapping(value = "/listTno", method = RequestMethod.GET)
	public ResponseEntity<List<AuditoriumVO>> listTnoGET(int tNo) {

		System.out.println("\n\n");
		logger.info("AdminAudiController -> readAllGET....");
		// System.out.println("Criteria\t" + tNo);
		System.out.println("tNo\t" + tNo);

		ResponseEntity<List<AuditoriumVO>> entity = null;

		try {

			List<AuditoriumVO> list = audiService.listByTno(tNo);
			for (AuditoriumVO auditoriumVO : list) {
				System.out.println(auditoriumVO);
			}

			entity = new ResponseEntity<>(audiService.listByTno(tNo), HttpStatus.OK);// 200

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 404
		}
		System.out.println("\n\n");
		return entity;
	}

}
