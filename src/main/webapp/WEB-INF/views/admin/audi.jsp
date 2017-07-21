<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="include/header.jsp"%>




<link href="${pageContext.request.contextPath }/resources/css/admin/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/audi.css" rel="stylesheet">


<div id="page-wrapper">

	<div class="container-fluid">


		<!-- Page Heading -->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">
					시설물 <small> <i class="fa fa-wifi" aria-hidden="true"></i> 상영관
					</small>
				</h1>
			</div>
		</div>
		<!-- /.row -->

		<script type="text/javascript">
			/* 
				페이징 and keyowrd 는  no ajax & get 처리
				수정 삭제는 ajax로 처리
			
			 */

			//전역 변수
			var URL_AUDI = {

				HOME : "${pageContext.request.contextPath }/admin/audi",
				WRITE : "${pageContext.request.contextPath }/admin/audi/write",
				LIST : "${pageContext.request.contextPath }/admin/audi/list",
				DELETE : "${pageContext.request.contextPath }/admin/audi/delete",
				UPDATE : "${pageContext.request.contextPath }/admin/audi/update",
				READ : "${pageContext.request.contextPath }/admin/audi/read"

			}
			//--------------------------------------------------------------------

			var URL_THEATER = {

				READ : "${pageContext.request.contextPath }/admin/theater/read",
				MATCH_NAME : "${pageContext.request.contextPath }/admin/theater/match/name",
				SEARCH_LIKE_NAME : "${pageContext.request.contextPath }/admin/theater/search/name"

			}

			//--------------------------------------------------------------------

			var audi_gnb_param = {
				page : parseInt('${ pageMaker.cri.page}'),
				keyword : '${ pageMaker.cri.keyword}'
			};

			//--------------------------------------------------------------------

			function loadAudiList(url, param) {

				ebox.loadList({
					url : url,
					param : param,
					tableBox : $('#audi-table-body'),
					template : $('#audi-list-template'),
					pagingBox : $('#audi-list-pagination')
				});

			}
			//--------------------------------------------------------------------

			$(function() {
				console.log(audi_gnb_param)

				// 버튼 디바인 초기화
				formBtnDesignToScreenWidth();

			});
			//--------------------------------------------------------------------

			window.onresize = function() {

				formBtnDesignToScreenWidth();

			};

			//--------------------------------------------------------------------

			function formBtnDesignToScreenWidth() {

				width = window.innerWidth || document.body.clientWidth;
				if (width >= 1200 && width <= 1550) {

					//$('.btngroup-Forwrite').css()
					if ($('.btn-cancel-audi').hasClass('btn-block')) { return; }
					console.log('screen width', window.innerWidth);
					$('.btn-submit-audi').addClass('btn-block');
					$('.btn-cancel-audi').addClass('btn-block');
					$('.btn-update-complete-audi').addClass('btn-block');
					$('.btn-update-cancel-audi').addClass('btn-block');

				} else {
					if (!$('.btn-cancel-audi').hasClass('btn-block')) { return; }
					console.log('screen width', window.innerWidth);
					$('.btn-submit-audi').removeClass('btn-block');
					$('.btn-cancel-audi').removeClass('btn-block');
					$('.btn-update-complete-audi').removeClass('btn-block');
					$('.btn-update-cancel-audi').removeClass('btn-block');
				}

			};
			//--------------------------------------------------------------------

			function initForm1() {

				$('.btn-cancel-audi').click();
				$('.btngroup-Forwrite').show();
				$('.btngroup-Forupdate').hide();

			}

			//--------------------------------------------------------------------

			function setHelpText() {
				//Input Text Check
				if (!ebox.setHelpTextForInput_Text($('#tName'))) { return false; }
				if (!ebox.setHelpTextForInput_Text($('#aName'))) { return false; }
				if (!ebox.setHelpTextForInput_Text($('#floor'))) { return false; }

				//Input Radio Check
				if (!ebox.setHelpTextForInput_Radio($('#aVType'))) { return false; }
				if (!ebox.setHelpTextForInput_Radio($('#aSType'))) { return false; }
				if (!ebox.setHelpTextForInput_Radio($('#aTheme'))) { return false; }
				if (!ebox.setHelpTextForInput_Radio($('#aThemeSubInfo'))) { return false; }

				return true;

			}//--------------------------------------------------------------------

			//

			$(function() {

				//
				$('.btn-cancel-audi').click(function() {
					$('#aForm1 .help-txt').hide();
				});

				//--------------------------------------------------------------------

				$('.btn-update-cancel-audi').click(function() {
					initForm1();
				});
				//--------------------------------------------------------------------

				$('#btn-listAll').click(function() {
					self.location = URL_AUDI.HOME;
				});

				////--------------------------------------------------------------------

				$('.btn-muti-select').change(function() {
					event.preventDefault();

					$(this).toggleClass('press');

					if ($(this).hasClass('press')) {
						$('input.chk-box').prop('checked', true);

					} else {
						$('input.chk-box').prop('checked', false);
					}

				});

				////--------------------------------------------------------------------

				$('#btn-search-audi').click(function() {
					event.preventDefault();

					var txt = $('#txt-search-audi').val().trim();
					if (!ebox.isValid(txt) || txt.length < 2) { return; }

					audi_gnb_param.keyword = txt;
					self.location = URL_AUDI.HOME + ebox.makeQuery(audi_gnb_param);

				});

				//--------------------------------------------------------------------

				$('.btn-submit-audi').click(function(event) {
					event.preventDefault();

					if (!setHelpText()) { return; }

					$.get(URL_THEATER.MATCH_NAME, {

						tName : $('#tName').val()

					}, function(data) {

						if (!ebox.isValid(data)) {
							alert('입력한 지점은 없는 지점입니다.');
							return;

						} else {

							$('#tNo').val(data.tNo);

							$('#aForm1').attr('action', URL_AUDI.WRITE);
							$('#aForm1').submit();

						}

					});

				});

				////--------------------------------------------------------------------

				$('.btn-update-complete-audi').click(function() {
					event.preventDefault();

					if (!setHelpText()) { return; }

					//--------------------------------

					$.get(URL_THEATER.MATCH_NAME, {
						tName : $('#tName').val()
					}, function(data) {

						if (!ebox.isValid(data)) {
							alert('입력한 지점은 없는 지점입니다.');
							return;

						} else {
							$('#tNo').val(data.tNo);
							console.log("tNo val - 2", $('#tNo').val());

							$.post(URL_AUDI.UPDATE, ebox.getFormData($('#aForm1')), function(data) {

								if (data == 'SUCCESS') {
									initForm1();
									loadAudiList(URL_AUDI.LIST, audi_gnb_param);
								}

							});

						}

					});

				});//click

				////--------------------------------------------------------------------

				$('#btn-muti-remove').click(function() {
					event.preventDefault();

					var arr = [];
					var $arrChbox = $('.chk-box:checked');

					$arrChbox.each(function(i, elt) {
						arr.push($(elt).val());
					});

					if (arr.length == 0) {
						alert('선택된 항목이 없습니다.');
						return;
					}

					//-----------------------------------

					$.post(URL_AUDI.DELETE, {

						aNo : arr

					}, function(data) {

						if ($('.btn-muti-select').hasClass('press')) $('.btn-muti-select').click();
						if (data == 'SUCCESS') {
							console.log("MULTI DELETE SUCCESS");
							initForm1();
							loadAudiList(URL_AUDI.LIST, audi_gnb_param);
						}
					});// end of $.post

				});

			});

			//--------------------------------------------------------------------
			//--------------------------------------------------------------------

			// Table row delete button 처리
			$(document).on('click', '.btn-table-audi-row-delete', function() {
				event.preventDefault();
				var $tr = $(this).parent().parent();

				var arr = [];
				arr.push($tr.find('.chk-box').val());

				$.post(URL_AUDI.DELETE, {

					aNo : arr

				}, function(data) {

					if (data == 'SUCCESS') {
						initForm1();
						loadAudiList(URL_AUDI.LIST, audi_gnb_param);
						console.log("DELETE SUCCESS");
					}

				});

			});//--------------------------------------------------------------------

			// Table row update button 처리
			$(document).on('click', '.btn-table-audi-row-update', function() {
				event.preventDefault();

				var $tr = $(this).parent().parent();

				$.get(URL_AUDI.READ, {

					aNo : $tr.find('.chk-box').val()

				}, function(data) {
					console.log(data);

					$('#tNo').val(data.theater.tNo);
					$('#tName').val(data.theater.tName);

					$('#aNo').val(data.aNo);
					$('#aName').val(data.aName);
					$('#aTheme').val(data.aTheme);
					$('#floor').val(data.floor);

					$('#aVType [name="aVType"][value="' + data.aVType + '"]').prop('checked', true);
					$('#aSType [name="aSType"][value="' + data.aSType + '"]').prop('checked', true);
					$('#aThemeSubInfo [name="aThemeSubInfo"][value="' + data.aThemeSubInfo + '"]').prop('checked', true);

					$('.btngroup-Forwrite').hide();
					$('.btngroup-Forupdate').show();

				})

			})//--------------------------------------------------------------------

			//

			//

			$(document).on('click', '#audi-list-pagination li a', function(event) {
				event.preventDefault();

				audi_gnb_param.page = $(this).attr('href').trim();
				audi_gnb_param.keyword = $('#txt-search-audi').val().trim();

				self.location = URL_AUDI.HOME + ebox.makeQuery(audi_gnb_param);

			});//--------------------------------------------------------------------

			//

			//
		</script>



		<div class="row">


			<!-- --------------------------------- START OF LEFT COLUM-------------------------------------------- -->
			<div class="col-lg-3">

				<div class="panel panel-default">

					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-long-arrow-right fa-fw"></i> 상영관 등록
						</h3>
					</div>

					<form name="aForm1" autocomplete="off" id="aForm1" method="post">

						<div class="panel-body ">

							<input type="text" name="aNo" id="aNo" value="0" style="display: none">
							<input type="text" name="tNo" id="tNo" value="0" style="display: none">

							<div class="form-group">
								<label class="">지점 이름</label>
								<span class="help-txt help-inline pull-right">지점을 입력해주세요.</span>
								<input type="text" name="tName" id="tName" class="form-control" placeholder="지점을 입력해주세요.">
							</div>


							<div class="form-group">
								<label>상영관 이름</label>
								<span class="help-txt help-inline pull-right">상영관 이름을 입력해주세요.</span>
								<input type="text" name="aName" id="aName" class="form-control" placeholder="Enter Text">
							</div>




							<div class="form-group">
								<label> 시각 타입 </label>
								<span class="help-txt help-inline pull-right">시각 타입을 선택해주세요.</span>


								<!-- aVType -->
								<div class="col-md-offset-1" id="aVType">

									<div class="radio">
										<label>
											<input type="radio" name="aVType" id="aVType-2D" value="2D">
											2D <span class="add-tip  ">(Only)</span>
										</label>
									</div>

									<div class="radio">
										<label>
											<input type="radio" name="aVType" id="aVType-3D" value="3D">
											3D <span class="add-tip  ">(Only)</span>
										</label>
									</div>

									<div class="radio">
										<label>
											<input type="radio" name="aVType" id="aVType-2DAnd3D" value="2D,3D">
											2D & 3D
										</label>
									</div>

								</div>
								<!-- End of aVType -->


							</div>


							<div class="form-group">
								<label> 사운드 타입 </label>
								<span class="help-txt help-inline pull-right">사운드 타입을 선택해주세요.</span>

								<!-- aSType -->
								<div class="col-md-offset-1" id="aSType">

									<div class="radio">
										<label>
											<input type="radio" name="aSType" id="aSType-normal" value="normal">
											Normal <span class="add-tip  ">(Only)</span>
										</label>
									</div>

									<div class="radio">
										<label>
											<input type="radio" name="aSType" id="aSType-atmos" value="atmos">
											ATMOS <span class="add-tip ">(Only)</span>
										</label>
									</div>

									<div class="radio">
										<label>
											<input type="radio" name="aSType" id="aSType-normalAndAtmos" value="normal,atmos">
											Normal & ATMOS
										</label>
									</div>


								</div>
								<!-- End of aSType -->

							</div>



							<div class="form-group">
								<label>테마</label>
								<span class="help-txt help-inline pull-right">상영관 타입을 선택해주세요.</span>
								<!-- -->
								<select class="form-control" name="aTheme" id="aTheme" multiple size="3" onchange="ebox.setMutiSelectLimit(this)">
									<option value="normal">Normal</option>
									<option value="table">Table</option>
									<option value="comfort">Comfort</option>
									<option value="the boutique">The Boutique</option>
									<option value="kids box">Kids Box</option>
									<option value="barcony m">Barcony M</option>

								</select>
							</div>

							<div class="form-group aThemeSubInfo-box">

								<label>테마부가정보</label>

								<span class="help-txt help-inline pull-right">테마 부가정보를 선택해주세요.</span>

								<div class="col-md-offset-1" id="aThemeSubInfo">

									<div class="radio">
										<label>
											<input type="radio" name="aThemeSubInfo" value="">
											없음
										</label>
									</div>
									<div class="radio">
										<label>
											<input type="radio" name="aThemeSubInfo" value="suite">
											Suite (The Boutique)
										</label>
									</div>
									<div class="radio">
										<label>
											<input type="radio" name="aThemeSubInfo" value="deluxe">
											Deluxe (Barcony M)
										</label>
									</div>

								</div>


							</div>




							<div class="form-group">
								<label>위치</label>
								<span class="help-txt help-inline pull-right">상영관 위치(층)를 입력해주세요.</span>
								<input type="text" name="floor" id="floor" class="form-control" placeholder="Enter Text">
							</div>
						</div>
						<div class="panel-footer">
							<div class="text-right form-controller-btngroup">

								<div class="btngroup1-1 btngroup-Forwrite">
									<button type="submit" class="btn btn-default btn-submit-audi btn-submit">저장</button>
									<button type="reset" class="btn btn-default btn-cancel-audi">입력취소</button>
								</div>

								<div class="btngroup2-1 btngroup-Forupdate">
									<button type="submit" class="btn btn-default btn-update-complete btn-update-complete-audi ">수정완료</button>
									<button type="button" class="btn btn-primary btn-update-cancel-audi">수정취소</button>
									<button type="reset" class="btn btn-default btn-cancel-audi">입력취소</button>
								</div>




							</div>

						</div>
					</form>

				</div>


			</div>

			<!-- --------------------------------- END OF LEFT COLUM-------------------------------------------- -->


			<div class="col-lg-9">


				<div class="panel panel-default">

					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-clock-o fa-fw"></i> 지점 리스트
						</h3>
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
										<th>지점명</th>
										<th>상영관</th>
										<th>시각타입</th>
										<th>사운드 타입</th>
										<th>테마</th>

										<th>좌석수</th>
										<th>위치</th>
										<th></th>

									</tr>
								</thead>

								<tbody id="audi-table-body">

									<c:forEach var="audi" items="${audiList}">
										<tr class="table-1-body-row">

											<td><label>
													<input type="checkbox" name="aNo" value="${audi.aNo}" class="chk-box">
												</label></td>
											<td><a data-toggle="modal" data-target="#modalTheater" onclick="modalTheater(this)" data-tno="${audi.theater.tNo}">${audi.theater.tName}</a></td>
											<td><a data-toggle="modal" data-target="#modalAudi" onclick="modalAudi(this)">${audi.aName}</a></td>
											<td>${audi.aVType.toUpperCase().replace(","," | ")}</td>
											<td>${audi.aSType.toUpperCase().replace(","," | ")}</td>
											<td>${audi.aTheme.toUpperCase()}<c:if test="${!empty audi.aThemeSubInfo}">-${audi.aThemeSubInfo.toUpperCase()}</c:if></td>
											<td>300석</td>
											<td>${audi.floor}</td>

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


<!-- Modal -->
<div id="modalAudi" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">상영관 상세정보</h4>
			</div>
			<div class="modal-body modal-audi">


				<form class="form-horizontal col-md-10 col-md-offset-1">

					<div class="form-group">
						<label class="control-label col-sm-3 modal-label">지점 이름</label>
						<div class="col-sm-9">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-tName"></span>
							</span>
						</div>
					</div>

					<div class="form-group  ">
						<label class="control-label col-sm-3 modal-label">상영관 이름</label>
						<div class="col-sm-9">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-aName"></span>
							</span>
						</div>
					</div>

					<div class="form-group  ">
						<label class="control-label col-sm-3 modal-label">시각 타입</label>
						<div class="col-sm-9">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-aVType"></span>
							</span>
						</div>
					</div>

					<div class="form-group  ">
						<label class="control-label col-sm-3 modal-label">사운드 타입</label>
						<div class="col-sm-9">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-aSType"></span>
							</span>
						</div>
					</div>
					<div class="form-group  ">
						<label class="control-label col-sm-3 modal-label">테마</label>
						<div class="col-sm-9">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-aTheme"></span>
							</span>
						</div>
					</div>
					<div class="form-group  ">
						<label class="control-label col-sm-3 modal-label">테마부가정보</label>
						<div class="col-sm-9">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-aThemeSubInfo"></span>
							</span>
						</div>
					</div>
					<div class="form-group  ">
						<label class="control-label col-sm-3 modal-label">위치</label>
						<div class="col-sm-9">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-floor"></span>
							</span>
						</div>
					</div>
					<div class="form-group  ">
						<label class="control-label col-sm-3 modal-label">좌석 수</label>
						<div class="col-sm-9">
							<span class="form-control modal-out-text"> <span class="modal-text" id="modal-aSeatCnt"></span>
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





<script type="text/javascript">
	//----------------------------------AutoComplete-----------------------------------------
	$(function() {

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

			$.get(URL_THEATER.SEARCH_LIKE_NAME, {

				keyword : req.term.trim()

			}, function(data) {
				console.log(data)

				res($.map(data.list, function(item) {
					return {
						label : item.tName,
						value : item.tName,
						tNo : item.tNo
					};
				}))// res

			});//$.get

		};

		ebox.setAutoComplete($('#tName'), autocomplete_temp, autocomplete_ajax);

		/* ---------------------------------------------------------------------------------- */

	});
	// Table row delete button 처리
</script>

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

