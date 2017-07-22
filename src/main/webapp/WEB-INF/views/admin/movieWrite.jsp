<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="include/header.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/audi.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/resources/js/KobisOpenAPIRestService.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/moment.js"></script>


<link href="${pageContext.request.contextPath }/resources/plugins/flatpickr/flatpickr.min.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/plugins/flatpickr/flatpickr.min.js"></script>


<link href="${pageContext.request.contextPath }/resources/plugins/select2/select2.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath }/resources/plugins/select2/select2.min.js"></script>



<div id="page-wrapper">

	<div class="container-fluid">


		<!-- Page Heading -->
		<div class="row">
			<div class="col-xs-12">
				<h1 class="page-header">영화</h1>

			</div>
		</div>
		<!-- /.row -->

		<script type="text/javascript">
			var gnb_fileList = [];
			var datePickr;
			$(function() {
				datePickr = $("#mOpenDt").flatpickr();

				$('#file').change(function(e) {
					console.log($('#file').val());

					var fileGroup = e.target.files;

					console.log(e)
					console.log(e.target.files)

					var len = fileGroup.length;

					for (var i = 0; i < len; i++) {
						gnb_fileList.push(fileGroup[i]);
					}
					loadThumnailList(gnb_fileList);

				});

				/* -------------------------------------------------------------------- */

			});

			function loadThumnailList(fileList) {
				var len = fileList.length;

				var list_box = $('#file-list-group');
				console.log(fileList);
				ebox.setTemplate(list_box, $('#thumnail-list-item-template'), fileList);

				//

				for (var i = 0; i < len; i++) {

					var _new_li = list_box.find('li[data-index="' + i + '"]');

					var file = fileList[i];
					var size = ebox.getFileSizeFormat(file);

					var _new_img = ebox.setImagePreview($('<img/>', {
						'class' : 'thumnail'
					}), file);

					var _thumnail_box = _new_li.find('.thumnail-box');
					_thumnail_box.empty();
					_thumnail_box.append(_new_img);

					_new_li.find('.file-size').text(size);
					_new_li.find('.file-name').text(file.name);

				}

			}

			$(document).on('click', '.btn-thumnail-upload', function() {
				console.log('upload', $(this).data('index'));

			});

			$(document).on('click', '.btn-thumnail-cancel', function() {
				console.log('cancel 1', gnb_fileList)
				gnb_fileList.splice($(this).data('index'), 1);
				console.log('cancel 1', gnb_fileList)
				loadThumnailList(gnb_fileList);

			});
			$(document).on('click', '.btn-thumnail-delete', function() {
				console.log('delete')
			});
		</script>

		<script type="text/javascript">
			var key = '22e86e647bc2882d832ab244374b4f0b';
			var Movie_Kobis_API = new KobisOpenAPIRestService(key, false);

			var host = "http://www.kobis.or.kr";
			var MOVIE_LIST_URI = "/kobisopenapi/webservice/rest/movie/searchMovieList";
			var tempId = 0;
			$(function() {

				$(".js-data-example-ajax").select2({
					placeholder : "Search for a repository",
					minimumInputLength : 2,
					/* allowClear : true, */
					ajax : {
						/* url : "${pageContext.request.contextPath }/admin/movie/search", */
						url : host + MOVIE_LIST_URI + ".json",
						dataType : 'json',
						delay : 250,
						data : function(params) {
							//console.log('data\t', params)
							return {
								key : key,
								movieNm : params.term, // search term
								curPage : params.page,

							};
						},
						async : false,
						processResults : function(data, params) {

							params.page = params.page || 1;
							console.log(data)
							//console.log('processResults\t', params)
							return {
								results : $.map(data.movieListResult.movieList, function(vo) {

									return {
										id : vo.movieCd,
										text : vo.movieNm,
										movieCd : vo.movieCd,
										company : vo.company || [],
										directors : vo.directors,
										genreAlt : vo.genreAlt,
										movieNm : vo.movieNm,
										movieNmEn : vo.movieNmEn,
										nationAlt : vo.nationAlt,
										openDt : vo.openDt,
										prdtStatNm : vo.prdtStatNm,
										prdtYear : vo.prdtYear,
										repGenreNm : vo.repGenreNm,
										repNationNm : vo.repNationNm,
										typeNm : vo.typeNm,

									}
								}),
								pagination : {
									more : (params.page * 10) < data.movieListResult.totCnt
								}
							};
						},
						cache : true
					},
					templateResult : function(item) {
						//console.log('templateResult\t', item)

						if (item.id == null || typeof item.id == 'undefined') { return null; }

						var $p = $('<p/>');
						var $span_movieNmEn = $('<span style="font-size:10px; margin-left:5px;"><span/>');
						$span_movieNmEn.text('(' + item.movieNmEn + ")");

						var $span_open = $('<span style="font-size:10px; margin-left:5px;"><span/>');

						$span_open.text(' | 개봉날짜 : ' + moment(item.openDt).format('YYYY-MM-DD'));

						var $span_dir = $('<span style="font-size:10px; margin-left:5px;"><span/>');

						var directors = '';
						item.directors.forEach(function(elt, i, array) {
							directors += elt.peopleNm + ',';
						})
						$span_dir.text(' | 감독 : ' + directors.slice(0, -1));
						//console.log('감독 : ', item.directors[0]);

						$p.text(item.movieNm);
						$p.append($span_movieNmEn);
						$p.append($span_open);
						$p.append($span_dir);

						return $p;
					},
					templateSelection : function(item) {
						if (!item.id) { return item.text; }
						//console.log('templateSelection\t', item);

						if (item.selected != true) {
							setMovieInfoToInputBox(item);
							item.selected = true;
						}

						var $span1 = $('<span/>');
						$span1.text(item.movieNm);

						var $span2 = $('<span style="font-size:10px; margin-left:5px;"><span/>');
						$span2.text('(' + item.movieNmEn + ')');

						$span1.append($span2);

						return $span1;
					}
				});
			});
			function setMovieInfoToInputBox(item) {
				console.log('왓음', item.movieCd);
				var temp = '';

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

				var param = {
					movieCd : item.movieCd
				};

				var movie_data = Movie_Kobis_API.getMovieInfo(true, param);
				console.log('MovieInfo', movie_data);

				var detail = movie_data.movieInfoResult.movieInfo;

				$('#mNm').val(item.movieNm);
				$('#mNmEn').val(item.movieNmEn);
				$('#mShowTm').val(detail.showTm);
				//$('#mOpenDt').val(detail.openDt);

				datePickr.setDate(moment(detail.openDt).format('YYYY-MM-DD'))

				temp = '';
				detail.directors.forEach(function(elt, i, array) {
					temp += elt.peopleNm + ',';
				});

				$('#mDirector').val(temp.slice(0, -1));
				$('#mWatchGradeNm').val(detail.audits[0].watchGradeNm);
				$('#mNationNm').val(item.nationAlt);
				$('#mGenreNm').val(item.genreAlt);

				var tempParam = {
					apikey : '0073bd4b3ebb3edda330222373934007',
					q : item.movieNm,
					output : 'json'
				};

				var reqAjax = $.ajax({
					url : "https://apis.daum.net/contents/movie",
					dataType : "jsonp",
					data : tempParam,
					success : function(data) {
						console.log(data);
						console.log(data.channel.item[0].story[0].content);

						$('#mStory').val(data.channel.item[0].story[0].content.trim());

						var actors = '';
						data.channel.item[0].actor.forEach(function(elt, i, array) {
							actors += elt.content + ',';
						})

						$('#mActors').val(actors.slice(0, -1));
					}
				});
			}

			$(function() {

				$('.btn-submit').click(function() {
					event.preventDefault();

					var form = $('#mForm1');
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

					$.ajax({
						url : '${pageContext.request.contextPath }/admin/movie/write',
						processData : false,
						contentType : false,
						data : formData,
						type : 'POST',
						success : function(result) {
							if (result === 'SUCCESS') {
								self.location = '${pageContext.request.contextPath }/admin/movie/write';
								alert('성공');
							} else {
								alert('실패');
							}

						}
					});

				});

			});

			$(document).on('change', '.thumnail-type-opt', function() {
				console.log('thumnail image index', $(this).data('index'))
				console.log('thumnail image type', $(this).val());

				var index = $(this).data('index');
				var type = $(this).val();
				gnb_fileList[index].mtype = type;

				//$('#mForm1 input[type="file"][data-index="' + $(this).data('index') + '"]').attr('name', $(this).val());
			});
		</script>



		<script type="text/javascript">
			
		</script>


		<div class="row">


			<!-- --------------------------------- START OF LEFT COLUM-------------------------------------------- -->
			<div class="col-xs-6">

				<div class="panel panel-default">


					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-long-arrow-right fa-fw"></i> 영화 이미지
						</h3>
					</div>

					<form id="iForm1" enctype="multipart/form-data">

						<div class="panel-body  my-panel-body">

							<div class="form-inline">
								<div class="form-group">
									<input type="file" class="form-control" id="file" name="fileList" multiple> <input type="file" class="form-control" id="file2" name="file" style="display: none">
								</div>
							</div>
							<div></div>
						</div>


						<div class="panel-footer">

							<div class="poster">
								<ul class="list-group" id="file-list-group">
								</ul>
							</div>

						</div>
					</form>


				</div>


			</div>

			<!-- --------------------------------- END OF LEFT COLUM-------------------------------------------- -->



			<div class="col-xs-6">

				<div class="panel panel-default">

					<div class="panel-heading form-inline">
						<div class="form-group">
							<h3 class="panel-title">
								<i class="fa fa-long-arrow-right fa-fw"></i> 영화 정보 입력
							</h3>
						</div>
						<div class="form-group">
							<h3 class="panel-title">
								<i class="fa fa-long-arrow-right fa-fw"></i> 영화 정보 검색 도움
							</h3>

						</div>
					</div>

					<form name="mForm1" autocomplete="off" id="mForm1" method="post" onsubmit="return false;">

						<div class="panel-body ">

							<input type="hidden" name="mNo" id=mNo value="${empty movie.mNo?0:movie.mNo}"> <input type="hidden" name="movieCd" id="movieCd" value="0">





							<!-- 							<div class="form-group">
								<label for="mNm">영화 검색</label>


								<div class="input-group">

									<div class="input-group-btn search-panel">

										<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
											<span id="search_concept" data-type="">Filter by</span> <span class="caret"></span>
										</button>

										<ul class="dropdown-menu" role="menu">
											<li><a href="javascript:void(0)" data-type="t">영화제목</a></li>
											<li><a href="javascript:void(0)" data-type="d">감독</a></li>
										</ul>

									</div>



									<input type="hidden" name="search_param" value="all" id="search_param">
									<input type="text" class="form-control" name="x" id="search-movie" placeholder="Search term...">


								</div>
							</div> -->

							<div class="form-group">
								<label for="mNm">영화 검색</label> <select class="js-data-example-ajax form-control">
								</select>
							</div>




							<div class="row">

								<div class="col-md-4">
									<div class="form-group">
										<label for="mNm">Title (kor)</label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mNm" id="mNm" class="form-control" value="${movie.mNm }">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label for="mNmEn">Title (Eng)</label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mNmEn" id="mNmEn" class="form-control" value="${movie.mNmEn }">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label>감독</label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mDirector" id="mDirector" class="form-control" value="${movie.mdirector }">
									</div>
								</div>

							</div>




							<div class="form-group">
								<label>배우</label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mActors" id="mActors" class="form-control" value="${movie.mactors }">
							</div>




							<div class="row">

								<div class="col-md-4">
									<div class="form-group">
										<label>개봉년도</label> <span class="help-txt help-inline pull-right"></span>
										<%-- 										<input type="text" name="mOpenDt" id="mOpenDt" class="form-control" value="${movie.mOpenDt }" data-date-format="Ymd"> --%>
										<input type="text" name="mOpenDt" id="mOpenDt" class="form-control" value="${movie.mOpenDt }">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label>영화 시간</label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mShowTm" id="mShowTm" class="form-control" value="${movie.mshowTm }">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label>관람등급</label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mWatchGradeNm" id="mWatchGradeNm" class="form-control" value="${movie.watchGradeNm }">
									</div>
								</div>

							</div>



							<div class="row">

								<div class="col-md-6">
									<div class="form-group">
										<label>제작 국가</label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mNationNm" id="mNationNm" class="form-control" value="${movie.mnationNm }">
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-group">
										<label>장르</label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mGenreNm" id="mGenreNm" class="form-control" value="${movie.genreNm }">
									</div>
								</div>

							</div>

							<div class="form-group">
								<label>줄거리</label> <span class="help-txt help-inline pull-right"></span>
								<textarea rows="15" name="mStory" id="mStory" class="form-control" style="width: 100%; padding: 30px;" wrap="hard">
								${movie.content }
								</textarea>
							</div>
						</div>




						<div class="panel-footer">
							<div class="text-right form-controller-btngroup">

								<div class="btngroup1-1 btngroup-Forwrite">
									<button type="submit" class="btn btn-default btn-submit-movie btn-submit">저장</button>
									<button type="reset" class="btn btn-default btn-cancel-movie">입력취소</button>
								</div>

								<div class="btngroup2-1 btngroup-Forupdate">
									<button type="submit" class="btn btn-default btn-update-complete btn-update-complete-movie ">수정완료</button>
									<button type="button" class="btn btn-primary btn-update-cancel-movie">수정취소</button>
									<button type="reset" class="btn btn-default btn-cancel-movie">입력취소</button>
								</div>


							</div>

						</div>
					</form>




				</div>

			</div>


		</div>

	</div>
	<!-- /.container-fluid -->

</div>
<!-- /#page-wrapper -->




<script>
	$(function() {

		Handlebars.registerHelper('if_eq', function(a, b, opts) {
			if (a == b) return opts.fn(this);
			else return opts.inverse(this);
		});

	})
</script>




<script id="thumnail-list-item-template" type="text/x-handlebars-template">
{{#each.}}
<li class="list-group-item" data-index="{{@index}}">

	<div class="row">

		<div class="pull-left col-xs-3">
			<div class="thumnail-box" style="text-align: left;">
				<img src="" class="thumnail" />
			</div>
		</div>

	<div class="pull-left col-xs-7" style="text-align: left;">

		<div class="row">

			<div class="file-name-box">
				<span>파일 이름</span> : <span class="file-name"></span>
			</div>

			<div class="file-size-box">
				<span>파일 용량</span> : <span class="file-size"></span>
			</div>

			<div class="file-type-box">
				<span>이미지 타입</span> :
				<label class="radio-inline">
					<input type="radio" name="optradio{{@index}}" value="poster" class="thumnail-type-opt" data-index="{{@index}}" {{#if_eq "poster" mtype}} checked {{/if_eq}}>
						포스터
				</label>
				<label class="radio-inline">
					<input type="radio" name="optradio{{@index}}" value="horizontal poster"  class="thumnail-type-opt" data-index="{{@index}}" {{#if_eq "horizontal poster" mtype}}  checked  {{/if_eq}}>
						가로 포스터
				</label>
				<label class="radio-inline">
					<input type="radio" name="optradio{{@index}}" value="still cut"  class="thumnail-type-opt" data-index="{{@index}}" {{#if_eq "still cut" mtype}}  checked  {{/if_eq}}>
						스틸컷
				</label>
				<label class="radio-inline">
					<input type="radio" name="optradio{{@index}}" value="event"  class="thumnail-type-opt" data-index="{{@index}}" {{#if_eq "event" mtype}}  checked  {{/if_eq}}>
						이벤트
				</label>
				<label class="radio-inline">
					<input type="radio" name="optradio{{@index}}" value="video"  class="thumnail-type-opt" data-index="{{@index}}" {{#if_eq "video" mtype}}  checked  {{/if_eq}}>
						영상
				</label>
			
			</div>

		</div>

	</div>

	
	<div class="pull-left col-xs-2" style="text-align: left;">
		<div>
<!--
			<button type="button" class="btn btn-info btn-xs btn-thumnail-upload" data-index="{{@index}}">
				<i class="fa fa-cloud-upload" aria-hidden="true"></i>
			</button>
-->
			<button type="button" class="btn btn-warning btn-xs btn-thumnail-cancel" data-index="{{@index}}">
				<i class="fa fa-times" aria-hidden="true"></i>
			</button>
<!--
			<button type="button" class="btn btn-danger btn-xs btn-thumnail-delete" data-index="{{@index}}" style="display: none">
				<i class="fa fa-trash-o" aria-hidden="true"></i>
			</button>
-->
		</div>
	</div>

</div>


	<div class="progress">
		<div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%">
			<span class="sr-only">70% Complete</span>
		</div>
	</div>

</li>

{{/each}}
</script>



<%@ include file="include/footer.jsp"%>