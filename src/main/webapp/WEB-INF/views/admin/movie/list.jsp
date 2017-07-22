<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../include/header2.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/movie.css" rel="stylesheet">

<link href="${pageContext.request.contextPath }/resources/plugin/select2/select2.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/plugin/select2/select2-bootstrap.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath }/resources/plugin/select2/select2.min.js"></script>


<script src="${pageContext.request.contextPath }/resources/plugin/bootbox-4.4.0/bootbox.min.js"></script>

<div id="page-wrapper">

	<!-- Page Heading -->
	<div class="row">
		<div class="col-xs-12">
			<h1 class="page-header">영화데이터</h1>
		</div>
	</div>
	<!-- /.row -->

	<script type="text/javascript">
		$(function() {
			//$('.modal-confirm-wrapper').show();

			var URL_MOVIE = {
				LIST : "${pageContext.request.contextPath }/admin/movie/list",
				WRITE : "${pageContext.request.contextPath }/admin/movie/write",
				DELETE : "${pageContext.request.contextPath }/admin/movie/delete",
				UPDATE : "${pageContext.request.contextPath }/admin/movie/update",
				READ : "${pageContext.request.contextPath }/admin/movie/read"
			}

			var CRITERIA = {
				page : parseInt('${ pageMaker.cri.page}'),
				searchType : '${ pageMaker.cri.searchType}',
				keyword : '${ pageMaker.cri.keyword}'
			};

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
				if (!confirm('정말 삭제하시겠습니까?')) return;

				var arr = [];
				var $arrChbox = $('.chk-box:checked');

				$arrChbox.each(function(i, elt) {
					arr.push($(elt).val());
				});

				if (arr.length == 0) {
					alert('선택된 항목이 없습니다.');
					return;
				}

				$.post(URL_MOVIE.DELETE, {
					mNo : arr
				}, function(data) {
					console.log(data)
					self.location = URL_MOVIE.LIST + ebox.makeQuery(CRITERIA);
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
						self.location = URL_MOVIE.LIST;
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

				var keyword = $('#input-keyword-1').val().trim().replace(/\s\s/gi, ' ');

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

				self.location = URL_MOVIE.LIST + ebox.makeQuery(CRITERIA);
			});

			/*
			----------------------------------------------------------------

				'go to movie add page'  button 
			
			--------------------------------------------------------------------
			 */

			//
			// 'add-panel-1' open button
			//
			$('#btn-open-add-panel-1').click(function() {
				event.preventDefault();
				console.log('btn-open-panel-1');
				self.location = URL_MOVIE.WRITE;
				//location.replace(URL_MOVIE.WRITE);
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

			});

			//
			//  delete buttons in row of table
			//

			$('.btn-delete-in-row').click(function() {
				event.preventDefault();
				if (!confirm('정말 삭제하시겠습니까?')) return;

				var $mNo = $('<input/>', {
					type : 'hidden',
					name : 'mNo[]',
					value : [ $(this).data('pk') ]
				});

				$('#form-1').prepend($mNo);
				$('#form-1').attr('action', URL_MOVIE.DELETE);
				$('#form-1').submit();
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
				self.location = URL_MOVIE.LIST + ebox.makeQuery(CRITERIA);
			});

		})
	</script>


	<div class="row">
		<div class="col-xs-12">

			<form action="" id="form-1" method="post" autocomplete="off">

				<!--  -->
				<input type="hidden" name="page" value="${pageMaker.cri.page}" />

				<c:if test="${!empty pageMaker.cri.keyword}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
				</c:if>


				<div class="panel-group">
					<!-- panel - 1 -->
					<div class="panel panel-basic">
						<div class="panel-body " style="position: relative;">

							<!-- ---------------------------- 버튼 체크박스 ---------------------------- -->
							<div class="btn btn-default btn-allcheck waves-effect">
								<label><input type="checkbox" id="muti-select-1" /> </label>
							</div>
							<!-- -------------------------------------- ---------------------------- -->


							<button type="button" class="btn  btn-default waves-effect" id="btn-checked-delete">선택삭제</button>
							<button type="button" class="btn  btn-default waves-effect" id="btn-all-list">전체보기</button>


							<div class="ebox-input-group" style="margin-left: 20px;">
								<select class="form-control" id="searchType-1" name="searchType">
									<option value="" ${empty pageMaker.cri.searchType?'selected':'' } style="display: none">---</option>
									<option value="mn" ${pageMaker.cri.searchType eq "mn"?'selected':'' }>영화명</option>
									<option value="dn" ${pageMaker.cri.searchType eq "dn"?'selected':'' }>감독</option>
									<option value="op" ${pageMaker.cri.searchType eq "op"?'selected':'' }>개봉날짜</option>
									<option value="g" ${pageMaker.cri.searchType eq "g"?'selected':'' }>장르</option>
								</select>
							</div>




							<div class="ebox-input-group has-icon">
								<input type="text" class="form-control input-search" placeholder="Search" id="input-keyword-1" value="${pageMaker.cri.keyword }">

								<div class="input-group-btn">
									<button class="btn btn-default btn-search waves-effect" type="button" id="btn-search-list">
										<i class="fa fa-search" aria-hidden="true"></i>
									</button>
								</div>
							</div>


							<button type="button" class="btn btn-primary text-bold pull-right waves-effect waves-light" id="btn-open-add-panel-1">
								영화데이터 추가 <i class="fa fa-plus" aria-hidden="true"></i>
							</button>

						</div>
					</div>



					<!-- panel - 2 -->
					<div class="panel panel-basic">
						<div class="panel-body " id="panel-body-have-audi-table">


							<table class="table  table-striped">
								<thead class="bg-inverse text-inverse ">
									<tr>
										<th class="thead-col-1">선택</th>
										<th class="thead-col-2">영화명</th>
										<th class="thead-col-3">감독</th>
										<th class="thead-col-4">개봉날짜</th>

										<th class="thead-col-5">관람등급</th>
										<th class="thead-col-6">장르</th>
										<th class="thead-col-7"></th>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="movie" items="${movieList}">
										<tr>

											<td class="tbody-col-1"><label><input type="checkbox" class="chk-box" name="mNo" value="${movie.mNo}"></label></td>
											<td class="tbody-col-2"><a href="#">${!empty movie.mNm? movie.mNm:'-'} <span>(${movie.mNmEn})</span></a></td>
											<td class="tbody-col-3">${!empty movie.mDirector? movie.mDirector:'-'}</td>

											<c:if test="${!empty movie.mOpenDt }">
												<td class="tbody-col-4"><fmt:formatDate value="${movie.mOpenDt}" pattern="yyyy-MM-dd" /></td>
											</c:if>
											<c:if test="${empty movie.mOpenDt }">
												<td class="tbody-col-4">-</td>
											</c:if>

											<td class="tbody-col-5">${!empty movie.mWatchGradeNm? movie.mWatchGradeNm:'-'}</td>
											<td class="tbody-col-6">${!empty movie.mGenreNm? movie.mGenreNm:'-'}</td>
											<td class="tbody-col-7">
												<button class="btn btn-warning  btn-xs waves-effect waves-light btn-update-in-row" data-pk="${movie.mNo}" ondblclick="return false;">수정</button>
												<button class="btn btn-danger  btn-xs waves-effect waves-light btn-delete-in-row" data-pk="${movie.mNo}" ondblclick="return false;">삭제</button>
											</td>
										</tr>
									</c:forEach>


								</tbody>



							</table>

						</div>

						<div class="panel-footer panel-footer-have-pagination-for-main-table">

							<ul class="pagination pagination-sm " id="pagination-1">

								<!-- pagination-sm -->
								<c:if test="${pageMaker.prev }">
									<li><a href="${pageMaker.startPage - 1}" class="waves-effect"><i class="fa fa-caret-left" aria-hidden="true"></i></a></li>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="idx">
									<li class="${pageMaker.cri.page==idx?'active':'' }"><a href="${idx}" class="waves-effect ">${idx==0?"1":idx }</a></li>
								</c:forEach>

								<c:if test="${pageMaker.next}">
									<li><a href="${pageMaker.endPage+1 }" class="waves-effect"><i class="fa fa-caret-right" aria-hidden="true"></i> </a></li>
								</c:if>

							</ul>



						</div>

					</div>


				</div>
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