package kr.co.ebox.controller;

import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.ebox.service.SeatingService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin/seat")
public class AdminSeatController {

	private static final Logger logger = LoggerFactory.getLogger(AdminSeatController.class);

	@Inject
	SeatingService seatService;

	private String VIEW_PATH = "admin/facilities/";
	private String REDIRECT_PATH = "redirect:/admin/facilities/";



	@RequestMapping(value = "", method = RequestMethod.GET)
	public void home(Locale locale, Model model) {

	}

}
