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
			//----------------------------------AutoComplete-----------------------------------------

			$(function() {

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

					<form id="iForm1" enctype="multipart/form-data">

						<div class="panel-body  my-panel-body"></div>


						<div class="panel-footer"></div>
					</form>


				</div>


			</div>

			<!-- --------------------------------- END OF LEFT COLUM-------------------------------------------- -->



			<div class="col-xs-6">

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