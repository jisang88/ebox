package kr.co.ebox.service;

import java.util.List;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.ebox.domain.SeatingVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class SeatServiceTEST {

	private static final Logger Logger = LoggerFactory.getLogger(SeatServiceTEST.class);

	@Autowired
	private SeatingService service;



	/*
	 * @Test public void atest() throws Exception {
	 * 
	 * System.out.println(
	 * "--------------------------------------SeatServiceTEST Start--------------------------------------"
	 * ); System.out.println(
	 * "-------------------------------------------atest------------------------------------------"
	 * );
	 * 
	 * List<SeatingVO> list = service.readAll(); for (SeatingVO seatingVO :
	 * list) { System.out.println(seatingVO); }
	 * 
	 * System.out.println(
	 * "--------------------------------------SeatServiceTEST End--------------------------------------"
	 * ); }
	 * 
	 */

	@Test
	public void btest() throws Exception {

		System.out.println("--------------------------------------SeatServiceTEST Start--------------------------------------");
		System.out.println("-------------------------------------------btest------------------------------------------");

		List<SeatingVO> list = service.readForBooking(37);
		for (SeatingVO seatingVO : list) {
			System.out.println(seatingVO);
		}

		System.out.println("--------------------------------------SeatServiceTEST End--------------------------------------");
	}

}
