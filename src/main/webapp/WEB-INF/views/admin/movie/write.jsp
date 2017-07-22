<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../include/header2.jsp"%>

<script src="${pageContext.request.contextPath }/resources/dist/handlebars-v4.0.10/handlebars-v4.0.10.js"></script>

<link href="${pageContext.request.contextPath }/resources/css/admin/movie.css" rel="stylesheet">

<link href="${pageContext.request.contextPath }/resources/plugin/select2/select2.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/plugin/select2/select2-bootstrap.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath }/resources/plugin/select2/select2.min.js"></script>



<div id="page-wrapper">

	<!-- Page Heading -->
	<div class="row">
		<div class="col-xs-12">
			<h1 class="page-header">영화 데이터</h1>
		</div>
	</div>
	<!-- /.row -->

	<script type="text/javascript">
		$(function() {
			//var str = prompt("입력")
			//alert(str.trim().replace(/\s\s/gi, ' '));

			var URL_AUDI = {
				WRITE : "${pageContext.request.contextPath }/admin/audi/write",
				LIST : "${pageContext.request.contextPath }/admin/audi/list",
				DELETE : "${pageContext.request.contextPath }/admin/audi/delete",
				UPDATE : "${pageContext.request.contextPath }/admin/audi/update",
				READ : "${pageContext.request.contextPath }/admin/audi/read"
			}

			var URL_THEATER = {
				READ : "${pageContext.request.contextPath }/admin/theater/read",
				MATCH_NAME : "${pageContext.request.contextPath }/admin/theater/match/name",
				SEARCH_LIKE_NAME : "${pageContext.request.contextPath }/admin/theater/search/name"
			}

			var CRITERIA = {
				page : parseInt('${ pageMaker.cri.page}'),
				searchType : '${ pageMaker.cri.searchType}',
				keyword : '${ pageMaker.cri.keyword}'
			};

			//--------------------------------------------------------------------
			function setHelpText() {
				//Input Text Check
				if (!ebox.setHelpTextForInput_TextForVisibility($('#tName'))) { return false; }
				if (!ebox.setHelpTextForInput_TextForVisibility($('#aName'))) { return false; }
				if (!ebox.setHelpTextForInput_TextForVisibility($('#floor'))) { return false; }

				//Input Radio Check
				if (!ebox.setHelpTextForInput_RadioForVisibility($('#aVType'))) { return false; }
				if (!ebox.setHelpTextForInput_RadioForVisibility($('#aSType'))) { return false; }

				if (!ebox.setHelpTextForInput_CheckBoxForVisibility($('#aTheme'))) { return false; }

				if (!ebox.setHelpTextForInput_RadioForVisibility($('#aThemeSubInfo'))) { return false; }

				return true;
			}

			/*
			-------------------------------------------------------------------- 
			
				table controller 
			
			--------------------------------------------------------------------
			 */

			//
			// table controller -> checkbox
			//
			$('#muti-select-1').change(function() {
				event.preventDefault();
				console.log('muti-select')

				$(this).toggleClass('press');

				if ($(this).hasClass('press')) $('input.chk-box').prop('checked', true);
				else $('input.chk-box').prop('checked', false);
			});

			//
			// table controller -> delete
			//
			$('#btn-checked-delete').click(function() {
				event.preventDefault();
				console.log('btn-checked-delete')

				var arr = [];
				var $arrChbox = $('.chk-box:checked');

				$arrChbox.each(function(i, elt) {
					arr.push($(elt).val());
				});

				if (arr.length == 0) {
					alert('선택된 항목이 없습니다.');
					return;
				}

				$.post(URL_AUDI.DELETE, {
					aNo : arr
				}, function(data) {
					console.log(data)
					self.location = URL_AUDI.LIST + ebox.makeQuery(CRITERIA);
				});// end of $.post

			});

			//
			// table controller -> btn-all-list
			//
			$('#btn-all-list').click(function() {
				event.preventDefault();
				console.log('btn-all-list')

				var display = $("#add-panel-1").css('display');

				if (display == 'none') {
					self.location = URL_AUDI.LIST;
				} else {
					setTimeout(function() {
						self.location = URL_AUDI.LIST;
					}, 300);
					$("#add-panel-1").collapse('hide');
				}

			});

			//
			// table controller -> btn-search-list
			//
			$('#btn-search-list').click(function() {
				event.preventDefault();
				console.log('search')

				var $select_search_type = $('#searchType-1');

				//시각 타입을 제외한 keyword 모두 소문자로 체인지
				var keyword = $('#input-keyword-1').val().trim().replace(/\s\s/gi, ' ');
				if ($select_search_type.val() == 'vt') {
					keyword.toUpperCase();
				} else {
					keyword.toLowerCase();
				}

				CRITERIA.keyword = keyword;
				CRITERIA.searchType = $('#searchType-1').val();

				console.log(CRITERIA)
				if (!ebox.isValid(CRITERIA.searchType)) {
					alert('검색 기준을 선택해주세요.')
					return;
				}

				if (!ebox.isValid(CRITERIA.keyword)) {
					alert('검색어를 입력해주세요.')
					return;
				}

				self.location = URL_AUDI.LIST + ebox.makeQuery(CRITERIA);
			});

			/*
			----------------------------------------------------------------

				'add-panel-1' open and close button 
			
			--------------------------------------------------------------------
			 */

			//
			// 'add-panel-1' open button
			//
			$('#btn-open-add-panel-1').click(function() {
				event.preventDefault();
				console.log('btn-open-panel-1');
				$("#add-panel-1").collapse('show');
			});

			//
			// 'add-panel-1' close button
			//

			$('#btn-close-add-panel-1').click(function() {
				event.preventDefault();
				console.log('btn-close-add-panel-1');
				$('.form-1-primary-key').val(0); // aNo 초기화
				$('#btn-submit-form-1').attr('data-update', null); // submit 버튼 update 용에서 insert용으로 초기화
				$("#add-panel-1").collapse('hide');
				$('#btn-reset-form-1').click();
			});

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

				var $aName = $('#aName');
				$aName.val($aName.val().trim().replace(/\s\s/gi, ' '));

				var $floor = $('#floor');
				$floor.val($floor.val().trim().replace(/\s\s/gi, ' '));

				if (!setHelpText()) { return; }

				var isUpdate = $(this).data('update');
				var URL;

				if (isUpdate) {
					URL = URL_AUDI.UPDATE;
				} else {
					URL = URL_AUDI.WRITE;
				}

				setTimeout(function() {
					$('#form-1').attr('action', URL);
					$('#form-1').submit();
				}, 300);

				$("#add-panel-1").collapse('hide');
			});

			//
			// form-1 reset button
			//

			$('#btn-reset-form-1').click(function() {
				console.log('btn-reset-form-1');
				$('#tName').empty(); // ${'#tNo'}는 btn-reset에 의해 자동 초기화 됨.
				$('#form-1').find('.help-block').css('visibility', 'hidden');
			});

			//
			// theater search and select 
			//
			$("#tName").select2({
				placeholder : "검색 후 선택",
				width : '100%',
				theme : "bootstrap",
				minimumInputLength : 2,
				ajax : {
					url : URL_THEATER.SEARCH_LIKE_NAME,
					dataType : 'json',
					delay : 300,
					data : function(params) {
						return {
							keyword : params.term, // search term
							page : params.page,
						};
					},
					processResults : function(data, params) {
						params.page = params.page || 1;
						return {
							results : $.map(data.list, function(vo) {
								return {
									id : vo.tNo,
									text : vo.tName,
								}
							}),
							pagination : {
								more : (params.page * 10) < data.total
							}
						};
					},
					cache : true
				}

			}).on("select2:select", function(e) {
				$('#tNo').val(e.params.data.id);
			}).on('select2:close', function(e) {
				$('#tName').focus();
			});

			/*
			----------------------------------------------------------------

				 buttons in table
			
			--------------------------------------------------------------------
			 */

			//
			//  update buttons in row of table
			//
			$('.btn-update-in-row').click(function() {
				event.preventDefault();
				console.log('btn-update-in-row');

				var $target = $(this);

				if ($target.hasClass('press')) {
					console.log('double')
					return;
				}
				$target.addClass('press');

				$.get(URL_AUDI.READ, {
					aNo : $target.data('pk')
				}, function(data) {
					console.log(data);

					$('#btn-reset-form-1').click(); //form input 비우기 

					try {
						$('#tNo').val(data.theater.tNo);
						$('#tName').append($('<option>' + data.theater.tName + '<option/>'));
					} catch (e) {
						console.log(e);
					}

					$('#aNo').val(data.aNo);
					$('#aName').val(data.aName);
					$('#aTheme').val(data.aTheme);
					$('#floor').val(data.floor);

					$('#aVType [name="aVType"][value="' + data.aVType + '"]').prop('checked', true);
					$('#aSType [name="aSType"][value="' + data.aSType + '"]').prop('checked', true);
					$('#aThemeSubInfo [name="aThemeSubInfo"][value="' + data.aThemeSubInfo + '"]').prop('checked', true);

				}).done(function() {
					$('#btn-submit-form-1').attr('data-update', true);
					$('#btn-open-add-panel-1').click();
				}).always(function() {
					$target.removeClass('press');
				});

			});

			//
			//  delete buttons in row of table
			//

			$('.btn-delete-in-row').click(function() {
				event.preventDefault();
				console.log('btn-delete-in-row');

				var $target = $(this);
				if ($target.hasClass('press')) return;
				$target.addClass('press');

				$.post(URL_AUDI.DELETE, {
					aNo : [ $(this).data('pk') ]
				}, function(data) {
					console.log('Table Item 1 Delete');
					self.location = URL_AUDI.LIST + ebox.makeQuery(CRITERIA);
				}).always(function() {
					$target.removeClass('press');
				});

			});

			/*
			----------------------------------------------------------------

				그 밖에  이벤트 처리
			
			--------------------------------------------------------------------
			 */

			//
			// search box enter key 처리
			//
			$('.input-search').keydown(function() {
				if (event.keyCode == 13) {
					$(this).parent().find('.btn-search').click();
					return;
				}
			});

			//
			//  pagination
			//
			$('#pagination-1 a').click(function() {
				event.preventDefault();
				CRITERIA.page = $(this).attr('href').trim();
				self.location = URL_AUDI.LIST + ebox.makeQuery(CRITERIA);
			});

		})
	</script>


	<div class="row" style="padding-bottom: 150px;">
		<div class="col-xs-12">

			<form action="" id="form-1" method="post" autocomplete="off">
				<div class="panel-group-wrapper">
					<div class="panel-group">


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
											<button type="button" class="btn bg-inverse text-inverse waves-effect waves-light" id="btn-submit-form-1">저장</button>
											<button type="reset" class="btn btn-default waves-effect" id="btn-reset-form-1">입력취소</button>
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
										<button type="button" class="btn bg-primary text-inverse waves-effect waves-light" id="btn-file-upload-1">이미지 추가</button>
										<input type="file" id="file-1" multiple="multiple" style="display: none" />
									</div>
								</div>
							</div>

							<div class="panel-body " style="min-height: 150px;">
								<!-- 여기에 이미지 업로드 파일 미리보기 list 하면됨. -->
								<ul class="list-group" id="file-list-group">
									<li class="list-group-item" data-index="{{@index}}">

										<div class="row">

											<div class="col-xs-2 " style="padding: 0;">
												<div class="thumnail-box">
													<img src="http://via.placeholder.com/100x100" class="thumnail" />
												</div>
											</div>


											<div class="col-xs-10">

												<div class="row text-right">
													<button type="button" class="btn btn-warning btn-xs btn-thumnail-cancel" data-index="{{@index}}">
														<i class="fa fa-times" aria-hidden="true"></i>
													</button>
												</div>

												<div class="row">
													<div class="file-name-box">
														<span>파일 이름</span> : <span class="file-name"></span>
													</div>
												</div>

												<div class="row">
													<div class="file-size-box">
														<span>파일 용량</span> : <span class="file-size"></span>
													</div>
												</div>

												<div class="row" style="margin-top: 10px;">
													<div class="file-type-box">
														<span>이미지 타입</span> :
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

									</li>
								</ul>


							</div>

						</div>
						<script>
							var gnb_fileList = [];
							$(function() {

								$('#file-1').change(function(e) {
									console.log($('#file-1').val());

									var fileGroup = e.target.files;

									console.log(e)
									console.log(e.target.files)

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
						</script>

						<script id="thumnail-list-item-template1" type="text/x-handlebars-template">


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




						<div class="panel panel-basic col-xs-6">
							<div class="panel-heading text-default">
								<span class="title">영화데이터 입력</span>
							</div>


							<div class="panel-body " style="padding: 45px 15px;">
								<!-- 여기에 영화 정보 입력 하면됨. -->
								<div class="row">
									<div class="form-group">
										<label for="mNm">영화 검색</label><select class="js-data-example-ajax form-control"></select>
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>

									<div class="form-group">
										<label for="mNm">영화제목 <span class="input-tip text-muted ">&nbsp;(한글)</span></label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mNm" id="mNm" class="form-control" value="${movie.mNm }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>

									<div class="form-group">
										<label for="mNmEn">영화제목 <span class="input-tip text-muted ">&nbsp;(English)</span></label> <span class="help-txt help-inline pull-right"></span> <input type="text" name="mNmEn" id="mNmEn" class="form-control" value="${movie.mNmEn }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>
								</div>

								<div class="row">
									<div class="form-group col-xs-4" style="padding-left: 0;">
										<label>감독</label> <input type="text" name="mDirector" id="mDirector" class="form-control" value="${movie.mdirector }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>

									<div class="form-group col-xs-8" style="padding-right: 0;">
										<label>배우</label> <input type="text" name="mActors" id="mActors" class="form-control" value="${movie.mactors }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>
								</div>

								<div class="row">
									<div class="form-group col-xs-4" style="padding-left: 0;">
										<label>개봉년도</label> <input type="text" name="mOpenDt" id="mOpenDt" class="form-control" value="${movie.mOpenDt }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>

									<div class="form-group col-xs-4">
										<label>영화 시간</label> <input type="text" name="mShowTm" id="mShowTm" class="form-control" value="${movie.mshowTm }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>

									<div class="form-group col-xs-4" style="padding-right: 0;">
										<label>관람등급</label> <input type="text" name="mWatchGradeNm" id="mWatchGradeNm" class="form-control" value="${movie.watchGradeNm }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>
								</div>
								<div class="row">
									<div class="form-group col-xs-6" style="padding-left: 0;">
										<label>제작 국가</label> <input type="text" name="mNationNm" id="mNationNm" class="form-control" value="${movie.mnationNm }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>
									<div class="form-group col-xs-6" style="padding-right: 0;">
										<label>장르</label> <input type="text" name="mGenreNm" id="mGenreNm" class="form-control" value="${movie.genreNm }">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label>줄거리</label>
										<textarea rows="15" name="mStory" id="mStory" class="form-control" style="width: 100%; padding: 30px;" wrap="hard">${movie.content }</textarea>
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>
								</div>
							</div>
						</div>


					</div>
				</div>
				<!-- end of panel-group-wrapper -->
			</form>




		</div>

	</div>
</div>

<!-- 
	bg-primary 
	bg-success 
	bg-fail 
	bg-info 
	bg-warning 
	bg-danger 
	bg-inverse
	bg-faded 
	bg-default 
	
	text-primary 
	text-success 
	text-fail 
	text-info 
	text-warning 
	text-danger 
	text-inverse 
	text-muted 
	text-default 
 -->


<%@ include file="../include/footer2.jsp"%>