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

		$(function() {

			datePickr = $("#mOpenDt").flatpickr();
			var URL_MOVIE = {
				UPDATE : "${pageContext.request.contextPath }/admin/movie/update",
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
				$('#form-1 .help-inline').css('visibility', 'hidden');
				if (!setHelpText()) return;

				$('#form-1').attr('method', "post");
				$('#form-1').attr('action', URL_MOVIE.UPDATE);
				$('#form-1').submit();
			});

			//
			// form-1 reset button
			//
			$('#btn-reset-form-1').click(function() {
				console.log('btn-reset-form-1');
				$('#movie_search_by_API').empty(); // ${'#tNo'}는 btn-reset에 의해 자동 초기화 됨.
				hideHelpText();
				formInputReset();
			});

		});

		function hideHelpText() {
			$('#form-1').find('.help-block').css('visibility', 'hidden');
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
							console.log(e);
						}
					}
				});

			});

		});
	</script>


	<div class="row" id="panel-wrapper-1">
		<div class="col-xs-12">

			<form action="" id="form-1" method="post" autocomplete="off">
				<div class="panel-group-wrapper">

					<!-- <div class="panel-group"> -->


					<div class="panel panel-basic">
						<div class="panel-body ">
							<div class="row">
								<div class="col-xs-5">
									<h2>
										<span class="title">영화 수정</span>&nbsp;<i class="fa fa-plus" aria-hidden="true"></i>
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

							<div class="row" id="update-page-box-1">


								<div class="col-xs-3"></div>
								<div class="col-xs-6">

									<div class="row">

										<input type="hidden" name="mNo" value="${movie.mNo }">


										<div class="form-group">
											<label for="movie_search">영화 검색</label>
											<!--  -->
											<select class="form-control" id="movie_search_by_API" name="movie_search"></select>
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>

										<div class="form-group">
											<label for="mNm">영화제목 <span class="input-tip text-muted ">&nbsp;(한글)</span></label><span class="help-txt help-inline pull-right"></span>
											<!--  -->
											<input type="text" name="mNm" id="mNm" class="form-control" value="${movie.mNm }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>

										<div class="form-group">
											<label for="mNmEn">영화제목 <span class="input-tip text-muted ">&nbsp;(English)</span></label><span class="help-txt help-inline pull-right"></span>
											<!--  -->
											<input type="text" name="mNmEn" id="mNmEn" class="form-control" value="${movie.mNmEn }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>
									</div>

									<div class="row">
										<div class="form-group col-xs-4" style="padding-left: 0;">
											<label>감독</label>
											<!--  -->
											<input type="text" name="mDirector" id="mDirector" class="form-control" value="${movie.mDirector }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>

										<div class="form-group col-xs-8" style="padding-right: 0;">
											<label>배우</label>
											<!--  -->
											<input type="text" name="mActors" id="mActors" class="form-control" value="${movie.mActors }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>
									</div>

									<div class="row">
										<div class="form-group col-xs-4" style="padding-left: 0;">
											<label>개봉년도</label>
											<!--  -->
											<input type="text" name="mOpenDt" id="mOpenDt" class="form-control" value="${movie.mOpenDt }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>

										<div class="form-group col-xs-4">
											<label>영화 시간</label>
											<!--  -->
											<input type="text" name="mShowTm" id="mShowTm" class="form-control" value="${movie.mShowTm }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>

										<div class="form-group col-xs-4" style="padding-right: 0;">
											<label>관람등급</label>
											<!--  -->
											<input type="text" name="mWatchGradeNm" id="mWatchGradeNm" class="form-control" value="${movie.mWatchGradeNm }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>
									</div>
									<div class="row">
										<div class="form-group col-xs-6" style="padding-left: 0;">
											<label>제작 국가</label>
											<!--  -->
											<input type="text" name="mNationNm" id="mNationNm" class="form-control" value="${movie.mNationNm }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>
										<div class="form-group col-xs-6" style="padding-right: 0;">
											<label>장르</label>
											<!--  -->
											<input type="text" name="mGenreNm" id="mGenreNm" class="form-control" value="${movie.mGenreNm }">
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>
									</div>
									<div class="row">
										<div class="form-group">
											<label>줄거리</label>
											<textarea rows="15" name="mStory" id="mStory" class="form-control" style="resize: none;" wrap="hard">${movie.mStory }</textarea>
											<p class="help-block text-fail">담당자를 입력해주세요.</p>
										</div>
									</div>
								</div>
								<div class="col-xs-3"></div>

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