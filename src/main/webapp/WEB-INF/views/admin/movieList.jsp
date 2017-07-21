<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="include/header.jsp"%>




<link href="${pageContext.request.contextPath }/resources/css/admin/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/audi.css" rel="stylesheet">

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
			var URL_MOVIE = {
				LIST : "${pageContext.request.contextPath }/admin/movie/list"
			}
			var movie_gnb_param = {
				page : parseInt('${ pageMaker.cri.page}'),
				keyword : '${ pageMaker.cri.keyword}'
			};

			var gnb_fileList = [];
			$(function() {

				/* -------------------------------------------------------------------- */

			});
		</script>

		<script type="text/javascript">
			//----------------------------------AutoComplete-----------------------------------------
			$(function() {

				$(document).on('click', '#audi-list-pagination li a', function(event) {
					event.preventDefault();

					movie_gnb_param.page = $(this).attr('href').trim();
					movie_gnb_param.keyword = $('#txt-search-audi').val().trim();

					self.location = URL_MOVIE.LIST + ebox.makeQuery(movie_gnb_param);

				});//--------------------------------------------------------------------
			});
		</script>



		<script type="text/javascript">
			
		</script>


		<div class="row">



			<!-- --------------------------------- END OF LEFT COLUM-------------------------------------------- -->



			<div class="col-xs-12">


				<div class="panel panel-default">

					<div class="panel-heading">
						<div class="form-inline">
							<div class="input-group">
								<h3 class=" panel-title">
									<i class="fa fa-clock-o fa-fw"></i> 지점 리스트
								</h3>
							</div>

							<div class="input-group pull-right">
								<a href="${pageContext.request.contextPath }/admin/movie/write">영화 등록</a>
							</div>

						</div>
					</div>

					<div class="panel-body my-panel-body">

						<div class="row table-control-btn-box">
							<div class="col-lg-12">
								<form class="form-inline">

									<div class="btn-group table-btn-group">

										<div class="input-group btn btn-default  btn-sm btn-with-checkbox btn-with-checkbox1">
											<label style="font-weight: 400;">
												<input type="checkbox" id="btn-muti-select" class="btn-muti-select" />
												전체선택
											</label>
										</div>

										<div class="input-group btn btn-default  btn-sm btn-with-checkbox btn-with-checkbox2">
											<label style="font-weight: 400;">
												<input type="checkbox" id="btn-muti-select" class="btn-muti-select" />
											</label>
										</div>

										<button class="btn btn-danger btn-sm btn-muti-remove1" id="btn-muti-remove">선택삭제</button>
										<button class="btn btn-danger btn-sm btn-muti-remove2" id="btn-muti-remove">삭제</button>

										<button class="btn btn-default btn-sm " id="btn-listAll" type="button">전체보기</button>

										<div class="input-group">
											<input type="text" value="${pageMaker.cri.keyword }" name="keyword" class="form-control input-sm" placeholder="Search" id="txt-search-audi">
											<div class="input-group-btn">
												<button class="btn btn-default btn-sm" type="submit" id="btn-search-audi">
													<i class="glyphicon glyphicon-search"></i>
												</button>
											</div>
										</div>

									</div>
								</form>

							</div>
						</div>





						<div>
							<table class="table table-hover table-striped">
								<thead>
									<tr class="table-1-head-row">

										<th>선택</th>

										<th>영화명(kor)</th>
										<th>영화명(eng)</th>
										<th>감독</th>
										<th>배우</th>
										<th>개봉날짜</th>

										<th>상영시간</th>
										<th>관람등급</th>
										<!-- <th>국가</th> -->
										<th>장르</th>
										<!-- <th>스토리</th>-->
										<th>이미지 관리</th>
										<th></th>

									</tr>
								</thead>

								<tbody id="audi-table-body">

									<c:forEach var="movie" items="${movieList}">
										<tr class="table-1-body-row">

											<td><label>
													<input type="checkbox" name="aNo" value="${movie.mNo}" class="chk-box">
												</label></td>

											<td>${movie.mNm}</td>
											<td>${movie.mNmEn}</td>
											<td>${movie.mDirector}</td>
											<td>${movie.mActors}</td>
											<td><fmt:formatDate value="${movie.mOpenDt}" pattern="yyyy-MM-dd" /></td>
											<td>${movie.mShowTm}</td>
											<td>${movie.mWatchGradeNm}</td>
											<%-- <td>${movie.mNationNm}</td> --%>
											<td>${movie.mGenreNm}</td>
											<%-- <td><a href="${pageContext.request.contextPath }/admin/movie/image/list?page=${pageMaker.cri.page}&keyword=${pageMaker.cri.keyword}&mNo=${movie.mNo}">이미지 보기</a></td> --%>
											<td><a href="${pageContext.request.contextPath }/admin/movie/image/list${pageMaker.makeQuery(pageMaker.cri.page)}&mNo=${movie.mNo}">이미지 보기</a></td>
											<%-- <td>${movie.mStory}</td> --%>


											<td><button class="btn btn-warning btn-xs btn-table-audi-row-update">수정</button>
												<button class="btn btn-danger btn-xs btn-table-audi-row-delete">삭제</button></td>
										</tr>
									</c:forEach>
								</tbody>


							</table>
						</div>


					</div>
					<div class="panel-footer pager-box">


						<ul class="pagination pagination-sm" id="audi-list-pagination">


							<c:if test="${pageMaker.prev }">
								<li><a href="${pageMaker.startPage - 1}">
										<i class="fa fa-caret-left" aria-hidden="true"></i>
									</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="idx">
								<li class="${pageMaker.cri.page==idx?'active':'' }"><a href="${idx} ">${idx==0?"1":idx }</a></li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage>0}">
								<li><a href="${pageMaker.endPage+1 } ">
										<i class="fa fa-caret-right" aria-hidden="true"></i>
									</a></li>
							</c:if>



						</ul>


					</div>

				</div>
			</div>



		</div>

	</div>
	<!-- /.container-fluid -->

</div>
<!-- /#page-wrapper -->







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






<%@ include file="include/footer.jsp"%>