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

import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.TheaterVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class TheaterServiceTEST {

	private static final Logger Logger = LoggerFactory.getLogger(TheaterServiceTEST.class);

	@Autowired
	private TheaterService service;



	private void startTestMethod(String methodName) {

		System.out.println();
		System.out.println();
		System.out.println("--------------------------------------TheaterServiceTEST Start------------------------------------");
		System.out.println();
		System.out.println("-----------------------------------------------" + methodName + "----------------------------------------------");
		System.out.println();
		System.out.println();
	}



	private void endTestMethod() {

		System.out.println();
		System.out.println();
		System.out.println("--------------------------------------TheaterServiceTEST End--------------------------------------");
		System.out.println();
		System.out.println();

	}



	/*
	 * @Test public void atest() throws Exception {
	 * 
	 * startTestMethod("atest");
	 * 
	 * TheaterVO vo = new TheaterVO(); vo.settAddrNum("123");
	 * vo.settAddrSt("sdf"); vo.settManager("sdf"); vo.settName("sdf");
	 * vo.settTel("sdf"); System.out.println(vo); // service.regist(vo);
	 * 
	 * endTestMethod(); }
	 * 
	 */

	@Test
	public void btest() throws Exception {

		startTestMethod("btest");

		TheaterVO theater = new TheaterVO();
		theater.settName("공단".trim());
		theater.settNo(1);
		System.out.println(theater);

		List<TheaterVO> list = service.readAllByVO(theater);

		for (TheaterVO item : list) {
			System.out.println("item -->" + item);
		}

		endTestMethod();
	}



	@Test
	public void ctest() throws Exception {

		startTestMethod("ctest");

		Criteria cri = new Criteria();
		cri.setPerPageNum(5);
		cri.setKeyword("22");

		System.out.println(cri);

		List<TheaterVO> list = service.searchTnameByKeyWord(cri);

		for (TheaterVO item : list) {
			System.out.println("item -->" + item);
		}

		endTestMethod();
	}

}
