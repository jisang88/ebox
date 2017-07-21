<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="include/header.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/audi.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/resources/js/KobisOpenAPIRestService.js"></script>


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
			var gnb_fileList = [];
			$(function() {

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

			$(document).on('click', '.btn-thumnail-cancel', function() {
				console.log('cancel 1', gnb_fileList)
				gnb_fileList.splice($(this).data('index'), 1);
				console.log('cancel 1', gnb_fileList)
				loadThumnailList(gnb_fileList);

			});
		</script>

		<script type="text/javascript">
			$(function() {

				$('#btn-submit').click(function() {
					event.preventDefault();

					var form = $('#iForm1');
					var temp = $('#file')[0].files;

					console.log(temp)

					var formData = new FormData(form[0]);

					var len = gnb_fileList.length;
					console.log(len)

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

					console.log(formData)

					$.ajax({
						url : '${pageContext.request.contextPath }/admin/movie/image/write',
						processData : false,
						contentType : false,
						data : formData,
						type : 'POST',
						success : function(result) {
							if (result === 'SUCCESS') {
								self.location = URL_IMAGE.LIST + ebox.makeQuery(pageParam) + '&mNo=' + '${movie.mNo}';
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
			var pageParam = {
				page : Number('${cri.page}'),
				perPageNum : Number('${cri.perPageNum}'),
				keyword : '${cri.keyword}'
			}

			var URL_IMAGE = {
				LIST : '${pageContext.request.contextPath }/admin/movie/image/list',
				WRITE : '${pageContext.request.contextPath }/admin/movie/image/write',
				DELETE : '${pageContext.request.contextPath }/admin/movie/image/delete'
			}

			$(function() {

				$('.btn-image-delete').click(function() {
					event.preventDefault();

					console.log($(this).data('ino'));

					$.post(URL_IMAGE.DELETE, {
						iNo : $(this).data('ino')
					}, function(data) {
						console.log(data);
						if (data == 'SUCCESS') {
							self.location = URL_IMAGE.LIST + ebox.makeQuery(pageParam) + '&mNo=' + '${movie.mNo}';
						}
					})
				});

			});
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

					<form id="iForm1" enctype="multipart/form-data" onsubmit="return false;">
						<input type="hidden" name="mNo" value="${movie.mNo }" />

						<div class="panel-body  my-panel-body">

							<div class="form-inline">
								<div class="form-group">
									<input type="file" class="form-control" id="file" name="fileList" multiple>
									<input type="file" class="form-control" id="file2" name="file" style="display: none">
								</div>
							</div>
							<div class="form-inline">
								<div class="form-group">
									<button class="btn btn-default btn-sm" type="submit" id="btn-submit">업로드</button>
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
					</div>

					<form name="iForm1" id="iForm1" method="post" onsubmit="return false;">

						<div class="panel-body ">

							<input type="hidden" name="mNo" id=mNo value="${empty movie.mNo?0:movie.mNo}">
							<input type="hidden" name="movieCd" id="movieCd" value="0">

							<div class="row">



								<ul class="list-group" id="poster-list">

									<c:forEach var="image" items="${posterList}">
										<div class="col-md-3">
											<div class="thumbnail">

												<img src="${pageContext.request.contextPath }/admin/movie/displayFile?filename=${image.iPath}" style="width: 100%">
												<div class="caption">
													<label>타입 : ${image.iType}</label>
													<button type="button" class="btn btn-primary btn-image-delete" data-ino="${image.iNo}">
														<i class="fa fa-trash-o" aria-hidden="true"></i>
													</button>
												</div>

											</div>
										</div>

									</c:forEach>
								</ul>



								<ul class="list-group" id="hposter-list">

									<c:forEach var="image" items="${hPosterList}">
										<div class="col-md-3">
											<div class="thumbnail">

												<img src="${pageContext.request.contextPath }/admin/movie/displayFile?filename=${image.iPath}" style="width: 100%">
												<div class="caption">
													<label>타입 : ${image.iType}</label>
													<button type="button" class="btn btn-primary btn-image-delete" data-iNo="${image.iNo}">
														<i class="fa fa-trash-o" aria-hidden="true"></i>
													</button>
												</div>

											</div>
										</div>

									</c:forEach>
								</ul>

								<ul class="list-group" id="stillcut-list">

									<c:forEach var="image" items="${stillCutList}">
										<div class="col-md-3">
											<div class="thumbnail">

												<img src="${pageContext.request.contextPath }/admin/movie/displayFile?filename=${image.iPath}" style="width: 100%">
												<div class="caption">
													<label>타입 : ${image.iType}</label>
													<button type="button" class="btn btn-primary btn-image-delete" data-iNo="${image.iNo}">
														<i class="fa fa-trash-o" aria-hidden="true"></i>
													</button>
												</div>

											</div>
										</div>

									</c:forEach>
								</ul>

								<ul class="list-group" id="event-list">

									<c:forEach var="image" items="${eventList}">
										<div class="col-md-3">
											<div class="thumbnail">

												<img src="${pageContext.request.contextPath }/admin/movie/displayFile?filename=${image.iPath}" style="width: 100%">
												<div class="caption">
													<label>타입 : ${image.iType}</label>
													<button type="button" class="btn btn-primary btn-image-delete" data-iNo="${image.iNo}">
														<i class="fa fa-trash-o" aria-hidden="true"></i>
													</button>
												</div>

											</div>
										</div>

									</c:forEach>
								</ul>










							</div>
							<div class="row">

								<ul class="list-group" id="hposter-list">
								</ul>
							</div>
							<div class="row">

								<ul class="list-group" id="event-list">
								</ul>
							</div>
							<div class="row">

								<ul class="list-group" id="video-list">
								</ul>
							</div>
							<div class="row">

								<ul class="list-group" id="still-cut-list">
								</ul>
							</div>
						</div>






						<div class="panel-footer"></div>
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