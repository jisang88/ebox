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

import kr.co.ebox.domain.AuditoriumVO;
import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.TheaterVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class AudiServiceTEST {

	private static final Logger Logger = LoggerFactory.getLogger(AudiServiceTEST.class);

	@Autowired
	private AuditoriumService service;



	private void startTestMethod(String methodName) {

		System.out.println();
		System.out.println();
		System.out.println("--------------------------------------AudiServiceTEST Start------------------------------------");
		System.out.println();
		System.out.println("-----------------------------------------------" + methodName + "----------------------------------------------");
		System.out.println();
		System.out.println();
	}



	private void endTestMethod() {

		System.out.println();
		System.out.println();
		System.out.println("--------------------------------------AudiServiceTEST End--------------------------------------");
		System.out.println();
		System.out.println();

	}



	/*@Test
	public void atest() throws Exception {

		startTestMethod("atest");

		Criteria cri = new Criteria();
		cri.setKeyword("1");
		List<AuditoriumVO> list = service.searchByLikeAname(cri);

		for (AuditoriumVO auditoriumVO : list) {
			System.out.println(auditoriumVO);
		}

		endTestMethod();
	}*/



	@Test
	public void dtest() throws Exception {

	}



	@Test
	public void ctest() throws Exception {

	}

}
