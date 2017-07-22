/**
 */
var ebox = {

	getFormData : function(form) {
		return form.serialize();
	},
	/*
	 * initData : function(fnc, param) { fnc(param.url, param); },
	 */

	// function initData() {
	// theater_gnb_param.page = 1;
	//
	// ebox.loadList({
	// url : mUrl.THEATER_LIST,
	// param : theater_gnb_param,
	// tableBox : $('#theater-table-body'),
	// template : $('#theater-list'),
	// pagingBox : $('#theater-list-pagination')
	// });
	// }
	// 사용 방법 위에 참고.
	loadList : function(obj) {
		// 페이지랑 키워드
		var ajaxGet = $.get(obj.url, obj.param, function(data) {
			console.log(data);

			ebox.setTemplate(obj.tableBox, obj.template, data.list);
			ebox.printPaging(data.pageMaker, obj.pagingBox);

			// 페이지에 항목이면 param.page-1로 재귀함수 호출
			if (obj.param != null) {
				if (obj.param.page != 1 && data.list.length == 0) {
					obj.param.page--
					ebox.loadList(obj);
				}
			}

		});

		// console.log(obj.url + '/' + obj.param.page)
	},

	printPaging : function(pageMaker, pagingBox) {
		pagingBox.empty();

		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {

			var $a = $('<a></a>');
			$a.attr('href', i);
			$a.text(i);

			var $li = $('<li></li>');
			$li.append($a);

			if (pageMaker.cri.page == i) $li.addClass('active');
			pagingBox.append($li);
		}

		if (pageMaker.prev) {
			var $a = $('<a></a>');
			$a.attr('href', pageMaker.startPage - 1);
			$a.append('<i class="fa fa-caret-left" aria-hidden="true"></i>');

			var $li = $('<li></li>');
			$li.append($a);
			pagingBox.prepend($li);
		}

		if (pageMaker.next) {
			var $a = $('<a></a>');
			$a.attr('href', pageMaker.endPage + 1);
			$a.append('<i class="fa fa-caret-right" aria-hidden="true"></i>');

			var $li = $('<li></li>');
			$li.append($a);
			pagingBox.append($li);
		}
	},

	// Example
	// setTemplate($('.theater-right ul'), $("#theater-template"), theaterList);

	// setting template
	setTemplate : function(box, template, data) {
		box.empty();

		// 핸들바 템플릿 가져오기
		var source = template.html();

		// 핸들바 템플릿 컴파일
		var template = Handlebars.compile(source);

		// 핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
		var html = template(data);

		// 생성된 HTML을 DOM에 주입
		box.append(html);
	},

	// setting template
	setItemTemplate : function(box, template, data) {

		// 핸들바 템플릿 가져오기
		var source = template.html();

		// 핸들바 템플릿 컴파일
		var template = Handlebars.compile(source);

		// 핸들바 템플릿에 데이터를 바인딩해서 HTML 생성
		var html = template(data);

		// 생성된 HTML을 DOM에 주입
		box.append(html);
	},

	checkInputVal : function(input) {
		if (input.val().length == 0) {

			input.parent().find('p').css('visibility', 'visible');
			input.focus();
			return false;

		} else {

			input.parent().find('p').css('visibility', 'hidden');
			return true;
		}
	},

	setAutoComplete : function($target, tempVal, ajaxFunc) {

		$target.autocomplete({
			minLength : 2,
			delay : 500,
			autoFocus : true,

			focus : function(event, ui) {
				return false;
			},

			select : function(event, ui) {
				console.log(ui.item)
				tempVal = ui.item.value;
			},

			source : function(req, res) {
				if (tempVal == req.term) {
					tempVal = '';
					return;
				}

				ajaxFunc(req, res);
			},// source

		});
	},

	isValid : function(data) {

		if (typeof data == 'undefined' || data == '' || data == null) {
			console.log('DATA', 'Not Valid')
			return false;
		} else {
			console.log('DATA', 'Valid')
			return true;
		}
	},

	setMutiSelectLimit : function(target) {
		var len = $(target).children(":selected").length;
		if (len > 1) {
			$(target).children(":selected").not(':first').prop('selected', false);
		}
	},

	setHelpTextForInput_Text : function($target) {

		$target.parent().find('.help-txt').hide();

		//
		if (!ebox.isValid($target.val())) {
			$target.parent().find('.help-txt').show();
			return false;

		} else {
			return true;
		}

	},

	setHelpTextForInput_TextForVisibility : function($target) {

		$target.focus();
		$target.parent().find('.help-block').css('visibility', 'hidden');

		//
		if (!ebox.isValid($target.val())) {
			$target.parent().find('.help-block').css('visibility', 'visible');
			return false;

		} else {
			return true;
		}

	},

	setHelpTextForInput_CheckBoxForVisibility : function($target) {

		$target.parent().find('.help-block').css('visibility', 'hidden');

		//
		if ($target.find(':selected').length <= 0) {
			$target.parent().find('.help-block').css('visibility', 'visible');
			return false;

		} else {
			return true;
		}
	},
	setHelpTextForInput_RadioForVisibility : function($target) {

		$target.parent().find('.help-block').css('visibility', 'hidden');

		//
		if ($target.find(':checked').length <= 0) {
			$target.parent().find('.help-block').css('visibility', 'visible');
			return false;

		} else {
			return true;
		}
	},
	setHelpTextForInput_Radio : function($target) {

		$target.parent().find('.help-txt').hide();

		//
		if ($target.find(':checked').length <= 0) {
			$target.parent().find('.help-txt').show();
			return false;

		} else {
			return true;
		}
	},

	makeQuery : function(param) {

		var Q_page, Q_perPageNum, Q_keyword, Q_searchType;
		var QUERY = '';

		if (ebox.isValid(param.page)) {
			if (typeof param.page == 'string') {
				Q_page = "page=" + param.page.trim() + '&';
			} else {
				Q_page = "page=" + param.page + '&';
			}

			QUERY += Q_page;
		}
		if (ebox.isValid(param.perPageNum)) {
			if (typeof param.perPageNum == 'string') {
				Q_perPageNum = "perPageNum=" + param.perPageNum.trim() + '&';
			} else {
				Q_perPageNum = "perPageNum=" + param.perPageNum + '&';
			}
			QUERY += Q_perPageNum;
		}

		if (ebox.isValid(param.keyword)) {
			if (typeof param.keyword == 'string') {
				Q_keyword = "keyword=" + param.keyword.trim() + '&';
			} else {
				Q_keyword = "keyword=" + param.keyword + '&';
			}
			QUERY += Q_keyword;
		}
		if (ebox.isValid(param.searchType)) {
			if (typeof param.searchType == 'string') {
				Q_searchType = "searchType=" + param.searchType.trim() + '&';
			} else {
				Q_searchType = "searchType=" + param.searchType + '&';
			}
			QUERY += Q_searchType;
		}

		var lastChar = QUERY.charAt(QUERY.length - 1);
		if (lastChar == '&') {
			QUERY = QUERY.slice(0, -1);
		}

		return '?' + QUERY;
	},

	getFileSizeFormat : function(file) {
		var size = Number(file.size);

		var _1GB = 1024 * 1024 * 1024;
		var _1MB = 1024 * 1024;
		var _1KB = 1024;

		var result = '';

		if (size >= _1GB) {
			result = (size / _1GB).toFixed(2) + ' GB';

		} else if (size >= _1MB) {
			result = (size / _1MB).toFixed(2) + ' MB';

		} else if (size >= _1KB) {
			result = (size / _1KB).toFixed(2) + ' KB';

		} else {
			result = size + ' Bytes';

		}

		return result;
	},

	setImagePreview : function($target, file) {
		var reader = new FileReader();

		reader.readAsDataURL(file);
		reader.onload = function(e) {
			$target.attr('src', e.target.result);
		}
		return $target;
	}

}