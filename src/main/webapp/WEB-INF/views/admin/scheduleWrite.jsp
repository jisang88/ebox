<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="include/header.jsp"%>

<link href="${pageContext.request.contextPath }/resources/css/admin/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/audi.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/resources/js/KobisOpenAPIRestService.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/moment.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.mask.min.js"></script>


<link href="${pageContext.request.contextPath }/resources/plugins/flatpickr/flatpickr.min.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/plugins/flatpickr/flatpickr.min.js"></script>

<link href="${pageContext.request.contextPath }/resources/plugins/select2/select2.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath }/resources/plugins/select2/select2.min.js"></script>

<link href="${pageContext.request.contextPath }/resources/plugins/fullcalendar-3.4.0/fullcalendar.min.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath }/resources/plugins/fullcalendar-3.4.0/fullcalendar.min.js"></script>

<style>
.select2-container--focus, .select2-container--default {
	width: 100% !important;
}
</style>
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
			$(function() {
				$('.mask-time').mask('00:00');

				/* $("#scrBuyDt").flatpickr();
				$("#scrSDate").flatpickr();
				$("#scrEDate").flatpickr();
				$('#scrPrice').mask("#,##0", {
					reverse : true
				});
				
				/*  ---------------------------------------------------------------------------------------
				 START
				 
				 SELECT2 --> #select-screenlist
				----------------------------------------------------------------------------------------- */

				$("#select-screenlist").select2({
					placeholder : "Search for a repository",
					minimumInputLength : 2,
					ajax : {
						url : "${pageContext.request.contextPath }/admin/screen/search/list",
						dataType : 'json',
						delay : 250,
						data : function(params) {
							//console.log('data\t', params)
							return {
								keyword : params.term, // search term
								page : params.page,
							};
						},
						processResults : function(data, params) {

							params.page = params.page || 1;
							console.log(data)
							return {
								results : $.map(data.list, function(vo) {
									return {
										id : vo.scrNo,
										text : vo.movie.mNm,
										scrNo : vo.scrNo,
										mNmEn : vo.movie.mNmEn,
										mDirector : vo.movie.mDirector,
										scrType : vo.scrType,
										mOpenDt : moment(vo.movie.mOpenDt).format('YYYY-MM-DD')
									}
								}),
								pagination : {
									more : (params.page * 10) < data.total
								}
							};
						},
						cache : true
					},
					escapeMarkup : function(markup) {
						return markup;
					}, // let our custom formatter work
					templateResult : function(item) {

						if (item.id == null || typeof item.id == 'undefined') { return null; }

						var $p = $('<p/>');
						var $span_movieNmEn = $('<span style="font-size:10px; margin-left:5px;"><span/>');
						$span_movieNmEn.text('(' + item.mNmEn + ")");

						var $span_open = $('<span style="font-size:10px; margin-left:5px;"><span/>');
						$span_open.text(' | 개봉날짜 : ' + item.mOpenDt);

						var $span_type = $('<span style="font-size:10px; margin-left:5px;"><span/>');
						$span_type.text(' | 스크린 타입 : ' + item.scrType);

						var $span_dir = $('<span style="font-size:10px; margin-left:5px;"><span/>');

						$span_dir.text(' | 감독 : ' + item.mDirector);

						$p.text(item.text);
						$p.append($span_movieNmEn);
						$p.append($span_type);
						$p.append($span_open);
						$p.append($span_dir);

						return $p;
					},
					templateSelection : function(item) {
						//console.log('templateSelection\t', item);
						if (!item.id) { return item.text; }

						if (item.selected != true) {
							setScreenInfoToInputBox(item);
							item.selected = true;
						}

						var $span1 = $('<span/>');
						$span1.text(item.text);

						var $span_dir = $('<span style="font-size:10px; margin-left:5px;"><span/>');
						$span_dir.text(' | 감독 : ' + item.mDirector);

						var $span_type = $('<span style="font-size:10px; margin-left:5px;"><span/>');
						$span_type.text(' | 스크린 타입 : ' + item.scrType);

						$span1.append($span_dir);
						$span1.append($span_type);

						return $span1;
					}
				});

				function setScreenInfoToInputBox(item) {
					console.log("ok", item)

					$('#refScrno').val(item.id);

				}
				/*  ---------------------------------------------------------------------------------------
				END
				
				SELECT2 --> #select-screenlist
				----------------------------------------------------------------------------------------- */

				/*  ---------------------------------------------------------------------------------------
				 START
				 
				 SELECT2 --> #theater
				----------------------------------------------------------------------------------------- */

				$("#theater").select2({
					placeholder : "Search for Theater",
					minimumInputLength : 2,
					ajax : {
						url : "${pageContext.request.contextPath }/admin/theater/search/name",
						dataType : 'json',
						delay : 250,
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
					},
					templateResult : function(item) {
						if (item.id == null || typeof item.id == 'undefined') { return null; }
						return item.text;
					},
					templateSelection : function(item) {
						if (!item.id) { return item.text; }
						//console.log('templateSelection\t', item);

						if (item.selected != true) {
							setAudiSelectBox(item);
							item.selected = true;
						}

						return item.text;
					}
				});

				/*  ---------------------------------------------------------------------------------------
				 END
				 
				 SELECT2 --> #theater
				----------------------------------------------------------------------------------------- */

			});

			function setAudiSelectBox(item) {
				console.log('선택완료', item)

				$.get('${pageContext.request.contextPath }/admin/audi/listTno', {
					tNo : item.id
				}, function(data) {
					console.log('data', data);

					$('#refAno').empty();

					data.forEach(function(elt, i, array) {
						var $option = $('<option/>', {
							text : elt.aName,
							value : elt.aNo
						});

						$('#refAno').append($option)
					})

					$('#refAno').change();
				})
			}
		</script>




		<script type="text/javascript">
			var calendar_event = {
				event : {
					title : null,
					start : null,
					end : null,
					schType : null,
					scrType : null,
					allDay : null
				},
				jsEvent : null,
				view : null,
			}

			function setSelectDataParam(start, end, jsEvent, view) {
				resetSelectDataParam();
				calendar_event.event.start = start;
				calendar_event.event.end = end;
				calendar_event.jsEvent = jsEvent;
				calendar_event.view = view;
			}

			function getSelectDataParam() {
				return calendar_event;
			}

			function resetSelectDataParam() {

				calendar_event = {
					event : {
						title : null,
						start : null,
						end : null,
						schType : null,
						scrType : null,
						allDay : null
					},
					jsEvent : null,
					view : null,
				}
			}

			var $calendar;
			$(function() {

				/*---------------------------------------------------------------------------------
				 START - FullCalendar 
				 
				---------------------------------------------------------------------------------*/

				$calendar = $('#calendar').fullCalendar({
					/* dayClick : function(e) {
						console.log(getSelectDataParam().start.format('YYYY-MM-DD'))
					}, */
					header : {
						left : 'title',
						center : '',
						right : 'today,month,agendaDay,agendaWeek prev,next'
					},
					selectable : true,
					eventDurationEditable : false,
					//allDayDefault : false,
					/* allDaySlot : false, */
					select : function(start, end, jsEvent, view) {

						var aNo = $('#refAno').val();
						if (aNo == 0 || typeof aNo == 'undefined' || aNo == null || aNo == '') { return; }

						setSelectDataParam(start, end, jsEvent, view);
						$('#myModal').modal();

						/* var title = prompt("Enter a title for this event", "New Event");
						if (title != null) {
							var event = {
								title : title.trim() != "" ? title : "New event",
								start : start.format('YYYY-MM-DD') + 'T' + '17:00',
								end : end.subtract(1, 'days').format('YYYY-MM-DD') + 'T' + '19:00',
								allDay : false
							};
							console.log('event\t', event)
							$calendar.fullCalendar("renderEvent", event, true);

						}
						$calendar.fullCalendar("unselect"); */

					},

					editable : true,
					eventClick : function(event, jsEvent, view) {
						var newTitle = prompt("Enter a new title for this event", event.title);

						if (newTitle != null) {
							event.title = newTitle.trim() != "" ? newTitle : event.title;
							$calendar.fullCalendar("updateEvent", event);

						}
					},

					eventRender : function(event, element) {

						var $div = $('<div/>', {
							css : {
								textAlign : "right"
							}
						});

						var $span = $('<span/>', {
							'class' : "closeon"
						})

						var $a = $('<a/>', {
							href : 'javascript:void(0)',
							text : 'DELETE',
							css : {
								color : 'red'
							}
						})

						$span.append($a);
						$div.append($span);

						console.log(event)

						element.append($div);

						element.find(".closeon").click(function() {
							//$('#calendar').fullCalendar('removeEvents', event._id);

						});
					},
					events : function(start, end, timezone, callback) {
						var aNo = $('#refAno').val();
						if (aNo == 0 || typeof aNo == 'undefined' || aNo == null || aNo == '') {
							console.log('STOP FUNCTION\tCuz \'aNo\' Not Valid');
							return callback();
						}

						var params = {
							start : start.format('YYYY-MM-DD'),
							end : end.format('YYYY-MM-DD'),
							aNo : aNo
						}

						var events;
						$.get('${pageContext.request.contextPath }/admin/schedule/calendar/list', params, function(data) {
							console.log('event Get From server\t', data)

							events = $.map(data, function(elt, i) {
								return {
									start : moment(elt.schDate).format('YYYY-MM-DD') + 'T' + elt.schStart,
									end : moment(elt.schDate).format('YYYY-MM-DD') + 'T' + elt.schEnd,
									title : elt.screen.movie.mNm,
									allDay : false,
								}
							})

							console.log('events', events)
							callback(events)
						});
					}

				});

				/*---------------------------------------------------------------------------------
				 END - FullCalendar 
				---------------------------------------------------------------------------------*/

				$('#btn-submit').click(function() {
					event.preventDefault();

					var start = getSelectDataParam().event.start;
					var end = getSelectDataParam().event.end;

					var len = end.diff(start, "days");
					var scheduleList = [];

					for (var i = 0; i < len; i++) {

						if (i != 0) start.add(1, 'days');

						scheduleList.push({
							schNo : 0,
							schStart : $('#schStart').val(),
							schEnd : $('#schEnd').val(),
							schDate : start.format('YYYY-MM-DD'),
							schType : $('#schType').val()
						});

					}

					/* var event = {
						title : "New event",
						start : getSelectDataParam().start.format('YYYY-MM-DD') + 'T' + '17:00',
						end : getSelectDataParam().end.subtract(1, 'days').format('YYYY-MM-DD') + 'T' + '19:00',
						allDay : false
					};

					$calendar.fullCalendar("renderEvent", event, true);
					$calendar.fullCalendar("unselect"); */

					/* 	 
						schNo    INT         NOT NULL, -- 스케줄번호
						schStart VARCHAR(10) NULL,     -- 시작
						schEnd   VARCHAR(10) NULL,     -- 종료
						schDate  DATE        NULL,     -- 상영 날짜
						schType  VARCHAR(10) NULL,     -- 시간대
						refAno   INT         NOT NULL, -- 상영관번호
						refScrno INT         NOT NULL  -- 스크린번호
					 */

					$.ajax({

						url : '${pageContext.request.contextPath }/admin/schedule/write',
						type : 'POST',
						contentType : "application/json; charset=utf-8",
						data : JSON.stringify({

							scheduleList : scheduleList,
							aNo : $('#refAno').val(),
							scrNo : $('#refScrno').val()

						}),
						success : function(data) {
							console.log('result', data);
							$('#refAno').change();

						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log('Error ', 'error : ' + textStatus, 'ok');
						}
					});

					$('#myModal').modal('hide');
				})
			});

			$(document).on('change', '#refAno', function() {
				console.log('change', $(this).val())

				//$calendar.fullCalendar('refresh');
				//$calendar.fullCalendar('rerenderEvents');
				$calendar.fullCalendar('rerenderEvents');
				$calendar.fullCalendar('refetchEvents');
				console.log('refresh pass')
				//상영관 설정 되지 않았으면 달력 클릭도 못하게 막는다.
				//여기서 달력 데이터 ajax로 불러오기 
			})
		</script>


		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<form method="post" autocomplete="off" id="form1">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Modal Header</h4>
						</div>
						<div class="modal-body">

							<!--
								schNo    INT         NOT NULL, -- 스케줄번호
								schStart VARCHAR(10) NULL,     -- 시작
								schEnd   VARCHAR(10) NULL,     -- 종료
								schDate  DATE        NULL,     -- 상영 날짜
								schType  VARCHAR(10) NULL,     -- 시간대
								refAno   INT         NOT NULL, -- 상영관번호
								refScrno INT         NOT NULL  -- 스크린번호
							-->




							<div class="form-group ">
								<label for="mNm">스크린 검색</label>
								<!-- <select class="form-control"></select> -->
								<select id="select-screenlist" class="select-screenlist form-control" style="width: 100%"></select>

								<!-- 스크린 scrNo -->
								<input type="hidden" name="refScrno" id="refScrno" value="0" />
							</div>

							<div class="form-group ">
								<label for="">타입</label>
								<select class="form-control" name="schType" id="schType">
									<option>--</option>
									<option>조조</option>
									<option>일반</option>
									<option>심야</option>
								</select>
							</div>
							<div class="form-group ">
								<label for="">시작 시간</label>
								<input type="text" name="schStart" id="schStart" class="form-control mask-time" />
							</div>
							<div class="form-group ">
								<label for="">종료 시간</label>
								<input type="text" name="schEnd" id="schEnd" class="form-control mask-time" />
							</div>

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" id="btn-submit">저장하기</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</form>
			</div>


		</div>


		<div class="row">
			<div class="col-xs-12">

				<div class="panel panel-default">


					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="fa fa-long-arrow-right fa-fw"></i> 영화 이미지
						</h3>
					</div>

					<form id="iForm1" enctype="multipart/form-data">

						<div class="panel-body  my-panel-body">

							<div class="row">
								<div class="col-xs-6 col-sm-offset-1">
									<div class="form-group ">
										<label>영화관(지점) 설정</label>
										<select class="js-data-example-ajax form-control" id="theater"></select>
									</div>
									<div class="form-group ">
										<label for="refAno">상영관 설정</label>
										<select name="refAno" id="refAno" class="form-control">
											<option value="" selected style="display: none">지점을 먼저 선택해주세요.</option>
										</select>
									</div>

								</div>

							</div>


						</div>

						<div class="panel-footer"></div>

					</form>


				</div>


			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">

				<div class="panel panel-default">

					<div class="panel-heading form-inline">
						<div class="form-group">
							<h3 class="panel-title">
								<i class="fa fa-long-arrow-right fa-fw"></i> 영화 정보 검색 도움
							</h3>
						</div>
					</div>

					<form name="mForm1" autocomplete="off" id="mForm1" method="post" onsubmit="return false;">

						<div class="panel-body ">

							<div id='calendar' style="width: 700px"></div>
						</div>
					</form>




				</div>

			</div>


		</div>




		<!-- --------------------------------- START OF LEFT COLUM-------------------------------------------- -->


		<!-- --------------------------------- END OF LEFT COLUM-------------------------------------------- -->




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