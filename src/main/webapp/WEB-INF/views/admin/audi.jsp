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








		<div class="row">


			<div class="col-lg-4">

				<div class="panel-group">

					<div class="panel panel-default small-table-panel">

						<div class="panel-heading ">

							<div class="form-group col-sm-6">
								<h3 class="panel-title ">
									<i class="fa fa-long-arrow-right fa-fw"></i> 지점 찾기
								</h3>
							</div>


							<div class="form-group input-group theater-search-box ">
								<input type="text" class="form-control" placeholder="지점을 입력하세요">
								<span class="input-group-btn">
									<button class="btn btn-default" type="button">
										<i class="fa fa-search"></i>
									</button>
								</span>
							</div>



						</div>


						<div class="panel-body ">



							<div>
								<table class="table table-hover table-striped table-condensed">
									<thead>
										<tr class="table-2-head-row">
											<th>선택</th>
											<th>지점명</th>
										</tr>
									</thead>

									<tbody>

										<tr class="table-2-body-row">

											<td><label for="r1">
													<input type="radio" id="r1" name="tnoArr">
												</label></td>
											<td>하 남 하 남 스 타 필 드</td>
										</tr>
										<tr class="table-2-body-row">

											<td><label for="r1">
													<input type="radio" id="r1" name="tnoArr">
												</label></td>
											<td>하 남 하 남 스 타 필 드</td>
										</tr>
										<tr class="table-2-body-row">

											<td><label for="r1">
													<input type="radio" id="r1" name="tnoArr">
												</label></td>
											<td>하 남 하 남 스 타 필 드</td>
										</tr>
										<tr class="table-2-body-row">

											<td><label for="r1">
													<input type="radio" id="r1" name="tnoArr">
												</label></td>
											<td>하 남 하 남 스 타 필 드</td>
										</tr>
										<tr class="table-2-body-row">

											<td><label for="r1">
													<input type="radio" id="r1" name="tnoArr">
												</label></td>
											<td>하 남 하 남 스 타 필 드</td>
										</tr>

									</tbody>

								</table>
							</div>


						</div>

						<div class="panel-footer pager-box">

							<ul class="pagination pagination-sm">



								<c:if test="${pageMaker.prev }">
									<li class="previous"><a href="theater${pageMaker.makeQuery(pageMaker.startPage-1) }">
											<i class="fa fa-caret-left" aria-hidden="true"></i>
										</a></li>
								</c:if>

								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="idx">


									<li class="${pageMaker.cri.page==idx?'active':'' }"><a href="theater${pageMaker.makeQuery(idx) } ">${idx==0?1:idx }</a></li>


								</c:forEach>

								<c:if test="${pageMaker.next && pageMaker.endPage>0}">
									<li class="next"><a href="theater${pageMaker.makeQuery(pageMaker.endPage+1) } ">
											<i class="fa fa-angle-right" aria-hidden="true"></i>
										</a></li>
								</c:if>

							</ul>
						</div>





					</div>


					<div class="panel panel-default">

						<div class="panel-heading">
							<h3 class="panel-title">
								<i class="fa fa-long-arrow-right fa-fw"></i> 상영관 등록
							</h3>
						</div>


						<div class="panel-body ">


							<div class="form-group">
								<label>영화관 선택</label>
								<span class="help-inline pull-right">block-level help text here.</span>
								<input type="text" name="tno" id="tno" class="form-control" placeholder="Enter Text">
							</div>
							<div class="form-group">
								<label>상영관 이름</label>
								<span class="help-inline pull-right">block-level help text here.</span>
								<input type="text" name="aname" id="aname" class="form-control" placeholder="Enter Text">
							</div>
							<div class="form-group">
								<label>타입</label>
								<span class="help-inline pull-right">block-level help text here.</span>
								<input type="text" name="atype" id="atype" class="form-control" placeholder="Enter Text">
							</div>
							<div class="form-group">
								<label>위치</label>
								<span class="help-inline pull-right">block-level help text here.</span>
								<input type="text" name="floor" id="floor" class="form-control" placeholder="Enter Text">
							</div>



						</div>
						<div class="panel-footer">
							<div class="text-right">
								<button type="submit" class="btn btn-default btn-submit">저장</button>
								<button type="reset" class="btn btn-default">취소</button>
							</div>

						</div>

					</div>
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
								<form class="form-inline">


									<input type="hidden" name="page" value="${pageMaker.cri.page}">
									<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}">
									<c:if test="${pageMaker.cri.keyword != '' || pageMaker.cri.keyword ne null}">
										<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
									</c:if>

									<button class="btn btn-default">전체선택</button>
									<button class="btn btn-danger">삭제</button>

									<div class="input-group">
										<input type="text" class="form-control" placeholder="Search">
										<div class="input-group-btn">
											<button class="btn btn-default" type="submit">
												<i class="glyphicon glyphicon-search"></i>
											</button>
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
										<th>타입</th>
										<th>좌석수</th>
										<th>위치</th>
										<th></th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="audi" items="${audiList }">
										<tr>
											<td><a href="javascript:void(0)">
													<input type="checkbox" value="${audi.ano }" class="list-checkbox" name="anoArr">
												</a></td>
											<td>${audi.theater.tname }</td>
											<td>${audi.aname }</td>
											<td>${audi.atype }</td>
											<td>${audi.floor }</td>
											<td><button class="btn btn-warning">수정</button>
												<button class="btn btn-danger">삭제</button></td>
										</tr>
									</c:forEach>



									<tr class="table-1-body-row">

										<td><label for="item">
												<input type="checkbox" id="item" name="tnoArr">
											</label></td>

										<td><a href="#">하 남 하 남 스 타 필 드</a></td>
										<td>1관</td>
										<td>일반</td>
										<td>300석</td>
										<td>5층</td>

										<td><button class="btn btn-warning">수정</button>
											<button class="btn btn-danger">삭제</button></td>
									</tr>

								</tbody>

							</table>
						</div>


					</div>
					<div class="panel-footer pager-box">

						<ul class="pagination pagination">



							<c:if test="${pageMaker.prev }">
								<li class="previous"><a href="theater${pageMaker.makeQuery(pageMaker.startPage-1) }">
										<i class="fa fa-caret-left" aria-hidden="true"></i>
									</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="idx">


								<li class="${pageMaker.cri.page==idx?'active':'' }"><a href="theater${pageMaker.makeQuery(idx) } ">${idx==0?1:idx }</a></li>


							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage>0}">
								<li class="next"><a href="theater${pageMaker.makeQuery(pageMaker.endPage+1) } ">
										<i class="fa fa-angle-right" aria-hidden="true"></i>
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



<%@ include file="include/footer.jsp"%>

