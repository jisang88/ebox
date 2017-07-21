<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="include/header.jsp"%>




<link href="${pageContext.request.contextPath }/resources/css/admin/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/audi.css" rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath }/resources/plugins/src/jquery.fileuploader.css" rel="stylesheet"> --%>

<script src="${pageContext.request.contextPath }/resources/js/KobisOpenAPIRestService.js"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/KobisOpenAPIRestService.js"></script> --%>

<link href="${pageContext.request.contextPath }/resources/plugins/flatpickr/flatpickr.min.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/plugins/flatpickr/flatpickr.min.js"></script>


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
			$(function() {
				//초기화
				$('#mStory').val($('#mStory').val().trim());
				$("#mOpenDt").flatpickr();
			});

			//
			/* -------------------------------------------------------------------- */

			$(document).on('click', '.btn-thumnail-upload', function() {
				console.log('upload', $(this).data('index'));

				var $target = $('#mForm1 input[type="file"][data-index="' + $(this).data('index') + '"]');
				$target.click();

			});

			//

			$(document).on('click', '.btn-thumnail-cancel', function() {
				console.log('cancel', $(this).data('index'))

				$('#file-list-group li[data-index="' + $(this).data('index') + '"]').remove();
				$('#mForm1 input[type="file"][data-index="' + $(this).data('index') + '"]').remove();

			});

			//

			$(document).on('change', '.thumnail-type-opt', function() {
				console.log('delete', $(this).data('index'))
				console.log('delete', $(this).val());

				$('#mForm1 input[type="file"][data-index="' + $(this).data('index') + '"]').attr('name', $(this).val());
			});
		</script>


		<script type="text/javascript">
			$(function() {

				$('.btn-submit-movie').click(function() {
					event.preventDefault();

					/* $('#mForm1').attr('action', '${pageContext.request.contextPath }/admin/movie/write');
					$('#mForm1').attr('method', 'post');
					$('#mForm1').attr('enctype', 'multipart/form-data');
					 */

					console.log($('#mForm1').serialize());

					$.post("${pageContext.request.contextPath }/admin/movie/write2", $('#mForm1').serialize(), function(data) {
						console.log(data)
					})

					return;

					$('#mForm1').submit();

				});

				$('#btn-img-upload').click(function(event) {
					event.preventDefault();

					$('#iForm1').attr('action', '${pageContext.request.contextPath }/admin/movie/img/write')
					$('#iForm1').attr('method', 'post')
					//$('#iForm1').attr('enctype', 'multipart/form-data');

					return;
					$('#iForm1').submit();

				});

				//

				var file_list_index = 0;

				$('#btn-file-add').click(function() {
					console.log('add click', file_list_index)

					ebox.setItemTemplate($('#file-list-group'), $('#thumnail-list-item-template'), [ {
						index : file_list_index
					} ]);

					$('#mForm1').append($('<input/>', {
						type : 'file',
						'data-index' : file_list_index++,
						css : {
							display : "none"
						},
						change : function(e) {
							console.log(e.target.files)

							var _new_li = $('#file-list-group').find('li[data-index="' + $(this).data('index') + '"]');
							var file = e.target.files[0];
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
					}))

				});

				$('#btn-file-all-del').click(function() {
					$('#file-list-group').empty();
					$('#mForm1 input[type="file"]').remove();
				});
			});
		</script>



		<script type="text/javascript">
			
		</script>


		<div class="row">


			<!-- --------------------------------- START OF LEFT COLUM-------------------------------------------- -->
			<div class="col-xs-6">

				<div class="panel panel-default">


					<div class="panel-heading">

						<div class="form-inline">

							<h3 class="panel-title">
								<i class="fa fa-long-arrow-right fa-fw"></i> 영화 이미지
							</h3>

						</div>

					</div>

					<form id="iForm1" enctype="multipart/form-data">

						<div class="panel-body  my-panel-body">

							<div class="form-inline">

								<div class="form-group pull-right">
									<button type="button" class="btn btn-default" id="btn-file-add">+ Add</button>
									<button type="button" class="btn btn-default" id="btn-file-all-del">Delete</button>
								</div>
							</div>
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

					<form name="mForm1" autocomplete="off" id="mForm1" method="post">

						<div class="panel-body ">

							<input type="hidden" name="mNo" id=mNo value="${empty movie.mNo?0:movie.mNo}">
							<input type="hidden" name="movieCd" id="movieCd" value="0">





							<!-- 								<div class="form-group">
									<label>영화 검색</label>
									<span class="help-txt help-inline pull-right"></span>
									<label>
										<i class="fa fa-search" aria-hidden="true"></i>
									</label>
									<input type="text" class="form-control" placeholder="Search" id="search-movie">
								</div> -->

							<div class="form-group">
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

									<!-- <span class="input-group-btn">
										<button class="btn btn-default" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span> -->

								</div>
							</div>



							<div class="row">

								<div class="col-md-4">
									<div class="form-group">
										<label for="mNm">Title (kor)</label>
										<span class="help-txt help-inline pull-right"></span>
										<input type="text" name="mNm" id="mNm" class="form-control" value="${movie.mNm }">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label for="mNmEn">Title (Eng)</label>
										<span class="help-txt help-inline pull-right"></span>
										<input type="text" name="mNmEn" id="mNmEn" class="form-control" value="${movie.mNmEn }">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label>감독</label>
										<span class="help-txt help-inline pull-right"></span>
										<input type="text" name="mDirector" id="mDirector" class="form-control" value="${movie.mdirector }">
									</div>
								</div>

							</div>




							<div class="form-group">
								<label>배우</label>
								<span class="help-txt help-inline pull-right"></span>
								<input type="text" name="mActors" id="mActors" class="form-control" value="${movie.mactors }">
							</div>




							<div class="row">

								<div class="col-md-4">
									<div class="form-group">
										<label>개봉년도</label>
										<span class="help-txt help-inline pull-right"></span>
										<input type="text" name="mOpenDt" id="mOpenDt" class="form-control" value="${movie.mOpenDt }" data-date-format="Ymd">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label>영화 시간</label>
										<span class="help-txt help-inline pull-right"></span>
										<input type="text" name="mShowTm" id="mShowTm" class="form-control" value="${movie.mshowTm }">
									</div>
								</div>

								<div class="col-md-4">
									<div class="form-group">
										<label>관람등급</label>
										<span class="help-txt help-inline pull-right"></span>
										<input type="text" name="mWatchGradeNm" id="mWatchGradeNm" class="form-control" value="${movie.watchGradeNm }">
									</div>
								</div>

							</div>



							<div class="row">

								<div class="col-md-6">
									<div class="form-group">
										<label>제작 국가</label>
										<span class="help-txt help-inline pull-right"></span>
										<input type="text" name="mNationNm" id="mNationNm" class="form-control" value="${movie.mnationNm }">
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-group">
										<label>장르</label>
										<span class="help-txt help-inline pull-right"></span>
										<input type="text" name="mGenreNm" id="mGenreNm" class="form-control" value="${movie.genreNm }">
									</div>
								</div>

							</div>

							<div class="form-group">
								<label>줄거리</label>
								<span class="help-txt help-inline pull-right"></span>
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



<!-- Modal -->
<div id="modalTheater" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">영화관 정보</h4>
			</div>
			<div class="modal-body modal-audi">


				<form class="form-horizontal col-md-11 col-md-offset-1">

					<div class="form-group">
						<label class="control-label col-sm-2 modal-label">지점 이름</label>
						<div class="col-sm-10">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-tName2"></span>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2 modal-label">지번</label>
						<div class="col-sm-10">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-tAddrNum"></span>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2 modal-label">도로명</label>
						<div class="col-sm-10">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-tAddrSt"></span>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2 modal-label">담당자</label>
						<div class="col-sm-10">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-tManager"></span>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2 modal-label">전화번호</label>
						<div class="col-sm-10">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-tTel"></span>
							</span>
						</div>
					</div>



				</form>


			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>

		</div>

	</div>
</div>






<script>
	$(function() {
		Handlebars.registerHelper('toLowerCase', function(value) {
			return (value && typeof value === 'string') ? value.toLowerCase() : '';
		});

		Handlebars.registerHelper('toUpperCase', function(value) {
			return (value && typeof value === 'string') ? value.toUpperCase() : '';
		});
		Handlebars.registerHelper('changeComma', function(value) {
			return value.replace(',', ' | ');
		});

	})

	function modalAudi(target) {

		var aNo = $(target).parent().parent().find('[name="aNo"]').val();
		console.log('log', aNo)

		if (ebox.isValid(aNo)) {
			console.log('aNo isValid')
		}

		//

		$.get(URL_AUDI.READ, {

			aNo : aNo

		}, function(data) {
			console.log(data)

			$('#modal-tName').text(data.theater.tName);
			$('#modal-aName').text(data.aName);
			$('#modal-aSType').text(data.aSType.toUpperCase().replace(",", " | "));
			$('#modal-aVType').text(data.aVType.toUpperCase().replace(",", " | "));
			$('#modal-aTheme').text(data.aTheme.toUpperCase());
			$('#modal-aThemeSubInfo').text(data.aThemeSubInfo.toUpperCase());
			$('#modal-floor').text(data.floor);
		})

	}

	function modalTheater(target) {
		console.log('modalTheater', $(target).data('tno'))

		var tNo = $(target).data('tno');
		if (ebox.isValid(tNo)) {
			console.log('tNo isValid')
		}

		$.get(URL_THEATER.READ, {

			tNo : tNo

		}, function(data) {
			console.log(data)

			$('#modal-tName2').text(data.tName);
			$('#modal-tAddrNum').text(data.tAddrNum);
			$('#modal-tAddrSt').text(data.tAddrSt);
			$('#modal-tManager').text(data.tManager);
			$('#modal-tTel').text(data.tTel);

		})

	}
</script>




<script type="text/javascript">
	//----------------------------------AutoComplete-----------------------------------------

	/* var tempParam = {
					apikey : '0073bd4b3ebb3edda330222373934007',
					q : '친구',
					output : 'json'
				};

				var reqAjax = $.ajax({
					url : "https://apis.daum.net/contents/movie",
					dataType : "jsonp",
					data : tempParam,
					success : function(data) {
						// d.key;
						console.log(data);
						console.log(data.channel.item[0].story[0].content);
					}
				}); */
	var key = '22e86e647bc2882d832ab244374b4f0b';
	var Movie_Kobis_API = new KobisOpenAPIRestService(key, false);
	$(function() {

		//$('#mStory').val(temp);

		//테스트용
		//var key = '430156241533f1d058c603178cc3ca0e';

		/* ---------------------------------------------------------------------------------- */

		//  
		// 	autocomplete 매개변수들 
		/* ---------------------------------------------------------------------------------- */

		// autocomplete 메뉴 아이템 선택시 선택된 아이템의 재 입력으로 메뉴 reopen 됨
		// so, 이러한 반응을 방지하려면 임시 변수 하나 생성해서 source 함수에서 값 비교하여 reopen 방지함.
		var autocomplete_temp;

		// autocomplete source의 일부로서 ajax와 처리와 return 객체의 속성 이름이 달라 
		// 외부에서 생성하여 함수로 전달하여 범용으로 쓸려고 함.

		var autocomplete_ajax = function(req, res) {
			var param;

			var type = $('.search-panel span#search_concept').data('type');
			var term = req.term.trim();

			if (type == '' || typeof type == 'undefined' || type == null) {
				alert('필터를 선택해주세요.');

				return;
			} else if (type == 't') {
				param = {
					movieNm : term
				};

			} else if (type == 'd') {
				param = {
					directorNm : term
				};
			}

			var data = Movie_Kobis_API.getMovieList(true, param);
			var dataList = data.movieListResult.movieList;

			console.log('data', dataList);

			res($.map(dataList, function(item) {
				return {
					label : item.movieNm,
					value : req.term.trim(),
					info : item
				};
			}))// res 

		};

		setAutoComplete($('#search-movie'), autocomplete_temp, autocomplete_ajax);

		/* ---------------------------------------------------------------------------------- */

		$('.search-panel .dropdown-menu').find('a').click(function(e) {
			e.preventDefault();
			//var param = $(this).attr("href").replace("#", "");
			var concept = $(this).text();
			var type = $(this).data('type');
			$('.search-panel span#search_concept').text(concept);
			$('.search-panel span#search_concept').data('type', type);

			//$('.input-group #search_param').val(param);
		});

	});

	function setAutoComplete($target, tempVal, ajaxFunc) {

		$target.autocomplete({
			minLength : 2,
			delay : 500,
			autoFocus : true,

			focus : function(event, ui) {
				return false;
			},

			select : function(event, ui) {
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

				console.log(ui.item)
				tempVal = ui.item.value;
				var info = ui.item.info;
				var temp = '';
				//검색 변수 담기 
				var param = {
					movieCd : info.movieCd
				};

				var data = Movie_Kobis_API.getMovieInfo(true, param);
				//console.log('MovieInfo', ui.item.info);
				console.log('MovieInfo', data);

				var detail = data.movieInfoResult.movieInfo;

				$('#mNm').val(info.movieNm);
				$('#mNmEn').val(info.movieNmEn);
				$('#mShowTm').val(detail.showTm);
				$('#mOpenDt').val(detail.openDt);

				temp = '';
				detail.directors.forEach(function(elt, i, array) {
					temp += elt.peopleNm + ',';
				});

				$('#mDirector').val(temp.slice(0, -1));
				$('#mWatchGradeNm').val(detail.audits[0].watchGradeNm);
				$('#mNationNm').val(info.nationAlt);
				$('#mGenreNm').val(info.genreAlt);

				var tempParam = {
					apikey : '0073bd4b3ebb3edda330222373934007',
					q : info.movieNm,
					output : 'json'
				};

				var reqAjax = $.ajax({
					url : "https://apis.daum.net/contents/movie",
					dataType : "jsonp",
					data : tempParam,
					success : function(data) {
						// d.key;
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

			},

			source : function(req, res) {
				if (tempVal == req.term) {
					tempVal = '';
					return;
				}

				ajaxFunc(req, res);
			},// source

		});
	}
</script>


<script id="audi-list-template" type="text/x-handlebars-template">
{{#each.}}
<tr class="table-1-body-row">

	<td><label><input type="checkbox" name="aNo" value="{{aNo }}" class="chk-box"></label></td>
	<td><a data-toggle="modal" data-target="#modalTheater" onclick="modalTheater(this)" data-tNo="{{theater.tNo}}">{{theater.tName}}</a></td>
	<td><a data-toggle="modal" data-target="#modalAudi" onclick="modalAudi(this)">{{aName}}</a></td>
	<td>{{changeComma (toUpperCase aVType)}}</td>
	<td>{{changeComma (toUpperCase aSType)}}</td>
	<td>{{toUpperCase aTheme}}{{#if aThemeSubInfo}} - {{toUpperCase aThemeSubInfo}} {{/if}}</td>
	<td>300석</td>
	<td>{{floor}}</td>

	<td><button class="btn btn-warning btn-xs btn-table-audi-row-update">수정</button>
		<button class="btn btn-danger btn-xs btn-table-audi-row-delete">삭제</button></td>
</tr>
{{/each}}
</script>

<script id="thumnail-list-item-template" type="text/x-handlebars-template">
{{#each.}}
<li class="list-group-item" data-index="{{index}}">

									<div class="row">

										<div class="pull-left col-xs-3">
											<div class="thumnail-box" style="text-align: left;">
												<img src="${pageContext.request.contextPath }/resources/img/60x60.png" class="thumnail" />
											</div>
										</div>

										<div class="pull-left col-xs-7" style="text-align: left;">

											<div class="row">

												<div class="file-name-box">
													<span>파일 이름</span> : <span class="file-name">sample_img_60x60.jpg</span>
												</div>

												<div class="file-size-box">
													<span>파일 용량</span> : <span class="file-size"></span>
												</div>

												<div class="file-type-box">
													<span>이미지 타입</span> :
													<label class="radio-inline">
														<input type="radio" name="optradio{{index}}" value="poster" class="thumnail-type-opt" data-index="{{index}}">
														포스터
													</label>
													<label class="radio-inline">
														<input type="radio" name="optradio{{index}}" value="photo"  class="thumnail-type-opt" data-index="{{index}}">
														영화 캡처
													</label>
													<label class="radio-inline">
														<input type="radio" name="optradio{{index}}" value="video"  class="thumnail-type-opt" data-index="{{index}}">
														영상
													</label>
												</div>



											</div>

										</div>

										<div class="pull-left col-xs-2" style="text-align: left;">
											<div>

												<button type="button" class="btn btn-info btn-xs btn-thumnail-upload" data-index="{{index}}">
													<i class="fa fa-folder-open" aria-hidden="true"></i>
												</button>

												<button type="button" class="btn btn-warning btn-xs btn-thumnail-cancel" data-index="{{index}}">
													<i class="fa fa-times" aria-hidden="true"></i>
												</button>


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