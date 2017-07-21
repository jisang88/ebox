<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="include/header.jsp"%>


<link href="${pageContext.request.contextPath }/resources/css/admin/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/theater.css" rel="stylesheet">

<div id="page-wrapper">

	<div class="container-fluid">


		<!-- Page Heading -->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">
					시설물 <small> <i class="fa fa-building-o" aria-hidden="true"></i> 영화관
					</small>
				</h1>
			</div>
		</div>
		<!-- /.row -->


		<script type="text/javascript">
			//전역 변수
			var URL_THEATER = {

				HOME : "${pageContext.request.contextPath }/admin/theater",
				WRITE : "${pageContext.request.contextPath }/admin/theater/write",
				LIST : "${pageContext.request.contextPath }/admin/theater/list",
				DELETE : "${pageContext.request.contextPath }/admin/theater/delete",
				UPDATE : "${pageContext.request.contextPath }/admin/theater/update",
				READ : "${pageContext.request.contextPath }/admin/theater/read",
				MATCH_NAME : "${pageContext.request.contextPath }/admin/theater/match/name",
				SEARCH_LIKE_NAME : "${pageContext.request.contextPath }/admin/theater/search/name"

			}
			//--------------------------------------------------------------------

			var theater_gnb_param = {
				page : parseInt('${ pageMaker.cri.page}'),
				keyword : '${ pageMaker.cri.keyword}'
			};

			//--------------------------------------------------------------------

			function loadTheaterList(url, param) {
				ebox.loadList({
					url : url,
					param : param,
					tableBox : $('#theater-table-body'),
					template : $('#theater-list'),
					pagingBox : $('#theater-list-pagination')
				});
			}
		</script>
		<script type="text/javascript">
			$(function() {
				console.log(theater_gnb_param)

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
					if ($('.btn-cancel-theater').hasClass('btn-block')) { return; }
					console.log('screen width', window.innerWidth);
					$('.btn-submit-theater').addClass('btn-block');
					$('.btn-cancel-theater').addClass('btn-block');
					$('.btn-update-complete-theater').addClass('btn-block');
					$('.btn-update-cancel-theater').addClass('btn-block');

				} else {
					if (!$('.btn-cancel-theater').hasClass('btn-block')) { return; }
					console.log('screen width', window.innerWidth);
					$('.btn-submit-theater').removeClass('btn-block');
					$('.btn-cancel-theater').removeClass('btn-block');
					$('.btn-update-complete-theater').removeClass('btn-block');
					$('.btn-update-cancel-theater').removeClass('btn-block');
				}

			};
			//--------------------------------------------------------------------

			function initForm1() {

				$('.btn-cancel-theater').click();
				$('.btngroup-Forwrite').show();
				$('.btngroup-Forupdate').hide();

			}

			//--------------------------------------------------------------------
			function setHelpText() {
				//Input Text Check
				if (!ebox.setHelpTextForInput_TextWithSpace($('#tName'))) { return false; }
				if (!ebox.setHelpTextForInput_TextWithSpace($('#tManager'))) { return false; }
				if (!ebox.setHelpTextForInput_TextWithSpace($('#tTel'))) { return false; }
				if (!ebox.setHelpTextForInput_TextWithSpace($('#tAddrNum'))) { return false; }
				if (!ebox.setHelpTextForInput_TextWithSpace($('#tAddrSt'))) { return false; }

				return true;

			}//--------------------------------------------------------------------
		</script>


		<script type="text/javascript">
			$(function() {
				//
				$('.btn-cancel-theater').click(function() {
					$('#tForm1 .help-txt').hide();
				});

				//--------------------------------------------------------------------

				$('.btn-update-cancel-theater').click(function() {
					initForm1();
				});
				//--------------------------------------------------------------------

				$('#btn-listAll').click(function() {
					self.location = URL_THEATER.HOME;
				});

				////--------------------------------------------------------------------

				$('.btn-muti-select').change(function() {
					event.preventDefault();

					$(this).toggleClass('press')

					if ($(this).hasClass('press')) {
						$('input.chk-box').prop('checked', true);

					} else {
						$('input.chk-box').prop('checked', false);
					}

				});

				////--------------------------------------------------------------------

				$('#btn-search-theater').click(function() {
					event.preventDefault();

					var txt = $('#txt-search-theater').val().trim();
					console.log(txt.length)
					if (!ebox.isValid(txt) || txt.length < 2) { return; }

					theater_gnb_param.keyword = txt;
					self.location = URL_THEATER.HOME + ebox.makeQuery(theater_gnb_param);

				});

				//--------------------------------------------------------------------

				$('.btn-submit-theater').click(function(event) {
					event.preventDefault();

					if (!setHelpText()) { return; }

					$('#tNo').val(0);
					$('#tForm1').attr('action', URL_THEATER.WRITE);
					$('#tForm1').attr('method', 'post');
					$('#tForm1').submit();

				});

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

					$.post(URL_THEATER.DELETE, {
						tNo : arr
					}, function(data) {
						console.log(data)

						if ($('.btn-muti-select').hasClass('press')) $('.btn-muti-select').click();
						if (data == 'SUCCESS') {
							console.log("MULTI DELETE SUCCESS");
							initForm1();
							loadTheaterList(URL_THEATER.LIST, theater_gnb_param);
						}
					});// end of $.post

				});

				//--------------------------------------------------------------------

			});
		</script>

		<script type="text/javascript">
			//

			$(document).on('click', '#theater-list-pagination li a', function(event) {
				event.preventDefault();

				theater_gnb_param.page = $(this).attr('href').trim();
				theater_gnb_param.keyword = $('#txt-search-theater').val().trim();

				self.location = URL_THEATER.HOME + ebox.makeQuery(theater_gnb_param);

			});//--------------------------------------------------------------------
		</script>


		<div class="row">

			<div class="col-lg-4">

				<div class="panel panel-default">

					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-long-arrow-right fa-fw"></i> 지점 등록
						</h3>
					</div>

					<form name="tForm1" autocomplete="off" id="tForm1">
						<input type="hidden" name="tNo" id="tNo" value="0" />
						<div class="panel-body ">

							<div class="form-group">
								<label>지점명</label>
								<input type="text" name="tName" id="tName" class="form-control" placeholder="Enter Text">
								<p class="help-block ">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>담당자</label>
								<input type="text" name="tManager" id="tManager" class="form-control" placeholder="Enter Text">
								<p class="help-block ">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>전화번호</label>
								<input type="text" name="tTel" id="tTel" class="form-control" placeholder="Enter Text">
								<p class="help-block ">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>주소-지번</label>
								<input type="text" name="tAddrNum" id="tAddrNum" class="form-control" placeholder="Enter Text">
								<p class="help-block ">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>주소-도로명</label>
								<input type="text" name="tAddrSt" id="tAddrSt" class="form-control" placeholder="Enter Text">
								<p class="help-block ">Example block-level help text here.</p>
							</div>

						</div>
						<div class="panel-footer">
							<div class="text-right form-controller-btngroup">

								<div class="btngroup1-1 btngroup-Forwrite">
									<button type="submit" class="btn btn-default btn-submit-theater btn-submit">저장</button>
									<button type="reset" class="btn btn-default btn-cancel-theater">입력취소</button>
								</div>

								<div class="btngroup2-1 btngroup-Forupdate">
									<button type="submit" class="btn btn-default btn-update-complete btn-update-complete-theater ">수정완료</button>
									<button type="button" class="btn btn-primary btn-update-cancel-theater">수정취소</button>
									<button type="reset" class="btn btn-default btn-cancel-theater">입력취소</button>
								</div>




							</div>


						</div>
					</form>

				</div>

			</div>


			<div class="col-lg-8">

				<div class="panel panel-default">

					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-clock-o fa-fw"></i> 지점 리스트
						</h3>
					</div>

					<div class="panel-body my-panel-body">

						<div class="row table-control-btn-box">
							<div class="col-lg-12">

								<form class="form-inline" name="tForm2">

									<div class="btn-group table-btn-group">


										<div class="input-group btn btn-default btn-sm btn-with-checkbox">
											<label style="font-weight: 400;">
												<input type="checkbox" id="" class="btn-muti-select" />
												<span class="btn-muti-select-text">전체선택</span>
											</label>
										</div>


										<button class="btn btn-danger btn-sm btn-muti-remove1" id="btn-muti-remove">선택삭제</button>
										<button class="btn btn-danger btn-sm btn-muti-remove2" id="btn-muti-remove">삭제</button>

										<button class="btn btn-default btn-sm" id="btn-listAll" type="button">전체보기</button>

										<div class="input-group">
											<input type="text" value="${pageMaker.cri.keyword }" class="form-control input-sm" placeholder="Search" id="txt-search-theater">
											<div class="input-group-btn">
												<button class="btn btn-default btn-sm" type="button" id="btn-search-theater">
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
										<th>담당자</th>
										<th>전화번호</th>
										<th>주소</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="theater-table-body">

									<c:forEach var="theater" items="${theaterList}">
										<tr class="table-1-body-row">

											<td><label>
													<input type="checkbox" class="chk-box" name="tno" value="${theater.tNo}">
												</label></td>
											<td><a href="#">${theater.tName}</a></td>
											<td>${theater.tManager}</td>
											<td>${theater.tTel}</td>
											<td>
												<p>
													<span>지번</span> <span class="divider1">${theater.tAddrNum }</span>
												</p>
												<p>
													<span>도로명</span> <span class="divider1"></span>${theater.tAddrSt}
												</p>
											</td>
											<td>
												<button class="btn btn-warning btn-update btn-xs btn-table-theater-row-update">수정</button>
												<button class="btn btn-danger btn-delete btn-xs btn-table-theater-row-delete">삭제</button>
											</td>

										</tr>

									</c:forEach>
								</tbody>
							</table>
						</div>


					</div>
					<div class="panel-footer pager-box">

						<ul class="pagination pagination-sm" id="theater-list-pagination">

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




<script type="text/javascript">
	//

	$(function() {

		//

		$('.btn-update-complete-theater').click(function() {
			event.preventDefault();

			if (!ebox.setHelpTextForInput_TextWithSpace($('#tName'))) return;

			//--------------------------------------------------------------------

			$.get(URL_THEATER.MATCH_NAME, {

				tName : $('#tName').val().trim()

			}, function(data) {
				console.log('Data From Server\t', data);
				console.log('Form Data\t', $('#tForm1').serializeArray());

				$.post(URL_THEATER.UPDATE, ebox.getFormData($('#tForm1')), function(data) {

					if (data == 'SUCCESS') {
						initForm1();
						loadTheaterList(URL_THEATER.LIST, theater_gnb_param);
					}
				})

			}).fail(function(jqXHR, textStatus, error) {

				console.log('Ajax', '\t', 'Method:', 'Get', '\t', 'Url:', URL_THEATER.MATCH_NAME);
				console.log(error, '\t', 'Error Code', '\t', jqXHR.status);
				console.log('Error Message', '\t', 'Duplicate Error', '\t', 'Field:', 'tName');

			});// end of $.get

		});// end of function 'click'

		//

	});

	////--------------------------------------------------------------------

	//
	//
	// Table row delete button 처리
	$(document).on('click', '.btn-table-theater-row-delete', function() {

		var $tr = $(this).parent().parent();

		var arr = [];
		arr.push($tr.find('.chk-box').val());

		$.post(URL_THEATER.DELETE, {

			tNo : arr

		}, function(data) {

			if (data == 'SUCCESS') {
				initForm1();
				loadTheaterList(URL_THEATER.LIST, theater_gnb_param);
				console.log("DELETE SUCCESS");
			}

		});

	});

	//

	// Table row update button 처리
	$(document).on('click', '.btn-table-theater-row-update', function() {
		event.preventDefault();

		var $tr = $(this).parent().parent();

		$.get(URL_THEATER.READ, {

			tNo : $tr.find('.chk-box').val()

		}, function(data) {

			$('#tNo').val(data.tNo);
			$('#tName').val(data.tName);
			$('#tManager').val(data.tManager);
			$('#tTel').val(data.tTel);
			$('#tAddrNum').val(data.tAddrNum);
			$('#tAddrSt').val(data.tAddrSt);

			$('.btngroup-Forwrite').hide();
			$('.btngroup-Forupdate').show();
		})
	})

	//
</script>


<script id="theater-list" type="text/x-handlebars-template">
{{#each.}}
	<tr class="table-1-body-row">

		<td><label ><input type="checkbox" class="chk-box" name="tno" value="{{tNo }}"></label></td>
		<td><a href="#">{{tName}}</a></td>
		<td>{{tManager}}</td>
		<td>{{tTel}}</td>
		<td>
			<p>
			<span>지번</span> <span class="divider1">{{tAddrNum }}</span>
			</p>
			<p>
			<span>도로명</span> <span class="divider1"></span>{{tAddrSt}}
			</p>
		</td>
		<td>
			<button class="btn btn-warning btn-update btn-xs btn-table-theater-row-update" >수정</button>
			<button class="btn btn-danger btn-delete btn-xs btn-table-theater-row-delete" >삭제</button>
		</td>

	</tr>
{{/each}}
</script>




<%@ include file="include/footer.jsp"%>

