<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="include/header.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/audi.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/resources/js/KobisOpenAPIRestService.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/moment.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.mask.min.js"></script>

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
			//----------------------------------AutoComplete-----------------------------------------

			$(function() {

				$("#scrBuyDt").flatpickr();
				$("#scrSdate").flatpickr();
				$("#scrEdate").flatpickr();
				$('#scrPrice').mask("#,##0", {
					reverse : true
				});

				$(".js-data-example-ajax").select2({
					placeholder : "Search for a repository",
					minimumInputLength : 2,
					ajax : {
						url : "${pageContext.request.contextPath }/admin/movie/search",
						dataType : 'json',
						delay : 250,
						data : function(params) {
							//console.log('data\t', params)
							return {
								keyword : params.term, // search term
								page : params.page,
							};
						},
						async : false,
						processResults : function(data, params) {

							params.page = params.page || 1;
							console.log(data)
							//console.log('processResults\t', params)
							return {
								results : $.map(data.list, function(vo) {

									return {
										id : vo.mNo,
										text : vo.mNm,
										movieNm : vo.mNm,
										movieNmEn : vo.mNmEn,
										openDt : vo.mOpenDt,
										directors : vo.mDirector
									}
								}),
								pagination : {
									more : (params.page * 10) < data.total
								}
							};
						},
						cache : true
					},
					escapeMarkup : function(markup) {
						return markup;
					}, // let our custom formatter work
					templateResult : function(item) {
						//console.log('templateResult\t', item)

						if (item.id == null || typeof item.id == 'undefined') { return null; }

						var $p = $('<p/>');
						var $span_movieNmEn = $('<span style="font-size:10px; margin-left:5px;"><span/>');
						$span_movieNmEn.text('(' + item.movieNmEn + ")");

						var $span_open = $('<span style="font-size:10px; margin-left:5px;"><span/>');

						$span_open.text(' | 개봉날짜 : ' + moment(item.openDt).format('YYYY-MM-DD'));

						var $span_dir = $('<span style="font-size:10px; margin-left:5px;"><span/>');

						$span_dir.text(' | 감독 : ' + item.directors);
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

				$('.btn-submit').click(function() {
					event.preventDefault();
					if ($('#mNo').val() == 0) { return; }

					var price = $('#scrPrice').val();
					$('#scrPrice').val(price.replace(/,/gi, ""));

					$('#screenForm-1').attr('action', '${pageContext.request.contextPath }/admin/screen/write');
					$('#screenForm-1').attr('method', 'post');
					$('#screenForm-1').submit();
				});

			});

			function setMovieInfoToInputBox(item) {
				console.log('선택완료')

				console.log('id 검사\t', item.id)
				var $mNo = $('#mNo');

				$mNo.val(item.id);

			}
		</script>



		<div class="row">


			<!-- --------------------------------- START OF LEFT COLUM-------------------------------------------- -->
			<div class="col-xs-12">

				<div class="panel panel-default">


					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-long-arrow-right fa-fw"></i> 영화 이미지
						</h3>
					</div>

					<form id="screenForm-1">
						<input type="hidden" name="mNo" id="mNo" value="0" />


						<div class="panel-body  my-panel-body">

							<div class="row">
								<div class="col-xs-6 col-sm-offset-1">
									<div class="form-group ">
										<label for="mNm">영화 검색</label>
										<select class="js-data-example-ajax form-control"></select>
									</div>
									<div class="form-group ">
										<label for="scrType">스크린모드</label>
										<select name="scrType" id="scrType" class="form-control">
											<option>--</option>
											<option value="digital 2d">디지털 2D</option>
											<option value="digital 2d(subtitles)">디지털 2D(자막)</option>
											<option value="digital 3d">디지털 3D</option>
											<option value="digital 3d(subtitles)">디지털 3D(자막)</option>
											<option value="atomos 2d">ATOMOS 2D</option>
											<option value="atomos 2d(subtitles)">ATOMOS 2D(자막)</option>
											<option value="atomos 3d">ATOMOS 3D</option>
											<option value="atomos 3d(subtitles)">ATOMOS 3D(자막)</option>
										</select>
									</div>
									<div class="form-group ">
										<label for="scrBuyDt">구입 날짜</label>
										<input type="text" name="scrBuyDt" id="scrBuyDt" class="form-control" />
									</div>
									<div class="form-group ">
										<label for="scrPrice">금액</label>
										<input type="text" name="scrPrice" id="scrPrice" class="form-control" />
									</div>
									<div class="form-group ">
										<label for="scrSDate">상영 시작 날짜</label>
										<input type="text" name="scrSdate" id="scrSdate" class="form-control" />
									</div>
									<div class="form-group ">
										<label for="scrEDate">상영 중단 날짜</label>
										<input type="text" name="scrEdate" id="scrEdate" class="form-control" />
									</div>

									<input type="hidden" name="refMno" id="refMno" value="0" />
								</div>

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

		<!-- --------------------------------- END OF LEFT COLUM-------------------------------------------- -->


		<div class="row">
			<div class="col-xs-12">

				<div class="panel panel-default">

					<div class="panel-heading form-inline">
						<div class="form-group">
							<h3 class="panel-title">
								<i class="fa fa-long-arrow-right fa-fw"></i> 영화 정보 검색 도움
							</h3>
						</div>
					</div>

					<form name="mForm1" autocomplete="off" id="mForm1" method="post" onsubmit="return false;">

						<div class="panel-body "></div>
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