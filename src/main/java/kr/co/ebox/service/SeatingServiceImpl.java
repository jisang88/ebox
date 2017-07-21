package kr.co.ebox.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.ebox.domain.AuditoriumVO;
import kr.co.ebox.domain.Criteria;
import kr.co.ebox.domain.SeatingVO;
import kr.co.ebox.persistence.SeatingDAO;

@Service
public class SeatingServiceImpl implements SeatingService {

	private static final Logger logger = LoggerFactory.getLogger(SeatingServiceImpl.class);

	@Autowired
	private SeatingDAO dao;



	@Override
	public void register(String seatData, int ano) throws Exception {

		ObjectMapper om = new ObjectMapper();
		JsonNode rootNode = om.readTree(seatData);
		System.out.println(rootNode);

		Iterator<JsonNode> it = rootNode.iterator();
		Iterator<JsonNode> innerit;

		JsonNode tempSeat = null;
		SeatingVO seat = null;
		List<SeatingVO> seatList = new ArrayList<>();
		AuditoriumVO audi = null;
		while (it.hasNext()) {

			innerit = it.next().iterator();
			System.out.println("행 시작-----------------------------------");
			while (innerit.hasNext()) {
				tempSeat = innerit.next();

				seat = new SeatingVO();
				seat.setRow(tempSeat.get("row").asInt());
				seat.setCol(tempSeat.get("col").asInt());
				seat.setPosition(tempSeat.get("position").asText());

				if (tempSeat.get("stype") != null) {
					seat.setStype(tempSeat.get("stype").asText());
				}

				audi = new AuditoriumVO();
				audi.setaNo(ano);
				seat.setAudi(audi);

				System.out.println(seat);
				seatList.add(seat);
			}
		}
		// System.out.println("seatList size() = >" + seatList.size());
		System.out.println("-------------------------------------------");

		dao.insertList(seatList);
	}



	@Override
	public void modify(SeatingVO seat) throws Exception {

		dao.update(seat);
	}



	@Override
	public void removeByAudi(int ano) throws Exception {

		dao.deleteByAudi(ano);
	}



	@Override
	public SeatingVO read(int sno) throws Exception {

		return dao.selectBySno(sno);
	}



	@Override
	public List<SeatingVO> readAll(Criteria cri) throws Exception {

		return dao.selectWithCri(cri);
	}



	@Override
	public List<SeatingVO> readAll() throws Exception {

		return dao.selectAll();
	}



	@Override
	public int countPaging(Criteria cri) throws Exception {

		return dao.countPaging(cri);
	}



	@Override
	public List<SeatingVO> readForType() throws Exception {

		return dao.selectByStype();
	}



	@Override
	public int getAbleSeatCnt(int ano) throws Exception {

		return dao.getAbleSeatCnt(ano);
	}



	@Override
	public List<SeatingVO> readForBooking(int ano) throws Exception {

		return dao.selectByAudi(ano);
	}

}
