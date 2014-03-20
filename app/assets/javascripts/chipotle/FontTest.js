var FontsTest = function () {
	"use strict";
	var shared = {};

	shared.updateDescription = function () {
		$('#fonts-description').val(
			'font-family:\'' + $('#fonts-family').val() + '\';'
			+ ' font-weight:' + $('#fonts-weight').val() + ';'
			+ ' font-size:' + $('#fonts-size').val() + 'px;'
			+ ' font-style:' + $('#fonts-style').val() + ';'
			+ ' letter-spacing:' + $('#fonts-space').val() + 'px;'
			+ ' line-height:' + $('#fonts-line').val() + '%;'
		);
	};

	$(window.document).ready(function () {
		var families = ['Arial', 'Arial Black', 'Book Antiqua', 'Comic Sans MS', 'Courier New', 'Cursive', 'Georgia', 'Helvetica', 'Impact', 'Lucida Console', 'Lucida Sans Unicode', 'Monospace', 'Palatino Linotype', 'sans-serif', 'Tahoma', 'Times New Roman', 'Trebuchet MS', 'Verdana'];
		families = families.concat(['Francois One']);
		var styles = ['normal', 'italic', 'oblique'];
		var stretch = ['normal', 'condensed', 'ultra-condensed', 'extra-condensed', 'semi-condensed', 'expanded', 'semi-expanded', 'extra-expanded', 'ultra-expanded'];
		var table = '<div id="fonts-test"><table>';
		table += '<tr><td>font</td><td>weight</td><td>size</td><td>style</td><td>char space px</td><td>line space %</td><td>stretch</td></tr>';
		table += '<tr><td><select id="fonts-family"><option value=""></option></select></td><td><select id="fonts-weight"><option value=""></option></select></td><td><input type="text" id="fonts-size" class="fonts-number" /></td><td><select id="fonts-style"><option value=""></option></select></td><td><input type="text" id="fonts-space" class="fonts-number" /></td><td><input type="text" id="fonts-line" class="fonts-number" /></td><td><select id="fonts-stretch"><option value=""></option></select></td></tr>';
		table += '<tr><td colspan="6"><input type="text" id="fonts-description"></td></tr>';
		table += '</table></div>';

		$('body').append(table);
		styles = styles.splice(0, 2);

		//load selectors
		$.each(families, function (index, value) {	//ignore jslint unsued index
			$('#fonts-family').append('<option value="' + value + '">' + value + '</option>');
		});
		for (var w = 100; w <= 900; w += 100) {		//ignore jslint move var
			$('#fonts-weight').append('<option value="' + w + '">' + w + '</option>');
		}
		$.each(styles, function (index, value) {	//ignore jslint unsued index
			$('#fonts-style').append('<option value="' + value + '">' + value + '</option>');
		});
		$.each(stretch, function (index, value) {	//ignore jslint unsued index
			$('#fonts-stretch').append('<option value="' + value + '">' + value + '</option>');
		});

		//update events
		$('#fonts-family').change(function () {
			$('#fonts-family option:selected').each(function (index, value) {
				$('*').css('font-family', $(this).val());
			});
			shared.updateDescription();
		});
		$('#fonts-weight').change(function () {
			$('#fonts-weight option:selected').each(function (index, value) {
				$('*').css('font-weight', $(this).val());
			});
			shared.updateDescription();
		});
		$('#fonts-size').keyup(function () {
			$('*').css('font-size', $(this).val() + 'px');
			shared.updateDescription();
		});
		$('#fonts-style').change(function () {
			$('#fonts-style option:selected').each(function (index, value) {
				$('*').css('font-style', $(this).val());
			});
			shared.updateDescription();
		});
		$('#fonts-stretch').change(function () {
			$('#fonts-stretch option:selected').each(function (index, value) {
				$('*').css('font-stretch', $(this).val());
			});
			shared.updateDescription();
		});
		$('#fonts-space').keyup(function () {
			$('*').css('letter-spacing', $(this).val() + 'px');
			shared.updateDescription();
		});
		$('#fonts-line').keyup(function () {
			$('*').css('line-height', $(this).val() + '%');
			shared.updateDescription();
		});
	});

	return shared;
};
var fontsTest = new FontsTest();