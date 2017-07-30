package kr.co.ebox.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {

	List<MultipartFile> posterList;
	List<MultipartFile> hPosterList;
	List<MultipartFile> stillCutList;
	List<MultipartFile> eventList;
	List<MultipartFile> videoList;



	public List<MultipartFile> getPosterList() {

		return posterList;
	}



	public void setPosterList(List<MultipartFile> posterList) {

		this.posterList = posterList;
	}



	public List<MultipartFile> gethPosterList() {

		return hPosterList;
	}



	public void sethPosterList(List<MultipartFile> hPosterList) {

		this.hPosterList = hPosterList;
	}



	public List<MultipartFile> getStillCutList() {

		return stillCutList;
	}



	public void setStillCutList(List<MultipartFile> stillCutList) {

		this.stillCutList = stillCutList;
	}



	public List<MultipartFile> getEventList() {

		return eventList;
	}



	public void setEventList(List<MultipartFile> eventList) {

		this.eventList = eventList;
	}



	public List<MultipartFile> getVideoList() {

		return videoList;
	}



	public void setVideoList(List<MultipartFile> videoList) {

		this.videoList = videoList;
	}



	@Override
	public String toString() {

		return "FileVO [posterList=" + posterList + ", hPosterList=" + hPosterList + ", stillCutList=" + stillCutList + ", eventList=" + eventList + ", videoList=" + videoList;
	}

}
