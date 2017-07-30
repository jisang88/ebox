<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../include/header2.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/movie.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/resources/dist/handlebars-v4.0.10/handlebars-v4.0.10.js"></script>
<script src="${pageContext.request.contextPath }/resources/dist/moment.js"></script>

<link href="${pageContext.request.contextPath }/resources/plugin/select2/select2.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/plugin/select2/select2-bootstrap.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath }/resources/plugin/select2/select2.min.js"></script>

<link href="${pageContext.request.contextPath }/resources/plugin/flatpickr/flatpickr.min.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/plugin/flatpickr/flatpickr.min.js"></script>





<div id="page-wrapper">


	<!-- Page Heading -->
	<div class="row">
		<div class="col-xs-12">
			<h1 class="page-header">영화 데이터</h1>
		</div>
	</div>
	<!-- /.row -->


	<script type="text/javascript">
		var URL_MOVIE = {
			WRITE : "${pageContext.request.contextPath }/admin/movie/write",
			READ : "${pageContext.request.contextPath }/admin/movie/read",
			LIST : "${pageContext.request.contextPath }/admin/movie/list"
		}
		var URL_IMAGE = {
			WRITE : "${pageContext.request.contextPath }/admin/movie/image/write",
			LIST : "${pageContext.request.contextPath }/admin/movie/image/list",
			DELETE : "${pageContext.request.contextPath }/admin/movie/image/delete",
			UPDATE : "${pageContext.request.contextPath }/admin/movie/image/update",
		}

		var CRITERIA = {
			page : parseInt('${cri.page}'),
			keyword : '${cri.keyword}',
			searchType : '${cri.searchType}',
			mNo : parseInt('${movie.mNo}')
		}

		$(function() {

			/*------------------------------------------------------------------
				form-1 event
			-------------------------------------------------------------------- */

			$('#btn-submit-form-1').click(function() { // form-1 submit button
				event.preventDefault();
				console.log('btn-submit-form-1');

				//폼 유효성 체크				
				/* ------------------------------------------------------ */
				$('#form-1 .help-inline').css('visibility', 'hidden');

				var isValid = true;
				$('.list-1').each(function(i, elt) {
					var $radio = $(elt).find('input:radio[name="optradio' + $(elt).data('index') + '"]:checked');
					if ($radio.length < 1) {
						console.log($radio)
						$(elt).find('.file-type-box').find('.help-inline').css('visibility', 'initial');
						isValid = false;
					}
				});
				if (!isValid) return;

				/* ------------------------------------------------------ */
				var formData = new FormData();

				if (!ebox.isValid(CRITERIA.mNo)) CRITERIA.mNo = 0;
				formData.append('mNo', CRITERIA.mNo);

				var len = gnb_fileList.length;

				for (var i = 0; i < len; i++) {
					var mFile = gnb_fileList[i];

					if (mFile.mtype == 'poster') formData.append('posterList', gnb_fileList[i]);
					else if (mFile.mtype == 'horizontal poster') formData.append('hPosterList', gnb_fileList[i]);
					else if (mFile.mtype == 'still cut') formData.append('stillCutList', gnb_fileList[i]);
					else if (mFile.mtype == 'event') formData.append('eventList', gnb_fileList[i]);
					else if (mFile.mtype == 'video') formData.append('videoList', gnb_fileList[i]);
				}

				$.ajax({
					url : URL_IMAGE.WRITE,
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					success : function(result) {
						if (result === 'SUCCESS') {
							//alert('성공');
							location.replace(URL_IMAGE.LIST + ebox.makeQuery(CRITERIA) + '&mNo=' + CRITERIA.mNo);
						} else {
							//alert('실패');
						}
					}
				});

			});

			$('#btn-file-upload-1').click(function() {
				$('#file-1').click();
			})
		});

		function hideHelpText() {
			$('#form-1').find('.help-block').css('visibility', 'hidden');
			$('#form-1').find('.help-inline').css('visibility', 'hidden');
		}
	</script>


	<div class="row" id="panel-wrapper-1">
		<div class="col-xs-12">

			<form action="" id="form-1" method="post" autocomplete="off" enctype="multipart/form-data">
				<div class="panel-group-wrapper">

					<div class="panel panel-basic">
						<div class="panel-body ">
							<div class="row">
								<div class="col-xs-5">
									<h2>
										<span class="title">영화 제목 : ${movie.mNm} </span>
									</h2>

								</div>
								<div class="text-right col-xs-7">
									<div class="form-btn-group">
										<button type="button" class="btn btn-inverse text-bold waves-effect waves-light" id="btn-submit-form-1">저장</button>
										<!-- <button type="reset" class="btn btn-default text-bold waves-effect" id="btn-reset-form-1">입력취소</button> -->
									</div>
								</div>
							</div>
						</div>
					</div>


					<div class="panel panel-basic col-xs-6">
						<div class="panel-heading text-default">
							<div class="row">
								<div class="col-xs-6">
									<span class="title">추가 할 콘텐츠 리스트</span>
								</div>
								<div class="text-right col-xs-6">
									<button type="button" class="btn btn-primary text-bold waves-effect waves-light" id="btn-file-upload-1">이미지 추가</button>
									<input type="file" id="file-1" multiple="multiple" style="display: none;">
								</div>
							</div>
						</div>

						<div class="panel-body list-group-wrap">
							<!-- 여기에 이미지 업로드 파일 미리보기 list 하면됨. -->
							<ul class="list-group" id="file-list-group"></ul>
						</div>

					</div>



					<div class="panel panel-basic col-xs-6">
						<div class="panel-heading text-default">
							<span class="title">저장된 콘텐츠 리스트</span>
						</div>


						<div class="panel-body list-group-wrap">
							<!-- 여기에 영화 정보 입력 하면됨. -->
							<!-- 여기에 이미지 업로드 파일 미리보기 list 하면됨. -->
							<ul class="list-group" id="file-list-group-2">
								<c:forEach var="item" items="${list}">

									<li class="list-group-item list-2">

										<div class="row text-right">
											<button type="button" class="btn btn-inverse text-bold btn-xs waves-effect waves-light btn-thumnail-delete" data-ino="${item.iNo}">
												<i class="fa fa-times" aria-hidden="true"></i>
											</button>
										</div>

										<div class="row">

											<c:choose>
												<c:when test="${item.iType eq 'video'}">
													<div class="col-xs-12 " style="padding: 0;">
														<div class="thumnail-box thumnail-video-box">
															<video class="thumnail thumnail-video" controls>
																<source src="${pageContext.request.contextPath }/admin/movie/playFile?filename=${item.iPath}">
															</video>
														</div>
													</div>
												</c:when>
												<c:otherwise>
													<div class="col-xs-2 " style="padding: 0;">
														<div class="thumnail-box">
															<img src="${pageContext.request.contextPath }/admin/movie/displayFile?filename=${item.iPath}" class="thumnail" />
															<!-- <img src="http://via.placeholder.com/100x100" class="thumnail" /> -->
														</div>
													</div>
												</c:otherwise>
											</c:choose>



											<div class="col-xs-10">
												<div class="row">
													<div class="file-name-box">
														<span>파일 이름</span> : <span class="file-name text-bold">${item.iName }</span>
													</div>
												</div>

												<div class="row">
													<div class="file-size-box">
														<span>파일 용량</span> :

														<c:set var="_1GB" value="${1024 * 1024 * 1024}" />
														<c:set var="_1MB" value="${1024 * 1024}" />
														<c:set var="_1KB" value="${1024}" />

														<c:choose>
															<c:when test="${item.iSize >= _1GB}">
																<span class="file-size text-bold"><fmt:formatNumber value="${item.iSize/_1GB}" pattern=".00" /> GB</span>
															</c:when>
															<c:when test="${item.iSize >= _1MB}">
																<span class="file-size text-bold"><fmt:formatNumber value="${item.iSize/_1MB}" pattern=".00" /> MB</span>
															</c:when>
															<c:when test="${item.iSize >= _1KB}">
																<span class="file-size text-bold"><fmt:formatNumber value="${item.iSize/_1KB}" pattern=".00" /> KB</span>
															</c:when>
															<c:otherwise>
																<span class="file-size text-bold">${item.iSize} Byte</span>
															</c:otherwise>
														</c:choose>

													</div>
												</div>

												<div class="row" style="margin-top: 10px;">
													<div class="file-type-box">

														<span>이미지 타입</span> : <span class="help-inline text-fail ">이미지 타입을 선택해주세요.</span>

														<div style="font-size: 12px; margin-top: 5px;">
															<label class="radio-inline ${item.iType eq 'poster'? 'radio-label':''}"><input type="radio" value="poster" ${item.iType eq 'poster'? 'checked':''} disabled>포스터</label>
															<!--  -->
															<label class="radio-inline ${item.iType eq 'horizontal poster'? 'radio-label':''}"><input type="radio" value="horizontal poster" ${item.iType eq 'horizontal poster'? 'checked':''} disabled>가로 포스터</label>
															<!--  -->
															<label class="radio-inline ${item.iType eq 'still cut'? 'radio-label':''}"><input type="radio" value="still cut" ${item.iType eq 'still cut'? 'checked':''} disabled> 스틸컷</label>
															<!--  -->
															<label class="radio-inline ${item.iType eq 'event'? 'radio-label':''}"><input type="radio" value="event" ${item.iType eq 'event'? 'checked':''} disabled> 이벤트</label>
															<!--  -->
															<label class="radio-inline ${item.iType eq 'video'? 'radio-label':''}"><input type="radio" value="video" ${item.iType eq 'video'? 'checked':''} disabled> 영상</label>
														</div>

													</div>
												</div>

											</div>

										</div>
									</li>

								</c:forEach>
							</ul>

						</div>
					</div>


					<!-- </div> -->
				</div>
				<!-- end of panel-group-wrapper -->
			</form>




		</div>

	</div>
</div>

<script>
	var gnb_fileList = [];

	$(function() {

		$('#file-1').change(function(e) {

			var fileGroup = e.target.files;
			var len = fileGroup.length;

			for (var i = 0; i < len; i++) {
				gnb_fileList.push(fileGroup[i]);
			}

			loadThumnailList(gnb_fileList);
		});

		Handlebars.registerHelper('if_eq', function(a, b, opts) {
			if (a == b) return opts.fn(this);
			else return opts.inverse(this);
		});

	});//

	function loadThumnailList(fileList) {
		var len = fileList.length;

		var list_box = $('#file-list-group');
		ebox.setTemplate(list_box, $('#thumnail-list-item-template'), fileList);

		//

		for (var i = 0; i < len; i++) {

			var file = fileList[i];
			var _new_li = list_box.find('li[data-index="' + i + '"]');

			var size = ebox.getFileSizeFormat(file);
			_new_li.find('.file-size').text(size);
			_new_li.find('.file-name').text(file.name);

			var _new_img = $('<img class="thumnail"/>');
			var _new_video = $('<video class="thumnail"/>');

			var _thumnail_box = _new_li.find('.thumnail-box');
			_thumnail_box.empty();
			_thumnail_box.append(_new_img);
			_thumnail_box.append(_new_video);

			if (file.type.indexOf('image') > -1) {
				ebox.setImagePreview(_new_img, file);
				_new_video.remove();
			} else {
				ebox.setVideoPreview(_new_video, file);
				_new_img.remove();
			}

		}

	}

	$(document).on('click', '.btn-thumnail-cancel', function() {
		gnb_fileList.splice($(this).data('index'), 1);
		loadThumnailList(gnb_fileList);
	});

	$(document).on('click', '.btn-thumnail-delete', function() {
		console.log('delete button click\t', $(this).data('ino'))

		$.post(URL_IMAGE.DELETE, {
			iNo : [ $(this).data('ino') ]
		}, function(data) {
			console.log('back');
			location.replace(URL_IMAGE.LIST + ebox.makeQuery(CRITERIA) + '&mNo=' + CRITERIA.mNo);
		});

	});

	$(document).on('change', '.thumnail-type-opt', function() {
		var index = $(this).data('index');
		var type = $(this).val();
		gnb_fileList[index].mtype = type;
	});
</script>

<script id="thumnail-list-item-template" type="text/x-handlebars-template">
{{#each.}}
	<li class="list-group-item list-1" data-index="{{@index}}">

		<div class="row text-right">
			<button type="button" class="btn btn-inverse text-bold btn-xs waves-effect waves-light btn-thumnail-cancel" data-index="{{@index}}">
				<i class="fa fa-times" aria-hidden="true"></i>
			</button>
		</div>

		<div class="row">

			<div class="col-xs-2 " style="padding: 0;">
				<div class="thumnail-box">
					<img src="http://via.placeholder.com/100x100" class="thumnail" />
				</div>
			</div>

			<div class="col-xs-10">
				<div class="row">
					<div class="file-name-box">
						<span>파일 이름</span> : <span class="file-name text-bold"></span>
					</div>
				</div>

				<div class="row">
					<div class="file-size-box">
						<span>파일 용량</span> : <span class="file-size text-bold"></span>
					</div>
				</div>

				<div class="row" style="margin-top: 10px;">
					<div class="file-type-box">
						<span>이미지 타입</span> : <span class="help-inline text-fail ">이미지 타입을 선택해주세요.</span>
							<div style="font-size: 12px; margin-top: 5px;">
								<label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="poster" class="thumnail-type-opt" data-index="{{@index}}"{{#if_eq "poster" mtype}} checked {{/if_eq}}> 포스터
								</label> <label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="horizontal poster" class="thumnail-type-opt" data-index="{{@index}}"{{#if_eq "horizontalposter" mtype}}  checked  {{/if_eq}}> 가로 포스터
								</label> <label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="still cut" class="thumnail-type-opt" data-index="{{@index}}"{{#if_eq "stillcut" mtype}}  checked  {{/if_eq}}> 스틸컷
								</label> <label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="event" class="thumnail-type-opt" data-index="{{@index}}"{{#if_eq "event" mtype}}  checked  {{/if_eq}}> 이벤트
								</label> <label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="video" class="thumnail-type-opt" data-index="{{@index}}"{{#if_eq "video" mtype}}  checked  {{/if_eq}}> 영상
								</label>
							</div>
					</div>
				</div>

			</div>

		</div>

	</li>
{{/each}}
</script>

<%@ include file="../include/footer2.jsp"%>