<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="include/header2.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/theater.css" rel="stylesheet">
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
<div id="page-wrapper">

	<!-- Page Heading -->
	<div class="row">
		<div class="col-xs-12">
			<h1 class="page-header">시설물</h1>
		</div>
	</div>
	<!-- /.row -->

	<script type="text/javascript">
		$(function() {

			//전역 변수
			var URL_THEATER = {

				WRITE : "${pageContext.request.contextPath }/admin/theater/write",
				LIST : "${pageContext.request.contextPath }/admin/theater/list",
				DELETE : "${pageContext.request.contextPath }/admin/theater/delete",
				UPDATE : "${pageContext.request.contextPath }/admin/theater/update",
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
				if (!ebox.setHelpTextForInput_TextForVisibility($('#tManager'))) { return false; }
				if (!ebox.setHelpTextForInput_TextForVisibility($('#tTel'))) { return false; }
				if (!ebox.setHelpTextForInput_TextForVisibility($('#tAddrNum'))) { return false; }
				if (!ebox.setHelpTextForInput_TextForVisibility($('#tAddrSt'))) { return false; }

				return true;

			}//--------------------------------------------------------------------

			$('#muti-select-1').change(function() {
				event.preventDefault();
				console.log('muti-select')

				$(this).toggleClass('press');

				if ($(this).hasClass('press')) $('input.chk-box').prop('checked', true);
				else $('input.chk-box').prop('checked', false);

			});

			/* 
			 */

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

				$.post(URL_THEATER.DELETE, {
					tNo : arr
				}, function(data) {
					console.log(data)
					self.location = URL_THEATER.LIST + ebox.makeQuery(CRITERIA);
				});// end of $.post

			});

			/* 
			 */

			$('#btn-all-list').click(function() {
				event.preventDefault();
				console.log('btn-all-list')

				var display = $("#add-panel-1").css('display');

				if (display == 'none') {
					self.location = URL_THEATER.LIST;
				} else {
					setTimeout(function() {
						self.location = URL_THEATER.LIST;
					}, 300);
					$("#add-panel-1").collapse('hide');
				}

			});

			/* 
			 */

			$('#btn-search-list').click(function() {
				event.preventDefault();
				console.log('search')

				CRITERIA.keyword = $('#input-keyword-1').val();
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

				self.location = URL_THEATER.LIST + ebox.makeQuery(CRITERIA);
			});

			/* 
			 */

			//----------------------------------------------------------------
			$('#btn-open-add-panel-1').click(function() {
				event.preventDefault();
				console.log('btn-open-panel-1');
				$("#add-panel-1").collapse('show');
			});

			$('#btn-close-add-panel-1').click(function() {
				event.preventDefault();
				console.log('btn-close-add-panel-1');
				$('.form-1-primary-key').val(0);
				$('#btn-submit-form-1').attr('data-update', null);
				$("#add-panel-1").collapse('hide');
				$('#btn-reset-form-1').click();
			});

			//----------------------------------------------------------------
			$('#btn-submit-form-1').click(function() {
				event.preventDefault();
				console.log('btn-submit-form-1');

				if (!setHelpText()) { return; }

				var isUpdate = $(this).data('update');
				var URL;

				if (isUpdate) {
					URL = URL_THEATER.UPDATE;
				} else {
					URL = URL_THEATER.WRITE;
				}

				setTimeout(function() {
					$('#form-1').attr('action', URL);
					$('#form-1').submit();
				}, 300);

				$("#add-panel-1").collapse('hide');
			});

			$('#btn-reset-form-1').click(function() {
				console.log('btn-reset-form-1');
				$('#form-1').find('.help-block').css('visibility', 'hidden');
			});

			//----------------------------------------------------------------

			$('.btn-update-in-row').click(function() {
				event.preventDefault();
				console.log('btn-update-in-row');

				var $target = $(this);

				if ($target.hasClass('press')) {
					console.log('double')
					return;
				}
				$target.addClass('press');

				$.get(URL_THEATER.READ, {
					tNo : $target.data('pk')
				}, function(data) {
					console.log(data);

					$('#tNo').val(data.tNo);
					$('#tName').val(data.tName);
					$('#tManager').val(data.tManager);
					$('#tTel').val(data.tTel);
					$('#tAddrNum').val(data.tAddrNum);
					$('#tAddrSt').val(data.tAddrSt);

				}).done(function() {
					$('#btn-submit-form-1').attr('data-update', true);
					$('#btn-open-add-panel-1').click();
				}).always(function() {
					$target.removeClass('press');
				});

			});

			$('.btn-delete-in-row').click(function() {
				event.preventDefault();
				console.log('btn-delete-in-row');

				var $target = $(this);

				if ($target.hasClass('press')) {
					console.log('double')
					return;
				}

				$target.addClass('press');

				$.post(URL_THEATER.DELETE, {
					tNo : [ $(this).data('pk') ]
				}, function(data) {
					console.log('Table Item 1 Delete');
					self.location = URL_THEATER.LIST + ebox.makeQuery(CRITERIA);
				}).always(function() {
					$target.removeClass('press');
				});

			});

			//----------------------------------------------------------------
			// search box enter key 처리
			$('.input-search').keydown(function() {
				if (event.keyCode == 13) {
					$(this).parent().find('.btn-search').click();
					return;
				}
			});

			$('#pagination-1 a').click(function() {
				event.preventDefault();
				CRITERIA.page = $(this).attr('href').trim();
				self.location = URL_THEATER.LIST + ebox.makeQuery(CRITERIA);
			});

		})
		/* 	<i class="fa fa-check-square-o" aria-hidden="true"></i> */
	</script>



	<div class="row">
		<div class="col-xs-12">



			<form action="" id="form-1" method="post" autocomplete="off">
				<div id="add-panel-1" class="collapse">
					<div class="panel panel-basic">

						<div class="panel-heading text-default">
							<!-- <i class="fa fa-chevron-down" aria-hidden="true"></i> -->
							<!-- <i class="fa fa-plus-square-o fa-lg  " aria-hidden="true"></i> -->
							<!-- -->
							<span class="title">지점 등록</span>
							<!-- -->
							<i class="fa fa-plus" aria-hidden="true"></i>
							<button class="btn bg-primary text-inverse pull-right waves-effect waves-light" id="btn-close-add-panel-1">
								닫기 <i class="fa fa-times" aria-hidden="true"></i>
							</button>
						</div>


						<div class="panel-body ">

							<div class="form-group-wrapper">

								<div class="row">
									<div class="text-right col-xs-12">
										<div class="form-btn-group">

											<button type="button" class="btn bg-inverse text-inverse waves-effect waves-light" id="btn-submit-form-1">저장</button>
											<button type="reset" class="btn btn-default waves-effect" id="btn-reset-form-1">입력취소</button>
										</div>
									</div>
								</div>

								<!-- input tNo -->
								<input type="hidden" name="tNo" id="tNo" class="form-1-primary-key" value="0" />
								<!--  -->
								<input type="hidden" name="page" value="${pageMaker.cri.page}" />

								<c:if test="${!empty pageMaker.cri.keyword}">
									<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}" />
								</c:if>
								<c:if test="${!empty pageMaker.cri.searchType}">
									<input type="hidden" name="searchType" value="${pageMaker.cri.searchType}" />
								</c:if>




								<div class="row">
									<div class="form-group col-xs-4">
										<label>지점명</label> <input type="text" name="tName" id="tName" class="form-control" placeholder="Enter Text">
										<p class="help-block text-fail">지점명을 입력해주세요.</p>
									</div>
									<div class="form-group col-xs-4">
										<label>담당자</label> <input type="text" name="tManager" id="tManager" class="form-control" placeholder="Enter Text">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>
									<div class="form-group col-xs-4">
										<label>전화번호</label> <input type="text" name="tTel" id="tTel" class="form-control" placeholder="Enter Text">
										<p class="help-block text-fail">전화번호를 입력해주세요.</p>
									</div>
								</div>
								<div class="row">
									<div class="form-group col-xs-6">
										<label>주소-지번</label> <input type="text" name="tAddrNum" id="tAddrNum" class="form-control" placeholder="Enter Text">
										<p class="help-block text-fail">주소-지번을 입력해주세요.</p>
									</div>
									<div class="form-group col-xs-6">
										<label>주소-도로명</label> <input type="text" name="tAddrSt" id="tAddrSt" class="form-control" placeholder="Enter Text">
										<p class="help-block text-fail">주소-도로명을 입력해주세요.</p>
									</div>
								</div>


							</div>

						</div>


						<div class="panel-footer"></div>

					</div>
				</div>
			</form>



			<form action="" id="form-2" method="post" autocomplete="off">

				<div class="panel-group">
					<!-- panel - 1 -->
					<div class="panel panel-basic">
						<div class="panel-body " style="position: relative;">

							<!-- ---------------------------- 버튼 체크박스 ---------------------------- -->
							<div class="btn btn-default btn-allcheck waves-effect">
								<label> <input type="checkbox" id="muti-select-1" />
								</label>
							</div>
							<!-- -------------------------------------- ---------------------------- -->


							<button type="button" class="btn  btn-default waves-effect" id="btn-checked-delete">선택삭제</button>
							<button type="button" class="btn  btn-default waves-effect" id="btn-all-list">전체보기</button>


							<div class="ebox-input-group" style="margin-left: 20px;">
								<select class="form-control" id="searchType-1">
									<option value="" ${empty pageMaker.cri.searchType?'selected':'' } style="display: none">---</option>
									<option value="n" ${pageMaker.cri.searchType eq "n"?'selected':'' }>지점명</option>
									<option value="a" ${pageMaker.cri.searchType eq "a"?'selected':'' }>주소</option>
									<option value="m" ${pageMaker.cri.searchType eq "m"?'selected':'' }>담당자</option>
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


							<button type="button" class="btn bg-primary text-inverse pull-right waves-effect waves-light" id="btn-open-add-panel-1">
								지점 추가 <i class="fa fa-plus" aria-hidden="true"></i>
							</button>

						</div>
					</div>



					<!-- panel - 2 -->
					<div class="panel panel-basic">
						<div class="panel-body" id="panel-body-have-theater-table">


							<table class="table  table-striped">
								<thead class="bg-inverse text-inverse ">
									<tr>
										<th class="thead-col-1">선택</th>
										<th class="thead-col-2">지점명</th>
										<th class="thead-col-3">담당자</th>
										<th class="thead-col-4">전화번호</th>
										<th class="thead-col-5">지역</th>
										<th class="thead-col-6">상영관 개수</th>
										<th class="thead-col-7">매출 순위</th>
										<th class="thead-col-8"></th>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="theater" items="${theaterList}">
										<tr>
											<td class="tbody-col-1"><label> <input type="checkbox" class="chk-box" name="tNo" value="${theater.tNo}">
											</label></td>

											<td class="tbody-col-2"><a href="#">${!empty theater.tName?theater.tName:'-'}</a></td>
											<td class="tbody-col-3">${!empty theater.tManager?theater.tManager:'-'}</td>
											<td class="tbody-col-4">${!empty theater.tTel?theater.tTel:'-'}</td>


											<!-- <td class="tbody-col-5">서울특별시 송파구</td> -->
											<c:if test="${!empty theater.tAddrNum}">
												<c:set var="addr" value="${fn:split(theater.tAddrNum,' ')}"></c:set>
												<td class="tbody-col-5">${addr[0]}&nbsp;&nbsp;${addr[1]}</td>
											</c:if>

											<c:if test="${empty theater.tAddrNum}">
												<td class="tbody-col-5">-</td>
											</c:if>


											<td class="tbody-col-6"><a href="#"> 8개</a></td>
											<td class="tbody-col-7"><a href="#"> 2위</a></td>

											<td class="tbody-col-8">
												<button class="btn bg-danger text-inverse btn-xs btn-update-in-row" data-pk="${theater.tNo}">수정</button>
												<button class="btn bg-fail text-inverse btn-xs btn-delete-in-row" data-pk="${theater.tNo}" ondblclick="return false;">삭제</button>
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
									<li><a href="${pageMaker.startPage - 1}" class="waves-effect"><i class="fa fa-caret-left" aria-hidden="true"></i> </a></li>
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




<%@ include file="include/footer2.jsp"%>