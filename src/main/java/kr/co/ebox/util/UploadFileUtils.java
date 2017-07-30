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

public class UploadFileUtils {
	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);



	public static String makeThumbnail(String uploadPath, String filename) throws IOException {

		String thumbnailName = "";

		// 원본 이미지 가져오기
		// uploadPath - > 폴더
		// filename - > 파일
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath, filename));

		// 썹네일 이미지 데이타 만들기, 썸네일 이미지의 높이를 뒤의 300px로 동일하게 만들음.
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

		// Upload 부분
		UUID uid = UUID.randomUUID();// 고유한 키 이름
		MultipartFile file = (MultipartFile) map.get("file");

		String uploadPath = (String) map.get("uploadPath");
		String savedName = uid.toString() + "_" + file.getOriginalFilename();
		String savedPath = calcPath(uploadPath);

		// 생성 -> file upload됨
		System.out.println("파일카피");
		FileCopyUtils.copy(file.getBytes(), new File(uploadPath + savedPath, savedName));

		String contentType = file.getContentType();
		if (!contentType.contains("video")) {
			String thumFile = UploadFileUtils.makeThumbnail(uploadPath + savedPath, savedName);
			return savedPath + "/" + thumFile;
		} else {
			System.out.println("동영상 파일");
			return savedPath + "/" + savedName;
		}

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
