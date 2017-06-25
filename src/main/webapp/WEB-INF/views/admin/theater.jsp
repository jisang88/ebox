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




		<div class="row">

			<div class="col-lg-4">

				<div class="panel panel-default">

					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-long-arrow-right fa-fw"></i> 지점 등록
						</h3>
					</div>

					<form role="form">

						<div class="panel-body ">
							<input type="hidden" name="page" value="${ pageMaker.cri.page } ">
							<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum} ">
							<input type="hidden" name="tno" id="tno" value="0">

							<c:if test="${pageMaker.cri.keyword != '' || pageMaker.cri.keyword ne null}">
								<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
							</c:if>



							<div class="form-group">
								<label>지점명</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="Enter Text">
								<p class="help-block">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>담당자</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="Enter Text">
								<p class="help-block">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>전화번호</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="Enter Text">
								<p class="help-block">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>주소-지번</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="Enter Text">
								<p class="help-block">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>주소-도로명</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="Enter Text">
								<p class="help-block">Example block-level help text here.</p>
							</div>



						</div>
						<div class="panel-footer">
							<div class="text-right">
								<button type="submit" class="btn btn-default btn-submit">저장</button>
								<button type="reset" class="btn btn-default">취소</button>
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
										<th>담당자</th>
										<th>전화번호</th>
										<th>주소</th>
										<th></th>
									</tr>
								</thead>
								<tbody>


									<c:forEach var="theater" items="${theaterList }">
										<tr>
											<td><a href="javascript:void(0)">
													<input type="checkbox" value="${theater.tno }" name="tnoArr">
												</a></td>
											<td><a href="#">${theater.tname }</a></td>
											<td>${theater.tmanager }</td>
											<td>${theater.ttel }</td>
											<td>${theater.taddr_num }</td>
											<td>${theater.taddr_str }</td>
										</tr>
									</c:forEach>



									<tr class="table-1-body-row">

										<td><label for="item">
												<input type="checkbox" id="item" name="tnoArr">
											</label></td>

										<td><a href="#">하 남 하 남 스 타 필 드</a></td>
										<td>홍홍 길 동</td>
										<td>054) 1554-1542</td>

										<td><p>
												<span>지번</span> <span class="divider1"></span>theater.taddr_num }theater.taddr_str }theater.taddr_str }theater.taddr_str }theater.taddr_str }theater.taddr_str }
											</p>
											<p>
												<span>도로명</span> <span class="divider1"></span>theater.taddr_num }theater.taddr_str }theater.taddr_str }theater.taddr_str }theater.taddr_str }theater.taddr_str }
											</p></td>

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

