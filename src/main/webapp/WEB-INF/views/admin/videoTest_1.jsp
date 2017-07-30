<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<!-- https://developers.google.com/web/updates/2017/03/chrome-58-media-updates#controlslist -->
	<c:forEach var="video" items="${videoList }">


		<video controls style="width: 500px; height: 400px;" controlsList="nodownload">
			<source src="playOrinFile?filename=${video.iPath}">
		</video>


	</c:forEach>

</body>
</html>