package kr.co.ebox.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.ebox.domain.AuditoriumVO;
import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.FullCalendar;
import kr.co.ebox.domain.ScheduleVO;
import kr.co.ebox.domain.ScreenVO;
import kr.co.ebox.service.ScheduleService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/schedule")
public class AdminScheduleController {

	private static final Logger logger = LoggerFactory.getLogger(AdminScheduleController.class);

	@Inject
	ScheduleService scheduleServices;



	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String writeGET(Model model, Criteria cri) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminScheduleController -> writeGET....");
		System.out.println("Criteria\t" + cri);

		// model.addAttribute("audiList", audiService.readAll(cri));

		System.out.println("\n\n");
		return "/admin/scheduleWrite";

	}



	@ResponseBody
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public ResponseEntity<String> writePOST(@RequestBody FullCalendar fullcalendar) throws Exception {

		System.out.println("\n\n");
		logger.info("AdminScheduleController -> writePOST....");

		ResponseEntity<String> entity = null;

		int aNo = fullcalendar.getaNo();
		AuditoriumVO audi = new AuditoriumVO();
		audi.setaNo(aNo);

		int scrNo = fullcalendar.getScrNo();
		ScreenVO screen = new ScreenVO();
		screen.setScrNo(scrNo);

		List<ScheduleVO> list = fullcalendar.getScheduleList();
		for (ScheduleVO scheduleVO : list) {
			scheduleVO.setAudi(audi);
			scheduleVO.setScreen(screen);
			System.out.println(scheduleVO);
		}

		try {

			// scheduleServices.write();
			scheduleServices.write(list);
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);// 200
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 400
		}
		System.out.println("\n\n");

		return entity;
	}



	@ResponseBody
	@RequestMapping(value = "/calendar/list", method = RequestMethod.GET)
	public ResponseEntity<List<ScheduleVO>> calendarListGET(int aNo, @DateTimeFormat(pattern = "yyyy-MM-dd") Date start, @DateTimeFormat(pattern = "yyyy-MM-dd") Date end)
			throws Exception {

		System.out.println("\n\n");
		logger.info("AdminScheduleController -> calendarListGET....");

		ResponseEntity<List<ScheduleVO>> entity = null;

		try {
			System.out.println("aNo\t" + aNo);
			System.out.println("start\t" + start);
			System.out.println("end\t" + end);

			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			map.put("aNo", aNo);

			List<ScheduleVO> list = scheduleServices.getListByAno(map);
			for (ScheduleVO scheduleVO : list) {
				System.out.println("calendarListGET\t" + scheduleVO);
			}

			entity = new ResponseEntity<>(list, HttpStatus.OK);// 200
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);// 400
		}
		System.out.println("\n\n");

		return entity;
	}

}
