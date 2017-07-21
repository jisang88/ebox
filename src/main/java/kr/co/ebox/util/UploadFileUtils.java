package kr.co.ebox.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.co.ebox.domain.ImageVO;
import kr.co.ebox.domain.MovieVO;

public class UploadFileUtils {
	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);



	public static String makeThumbnail(String uploadPath, String filename) throws IOException {

		String thumbnailName = "";

		// 원본 이미지 가져오기
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath, filename));

		// 썹네일 이미지 데이타 만들기, 썸네일 이미지의 높이를 뒤의 100px로 동일하게 만들음.
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 300);
		thumbnailName = uploadPath + "/" + "s_" + filename;

		File newFile = new File(thumbnailName);
		String format = filename.substring(filename.lastIndexOf(".") + 1);// 확장자
																			// 찾기

		// Thumbnail 경로/파일 이름에 resizing된 이미지를 넣는다.
		ImageIO.write(destImg, format.toUpperCase(), newFile);

		return "s_" + filename;
	}



	public static String uploadFile(Map map) throws Exception {

		String uploadPath = (String) map.get("uploadPath");

		MultipartFile file = (MultipartFile) map.get("file");
		String originalName = file.getOriginalFilename();
		byte[] fileData = file.getBytes();

		// Upload 부분
		UUID uid = UUID.randomUUID();// 고유한 키 이름
		String savedName = uid.toString() + "_" + originalName;

		String savedPath = calcPath(map);

		File target = new File(uploadPath + savedPath, savedName);// 외부 경로에 파일

		// 생성
		FileCopyUtils.copy(fileData, target);// file upload됨

		String thumFile = UploadFileUtils.makeThumbnail(uploadPath + savedPath, savedName);

		return savedPath + "/" + thumFile;

	}



	private static String calcPath(Map map) {

		String uploadPath = (String) map.get("uploadPath");
		MovieVO movie = (MovieVO) map.get("movie");
		String type = (String) map.get("type");
		System.out.println("---movie \t\t " + movie);
		Calendar cal = Calendar.getInstance();

		String yearPath = "/" + cal.get(Calendar.YEAR);
		System.out.println("---타이틀 \t\t " + movie.getmNmEn().trim());

		String titlePath = String.format("%s/%s", yearPath, movie.getmNmEn().trim().replace(":", " ").replace("  ", " ").toLowerCase());
		String dataPath = null;

		if (type.equals(ImageVO.TYPE_POSTER)) {
			dataPath = String.format("%s/%s", titlePath, ImageVO.TYPE_POSTER);
		} else if (type.equals(ImageVO.TYPE_H_POSTER)) {
			dataPath = String.format("%s/%s", titlePath, ImageVO.TYPE_H_POSTER);
		} else if (type.equals(ImageVO.TYPE_STILLCUT)) {
			dataPath = String.format("%s/%s", titlePath, ImageVO.TYPE_STILLCUT);
		} else if (type.equals(ImageVO.TYPE_EVENT)) {
			dataPath = String.format("%s/%s", titlePath, ImageVO.TYPE_EVENT);
		} else if (type.equals(ImageVO.TYPE_VIDEO)) {
			dataPath = String.format("%s/%s", titlePath, ImageVO.TYPE_VIDEO);
		}

		makeDir(uploadPath, yearPath, titlePath, dataPath);
		return dataPath;

	}



	/*-------------------------------------------------------------------------------------------------------------------------------------*/

	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {

		// Upload 부분
		UUID uid = UUID.randomUUID();// 고유한 키 이름
		String savedName = uid.toString() + "_" + originalName;

		String savedPath = calcPath(uploadPath);

		File target = new File(uploadPath + savedPath, savedName);// 외부 경로에 파일
																	// 생성
		FileCopyUtils.copy(fileData, target);// file upload됨

		String thumFile = UploadFileUtils.makeThumbnail(uploadPath + savedPath, savedName);

		return savedPath + "/" + thumFile;

	}



	private static String calcPath(String uploadPath) {

		Calendar cal = Calendar.getInstance();

		String yearPath = "/" + cal.get(Calendar.YEAR);
		String monthPath = String.format("%s/%02d", yearPath, cal.get(Calendar.MONTH) + 1);
		String dataPath = String.format("%s/%02d", monthPath, cal.get(Calendar.DATE));

		makeDir(uploadPath, yearPath, monthPath, dataPath);
		return dataPath;

	}



	public static void makeDir(String uploadPath, String... paths) {

		for (String path : paths) {
			File dirPath = new File(uploadPath + path);

			if (!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
}
