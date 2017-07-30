<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../include/header2.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/movie.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/resources/dist/handlebars-v4.0.10/handlebars-v4.0.10.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/KobisOpenAPIRestService.js"></script>
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
		var datePickr;

		// page init

		/* $(document).ajaxStart(function() {
			Pace.restart();
		}); */

		$(function() {

			datePickr = $("#mOpenDt").flatpickr();
			var URL_MOVIE = {
				WRITE : "${pageContext.request.contextPath }/admin/movie/write",
				READ : "${pageContext.request.contextPath }/admin/movie/read",
				LIST : "${pageContext.request.contextPath }/admin/movie/list"
			}
			//--------------------------------------------------------------------
			function setHelpText() {
				//Input Text Check
				if (!ebox.setHelpTextForInput_TextForVisibility($('#mNm'))) { return false; }
				if (!ebox.setHelpTextForInput_TextForVisibility($('#mDirector'))) { return false; }
				return true;
			}

			/*
			----------------------------------------------------------------

				form-1 event
			
			--------------------------------------------------------------------
			 */

			//
			// form-1 submit button
			//
			$('#btn-submit-form-1').click(function() {
				event.preventDefault();
				console.log('btn-submit-form-1');

				//폼 유효성 체크				
				/* ------------------------------------------------------ */
				$('#form-1 .help-inline').css('visibility', 'hidden');

				/* $('#mNm').val('');
				$('#mDirector').val(''); */

				var isValid = true;
				$('.list-group-item').each(function(i, elt) {
					var $radio = $(elt).find('input:radio[name="optradio' + $(elt).data('index') + '"]:checked');
					if ($radio.length < 1) {
						console.log($radio)
						$(elt).find('.file-type-box').find('.help-inline').css('visibility', 'initial');
						isValid = false;
					}
				});

				if (!setHelpText()) return;
				if (!isValid) return;

				/* ------------------------------------------------------ */
				var form = $('#form-1');
				var formData = new FormData(form[0]);

				var len = gnb_fileList.length;

				for (var i = 0; i < len; i++) {
					var mFile = gnb_fileList[i];

					if (mFile.mtype == 'poster') {
						formData.append('posterList', gnb_fileList[i]);

					} else if (mFile.mtype == 'horizontal poster') {
						formData.append('hPosterList', gnb_fileList[i]);

					} else if (mFile.mtype == 'still cut') {
						formData.append('stillCutList', gnb_fileList[i]);

					} else if (mFile.mtype == 'event') {
						formData.append('eventList', gnb_fileList[i]);

					} else if (mFile.mtype == 'video') {
						formData.append('videoList', gnb_fileList[i]);

					}

				}

				//prograss start
				Pace.start();
				$.ajax({
					url : URL_MOVIE.WRITE,
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					success : function(result) {
						//prograss stop
						Pace.stop();
						if (result === 'SUCCESS') {
							//alert('성공');
							location.replace(URL_MOVIE.LIST);
						} else {
							//alert('실패');
						}
					}
				});

				//$('#form-1').attr('action', URL_MOVIE.WRITE);
				//$('#form-1').submit();
			});

			//
			// form-1 reset button
			//
			$('#btn-reset-form-1').click(function() {
				console.log('btn-reset-form-1');
				$('#movie_search_by_API').empty(); // ${'#tNo'}는 btn-reset에 의해 자동 초기화 됨.
				hideHelpText();

			});

		});

		function hideHelpText() {
			$('#form-1').find('.help-block').css('visibility', 'hidden');
			$('#form-1').find('.help-inline').css('visibility', 'hidden');
		}

		function formInputReset() {

			$('#mNm').val('');
			$('#mNmEn').val('');
			$('#mShowTm').val('');
			$('#mOpenDt').val('');
			$('#mDirector').val('');
			$('#mWatchGradeNm').val('');
			$('#mNationNm').val('');
			$('#mGenreNm').val('');
			$('#mStory').val('');
			$('#mActors').val('');
		}
	</script>

	<script type="text/javascript">
		var key = '22e86e647bc2882d832ab244374b4f0b';
		var Movie_Kobis_API = new KobisOpenAPIRestService(key, false);

		var URL_HOST = "http://www.kobis.or.kr";
		var URI_MOVIE_LIST = "/kobisopenapi/webservice/rest/movie/searchMovieList";
		var tempId = 0;
		$(function() {
			//
			// MOVIE search and select 
			//

			$("#movie_search_by_API").select2({
				placeholder : "검색 후 선택",
				width : '100%',
				theme : "bootstrap",
				minimumInputLength : 2,
				ajax : {
					url : URL_HOST + URI_MOVIE_LIST + ".json",
					dataType : 'json',
					delay : 300,
					async : false,
					cache : true,
					data : function(params) {
						return {
							key : key,
							movieNm : params.term, // search term
							curPage : params.page,
						};
					},
					processResults : function(data, params) {
						params.page = params.page || 1;
						return {
							results : $.map(data.movieListResult.movieList, function(vo) {
								return {
									id : vo.movieCd,
									text : vo.movieNm,
									movie : vo
								}
							}),
							pagination : {
								more : (params.page * 10) < data.movieListResult.totCnt
							}
						};

					}// END OF processResults
				},// END OF ajax
				templateResult : function(item) {
					if (item.id == null || typeof item.id == 'undefined') { return null; }

					var $item_box = $('<div class="select_list"><div/>');
					var $first_line = $('<p/>');
					var $sec_line = $('<p/>');
					var $last_line = $('<p/>');

					// first line ------------------------------------------------------------

					var $span_movieNm = $('<span class="span_movieNm"><span/>');
					$span_movieNm.text(item.movie.movieNm);

					var $span_movieNmEn = $('<span class="span_movieNmEn"><span/>');
					if (ebox.isValid(item.movie.movieNmEn)) $span_movieNmEn.text('(' + item.movie.movieNmEn + ")");

					$first_line.append($span_movieNm);
					$first_line.append($span_movieNmEn);

					$item_box.append($first_line);

					// second line ------------------------------------------------------------
					var $span_open = $('<span class="span_open"><span/>');

					if (ebox.isValid(item.movie.openDt)) {
						$span_open.text('개봉날짜 : ' + moment(item.movie.openDt).format('YYYY-MM-DD'));
					} else {
						$span_open.text('개봉날짜 : 정보없음');
					}

					$sec_line.append($span_open);
					$item_box.append($sec_line);

					// last line ------------------------------------------------------------
					var $span_dir = $('<span class="span_dir"><span/>');
					var directors = '';
					item.movie.directors.forEach(function(elt, i, array) {
						directors += elt.peopleNm + ',';
					});
					$span_dir.text('감독 : ' + directors.slice(0, -1));

					$last_line.append($span_dir);
					$item_box.append($last_line);
					//--------------------------------------------------------------------------

					//return item.text;
					return $item_box;
				},
				templateSelection : function(item) {
					if (!item.id) { return item.text; }

					var $span1 = $('<span/>');
					$span1.text(item.movie.movieNm);

					var $span2 = $('<span style="font-size:12px; margin-left:5px;"><span/>');
					if (ebox.isValid(item.movie.movieNmEn)) $span2.text('(' + item.movie.movieNmEn + ")");

					$span1.append($span2);

					return $span1;
				}
			}).on('select2:close', function(e) {
				$('#movie_search_by_API').focus();
			}).on("select2:select", function(e) {
				hideHelpText();
				console.log(e.params.data)
				var item = e.params.data;
				formInputReset();

				var movie_data = Movie_Kobis_API.getMovieInfo(true, {
					movieCd : item.id
				});
				var detail = movie_data.movieInfoResult.movieInfo;

				try {
					$('#mNm').val(item.movie.movieNm);
					$('#mNmEn').val(item.movie.movieNmEn);
					$('#mShowTm').val(detail.showTm);

					datePickr.setDate(moment(detail.openDt).format('YYYY-MM-DD'));

					var directors = '';
					item.movie.directors.forEach(function(elt, i, array) {
						directors += elt.peopleNm + ',';
					});

					$('#mDirector').val(directors.slice(0, -1));

					$('#mWatchGradeNm').val(detail.audits[0].watchGradeNm);
					$('#mNationNm').val(item.movie.nationAlt);
					$('#mGenreNm').val(item.movie.genreAlt);
				} catch (e) {
					// TODO: handle exception
					console.log(e)
				}

				//줄거리 때문에 다음 api도 같이 사용
				var reqAjax = $.ajax({
					url : "https://apis.daum.net/contents/movie",
					dataType : "jsonp",
					data : {
						apikey : '0073bd4b3ebb3edda330222373934007',
						q : item.movie.movieNm,
						output : 'json'
					},
					success : function(data) {
						console.log(data)
						try {
							$('#mStory').val(data.channel.item[0].story[0].content.trim());

							var actors = '';
							data.channel.item[0].actor.forEach(function(elt, i, array) {
								actors += elt.content + ',';
							});
							$('#mActors').val(actors.slice(0, -1));
						} catch (e) {
							// TODO: handle exception
							console.log(e)
						}
					}
				});

			});

		});
	</script>


	<div class="row" id="panel-wrapper-1">
		<div class="col-xs-12">

			<form action="" id="form-1" method="post" autocomplete="off" enctype="multipart/form-data">
				<div class="panel-group-wrapper">

					<!-- <div class="panel-group"> -->


					<div class="panel panel-basic">
						<div class="panel-body ">
							<div class="row">
								<div class="col-xs-5">
									<h2>
										<span class="title">영화 등록</span>&nbsp;<i class="fa fa-plus" aria-hidden="true"></i>
									</h2>
									<!-- -->

								</div>
								<div class="text-right col-xs-7">
									<div class="form-btn-group">
										<button type="button" class="btn btn-inverse text-bold waves-effect waves-light" id="btn-submit-form-1">저장</button>
										<button type="reset" class="btn btn-default text-bold waves-effect" id="btn-reset-form-1">입력취소</button>
									</div>
								</div>
							</div>
						</div>
					</div>



					<div class="panel panel-basic col-xs-6">
						<div class="panel-heading text-default">
							<div class="row">
								<div class="col-xs-6">
									<span class="title">이미지 리스트</span>
								</div>
								<div class="text-right col-xs-6">
									<script>
										$(function() {
											$('#btn-file-upload-1').click(function() {
												$('#file-1').click();
											})
										});
									</script>
									<button type="button" class="btn btn-primary text-bold waves-effect waves-light" id="btn-file-upload-1">이미지 추가</button>
									<input type="file" id="file-1" multiple="multiple" style="display: none;">
								</div>
							</div>
						</div>

						<div class="panel-body " style="min-height: 150px;">
							<!-- 여기에 이미지 업로드 파일 미리보기 list 하면됨. -->
							<ul class="list-group" id="file-list-group">

								<!-- <li class="list-group-item" data-index="{{@index}}">

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
													<span>파일 이름</span> : <span class="file-name text-fail text-bold"></span>
												</div>
											</div>

											<div class="row">
												<div class="file-size-box">
													<span>파일 용량</span> : <span class="file-size text-fail text-bold"></span>
												</div>
											</div>

											<div class="row" style="margin-top: 10px;">
												<div class="file-type-box">
													<span>이미지 타입</span> : <span class="help-inline text-fail">이미지 타입을 선택해주세요.</span>
													<div style="font-size: 12px; margin-top: 5px;">
														<label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="poster" class="thumnail-type-opt" data-index="{{@index}}"> 포스터
														</label> <label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="horizontal poster" class="thumnail-type-opt" data-index="{{@index}}"> 가로 포스터
														</label> <label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="still cut" class="thumnail-type-opt" data-index="{{@index}}"> 스틸컷
														</label> <label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="event" class="thumnail-type-opt" data-index="{{@index}}"> 이벤트
														</label> <label class="radio-inline"> <input type="radio" name="optradio{{@index}}" value="video" class="thumnail-type-opt" data-index="{{@index}}"> 영상
														</label>
													</div>
												</div>
											</div>

										</div>

									</div>

								</li> -->
							</ul>


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

						$(document).on('change', '.thumnail-type-opt', function() {
							var index = $(this).data('index');
							var type = $(this).val();
							gnb_fileList[index].mtype = type;
						});
					</script>

					<script id="thumnail-list-item-template" type="text/x-handlebars-template">
					{{#each.}}
							<li class="list-group-item" data-index="{{@index}}">

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


					<div class="panel panel-basic col-xs-6">
						<div class="panel-heading text-default">
							<span class="title">영화데이터 입력</span>
						</div>


						<div class="panel-body " style="padding: 45px 15px;">
							<!-- 여기에 영화 정보 입력 하면됨. -->
							<div class="row">
								<div class="form-group">
									<label for="movie_search">영화 검색</label>
									<!--  -->
									<select class="form-control" id="movie_search_by_API" name="movie_search"></select>
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>

								<div class="form-group">
									<label for="mNm">영화제목 <span class="input-tip text-muted ">&nbsp;(한글)</span></label>
									<!--  -->
									<input type="text" name="mNm" id="mNm" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>

								<div class="form-group">
									<label for="mNmEn">영화제목 <span class="input-tip text-muted ">&nbsp;(English)</span></label>
									<!--  -->
									<input type="text" name="mNmEn" id="mNmEn" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>
							</div>

							<div class="row">
								<div class="form-group col-xs-4" style="padding-left: 0;">
									<label>감독</label>
									<!--  -->
									<input type="text" name="mDirector" id="mDirector" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>

								<div class="form-group col-xs-8" style="padding-right: 0;">
									<label>배우</label>
									<!--  -->
									<input type="text" name="mActors" id="mActors" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>
							</div>

							<div class="row">
								<div class="form-group col-xs-4" style="padding-left: 0;">
									<label>개봉년도</label>
									<!--  -->
									<input type="text" name="mOpenDt" id="mOpenDt" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>

								<div class="form-group col-xs-4">
									<label>영화 시간</label>
									<!--  -->
									<input type="text" name="mShowTm" id="mShowTm" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>

								<div class="form-group col-xs-4" style="padding-right: 0;">
									<label>관람등급</label>
									<!--  -->
									<input type="text" name="mWatchGradeNm" id="mWatchGradeNm" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>
							</div>
							<div class="row">
								<div class="form-group col-xs-6" style="padding-left: 0;">
									<label>제작 국가</label>
									<!--  -->
									<input type="text" name="mNationNm" id="mNationNm" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>
								<div class="form-group col-xs-6" style="padding-right: 0;">
									<label>장르</label>
									<!--  -->
									<input type="text" name="mGenreNm" id="mGenreNm" class="form-control">
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<label>줄거리</label>
									<textarea rows="15" name="mStory" id="mStory" class="form-control" style="resize: none;" wrap="hard"></textarea>
									<p class="help-block text-fail">담당자를 입력해주세요.</p>
								</div>
							</div>
						</div>
					</div>


					<!-- </div> -->
				</div>
				<!-- end of panel-group-wrapper -->
			</form>




		</div>

	</div>
</div>


<%@ include file="../include/footer2.jsp"%>