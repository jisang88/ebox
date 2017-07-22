<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="include/header2.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/audi.css" rel="stylesheet">

<link href="${pageContext.request.contextPath }/resources/plugin/select2/select2.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/plugin/select2/select2-bootstrap.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath }/resources/plugin/select2/select2.min.js"></script>

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


	<div class="row">
		<div class="col-xs-12">

			<form action="" id="form-1" method="post" autocomplete="off">
				<div id="add-panel-1" class="collapse">

					<div class="panel panel-basic">

						<div class="panel-heading text-default">
							<span class="title">지점 등록</span>
							<!-- -->
							<i class="fa fa-plus" aria-hidden="true"></i>
							<button class="btn btn-primary text-bold pull-right waves-effect waves-light" id="btn-close-add-panel-1">
								닫기 <i class="fa fa-times" aria-hidden="true"></i>
							</button>
						</div>


						<div class="panel-body ">

							<div class="form-group-wrapper">

								<div class="row">
									<div class="text-right col-xs-12">
										<div class="form-btn-group">
											<button type="button" class="btn  btn-inverse text-bold waves-effect waves-light" id="btn-submit-form-1">저장</button>
											<button type="reset" class="btn btn-default text-bold waves-effect" id="btn-reset-form-1">입력취소</button>
										</div>
									</div>
								</div>

								<!-- input aNo -->
								<input type="hidden" name="aNo" id="aNo" class="form-1-primary-key" value="0">
								<!-- input tNo -->
								<input type="text" name="tNo" id="tNo" class="form-1-foreign-key" value="0" style="display: none">
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
										<label class="">지점 이름</label>
										<!--  -->
										<select name="tName" id="tName" class="form-control"></select>
										<p class="help-block text-fail">지점명을 입력해주세요.</p>
									</div>

									<div class="form-group col-xs-4">
										<label>상영관 이름 <span class="input-tip text-muted ">EX)&nbsp;&nbsp;1 (O)&nbsp;&nbsp;1관 (X)</span></label> <input type="text" name="aName" id="aName" class="form-control" placeholder="Enter Text">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>

									<div class="form-group  col-xs-4">
										<label>위치 <span class="input-tip text-muted ">EX)&nbsp;&nbsp;B1 (O)&nbsp;&nbsp;B1층 (X)</span></label> <input type="text" name="floor" id="floor" class="form-control" placeholder="Enter Text">
										<p class="help-block text-fail">담당자를 입력해주세요.</p>
									</div>

								</div>




								<div class="row">

									<!-- <div class="form-group col-xs-1"></div> -->

									<div class="form-group col-xs-3">
										<label> 시각 타입 </label>
										<!-- aVType -->
										<div class="col-sm-offset-1" id="aVType">

											<div class="radio">
												<label><input type="radio" name="aVType" id="aVType-2D" value="2D"> 2D <span class="add-tip  ">(Only)</span> </label>
											</div>

											<div class="radio">
												<label><input type="radio" name="aVType" id="aVType-3D" value="3D"> 3D <span class="add-tip  ">(Only)</span> </label>
											</div>

											<div class="radio">
												<label><input type="radio" name="aVType" id="aVType-2DAnd3D" value="2D, 3D"> 2D & 3D </label>
											</div>

										</div>
										<!-- End of aVType -->
										<p class="help-block text-fail">전화번호를 입력해주세요.</p>
									</div>


									<div class="form-group col-xs-3">
										<label> 사운드 타입 </label>
										<!-- aSType -->
										<div class="col-sm-offset-1" id="aSType">

											<div class="radio">
												<label><input type="radio" name="aSType" id="aSType-normal" value="normal"> Normal <span class="add-tip  ">(Only)</span> </label>
											</div>

											<div class="radio">
												<label><input type="radio" name="aSType" id="aSType-atmos" value="atmos"> ATMOS <span class="add-tip ">(Only)</span> </label>
											</div>

											<div class="radio">
												<label><input type="radio" name="aSType" id="aSType-normalAndAtmos" value="normal, atmos"> Normal & ATMOS </label>
											</div>

										</div>
										<!-- End of aSType -->
										<p class="help-block text-fail">주소-지번을 입력해주세요.</p>
									</div>


									<div class="form-group col-xs-3">
										<label>테마</label>
										<!-- -->
										<select class="form-control" name="aTheme" id="aTheme" multiple size="4" onchange="ebox.setMutiSelectLimit(this)">
											<option value="normal">Normal</option>
											<option value="table">Table</option>
											<option value="comfort">Comfort</option>
											<option value="the boutique">The Boutique</option>
											<option value="kids box">Kids Box</option>
											<option value="barcony m">Barcony M</option>
										</select>
										<p class="help-block text-fail">주소-도로명을 입력해주세요.</p>
									</div>


									<div class="form-group col-xs-3">
										<label>테마부가정보</label>

										<div class="col-sm-offset-1" id="aThemeSubInfo">
											<div class="radio">
												<label><input type="radio" name="aThemeSubInfo" value=""> 없음 </label>
											</div>

											<div class="radio">
												<label><input type="radio" name="aThemeSubInfo" value="suite"> Suite (The Boutique) </label>
											</div>

											<div class="radio">
												<label><input type="radio" name="aThemeSubInfo" value="deluxe"> Deluxe (Barcony M)</label>
											</div>
										</div>
										<p class="help-block text-fail">주소-지번을 입력해주세요.</p>

									</div>


								</div>
								<!-- end of row -->

							</div>
							<!-- end of form-group-wrapper -->

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
								<label><input type="checkbox" id="muti-select-1" /> </label>
							</div>
							<!-- -------------------------------------- ---------------------------- -->


							<button type="button" class="btn  btn-default waves-effect" id="btn-checked-delete">선택삭제</button>
							<button type="button" class="btn  btn-default waves-effect" id="btn-all-list">전체보기</button>


							<div class="ebox-input-group" style="margin-left: 20px;">
								<select class="form-control" id="searchType-1">
									<option value="" ${empty pageMaker.cri.searchType?'selected':'' } style="display: none">---</option>
									<option value="tn" ${pageMaker.cri.searchType eq "tn"?'selected':'' }>지점명</option>
									<option value="an" ${pageMaker.cri.searchType eq "an"?'selected':'' }>상영관 이름</option>
									<option value="fl" ${pageMaker.cri.searchType eq "fl"?'selected':'' }>위치(층)</option>
									<option value="vt" ${pageMaker.cri.searchType eq "vt"?'selected':'' }>시각 타입</option>
									<option value="st" ${pageMaker.cri.searchType eq "st"?'selected':'' }>사운드 타입</option>
									<option value="at" ${pageMaker.cri.searchType eq "at"?'selected':'' }>테마</option>
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
								지점 추가 <i class="fa fa-plus" aria-hidden="true"></i>
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
										<th class="thead-col-2">지점명</th>
										<th class="thead-col-3">상영관</th>
										<th class="thead-col-4">시각타입</th>
										<th class="thead-col-5">사운드 타입</th>
										<th class="thead-col-6">테마</th>
										<th class="thead-col-7">좌석수</th>
										<th class="thead-col-8">위치</th>
										<th class="thead-col-9"></th>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="audi" items="${audiList}">
										<tr>

											<td class="tbody-col-1"><label><input type="checkbox" class="chk-box" name="aNo" value="${audi.aNo}"></label></td>
											<td class="tbody-col-2"><a href="#">${!empty audi.theater.tName? audi.theater.tName:'-'}</a></td>
											<td class="tbody-col-3">${!empty audi.aName? audi.aName:'-'}</td>
											<td class="tbody-col-4">${!empty audi.aVType? audi.aVType.toUpperCase():'-'}</td>
											<td class="tbody-col-5">${!empty audi.aSType? audi.aSType.toUpperCase():'-'}</td>
											<%-- 											<td class="tbody-col-4">${!empty audi.aVType? audi.aVType.toUpperCase().replace(","," | "):'-'}</td>
											<td class="tbody-col-5">${!empty audi.aSType? audi.aSType.toUpperCase().replace(","," | "):'-'}</td> --%>
											<td class="tbody-col-6">${!empty audi.aTheme? audi.aTheme.toUpperCase():'-'}<c:if test="${!empty audi.aThemeSubInfo}">-${audi.aThemeSubInfo.toUpperCase()}</c:if></td>
											<td class="tbody-col-7"><a href="#"> 100석</a></td>
											<td class="tbody-col-8">${!empty audi.floor? audi.floor:'-'}</td>
											<td class="tbody-col-9">
												<button class="btn btn-warning btn-xs waves-effect waves-light btn-update-in-row" data-pk="${audi.aNo}" ondblclick="return false;">수정</button>
												<button class="btn btn-danger btn-xs waves-effect waves-light btn-delete-in-row" data-pk="${audi.aNo}" ondblclick="return false;">삭제</button>
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


<%@ include file="include/footer2.jsp"%>