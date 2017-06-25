<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="include/header.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/theater.css" rel="stylesheet">

<div id="page-wrapper">

	<div class="container-fluid">


		<!-- Page Heading -->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">
					시설물 <small><i class="fa fa-building-o" aria-hidden="true"></i>영화관</small>
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

						<div class="panel-body my-panel-body">

							<div class="form-group">
								<label>지점명</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="지점명">
								<p class="help-block">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>담당자</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="담당자">
								<p class="help-block">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>전화번호</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="전화번호">
								<p class="help-block">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>주소-지번</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="주소-지번">
								<p class="help-block">Example block-level help text here.</p>
							</div>
							<div class="form-group">
								<label>주소-도로명</label>
								<input type="text" name="tname" id="tname" class="form-control" placeholder="주소-도로명">
								<p class="help-block">Example block-level help text here.</p>
							</div>





							<!-- <div class="form-group">
								<label>Static Control</label>
								<p class="form-control-static">email@example.com</p>
							</div> -->










						</div>
						<div class="panel-footer">
							<div class="text-right">
								<button type="submit" class="btn btn-default">Submit Button</button>
								<button type="reset" class="btn btn-default">Reset Button</button>
							</div>

						</div>
					</form>
				</div>

			</div>


			<div class="col-lg-8">

				<div class="panel panel-default">

					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-clock-o fa-fw"></i> 영화관 리스트
						</h3>
					</div>

					<div class="panel-body my-panel-body">

						<div class="row table-control-btn-box">
							<div class="col-lg-12">
								<form class="form-inline">

									<button type="submit" class="btn btn-default">전체선택</button>
									<button type="reset" class="btn btn-default">삭제</button>

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



						<div class="table-responsive">
							<table class="table table-hover table-striped">
								<thead>
									<tr>
										<th>Page</th>
										<th>Visits</th>
										<th>% New Visits</th>
										<th>Revenue</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>/index.html</td>
										<td>1265</td>
										<td>32.3%</td>
										<td>$321.33</td>
									</tr>
									<tr>
										<td>/index.html</td>
										<td>1265</td>
										<td>32.3%</td>
										<td>$321.33</td>
									</tr>
									<tr>
										<td>/about.html</td>
										<td>261</td>
										<td>33.3%</td>
										<td>$234.12</td>
									</tr>
									<tr>
										<td>/sales.html</td>
										<td>665</td>
										<td>21.3%</td>
										<td>$16.34</td>
									</tr>
									<tr>
										<td>/blog.html</td>
										<td>9516</td>
										<td>89.3%</td>
										<td>$1644.43</td>
									</tr>
									<tr>
										<td>/404.html</td>
										<td>23</td>
										<td>34.3%</td>
										<td>$23.52</td>
									</tr>
									<tr>
										<td>/services.html</td>
										<td>421</td>
										<td>60.3%</td>
										<td>$724.32</td>
									</tr>
									<tr>
										<td>/blog/post.html</td>
										<td>1233</td>
										<td>93.2%</td>
										<td>$126.34</td>
									</tr>
									<tr>
										<td>/services.html</td>
										<td>421</td>
										<td>60.3%</td>
										<td>$724.32</td>
									</tr>
									<tr>
										<td>/blog/post.html</td>
										<td>1233</td>
										<td>93.2%</td>
										<td>$126.34</td>
									</tr>
								</tbody>
							</table>
						</div>


					</div>
					<div class="panel-footer pager-box">

						<ul class="pagination pagination">
							<li class="previous"><a href="#">
									<i class="fa fa-angle-left" aria-hidden="true"></i>
								</a></li>

							<li><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>

							<li class="next"><a href="#">
									<i class="fa fa-angle-right" aria-hidden="true"></i>
								</a></li>
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

