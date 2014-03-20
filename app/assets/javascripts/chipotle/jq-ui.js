var JqUi = function () {
	"use strict";
	var shared = {};

	$(window.document).ready(function () {
		$('.jump-scroller').click(function (e) {
			var regex = new RegExp('(#[^#]*)$', 'gi');
			var match = regex.exec($(this).prop('href'));
			if (match !== null && $(match[1]).offset() !== undefined) {
				e.preventDefault();
				$('html, body').animate({
					scrollTop: $(match[1]).offset().top
				}, 600);
			}
		});
		$(window).resize(function () {
			window.Cufon.refresh();
		});
	});

	return shared;
};
var jqui = new JqUi();