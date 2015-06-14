$(document).ready(function(){
	$('.ajax-role a').click(function(){
		var href = this.href;
		$.ajax({
		  url: href,
		}).done(function(data) {
			modal = $('#roles-modal');
			modal.modal('show');
			var rList = $('#roles-modal ul.roles');
			var cList = $('#roles-modal ul.circles');
			cList.html('');
			rList.html('');
			modal.find('.modal-title').html(data['title']);
			modal.find('.main-circle').html(data['circle']+'&nbsp;&nbsp;');
			modal.find('a.roles-full').attr("href", href);
			$.each(data['roles'], function(i)
			{
				var li = $('<li/>')
			        .addClass('role')
			        .appendTo(rList);
			    var name = $('<h3/>')
			    	.addClass('role-title')
			        .text(data['roles'][i]['name']+'('+data['roles'][i]['circle']+')')
			        .appendTo(li);
			    var description = $('<p/>')
			        .text(data['roles'][i]['description'])
			        .appendTo(li);
			});
			$.each(data['circles'], function(i)
			{
				var li = $('<li/>')
			        .addClass('circle-item')
			        .appendTo(cList);
			    var name = $('<h3/>')
			    	.addClass('circle-title')
			        .text(data['circles'][i])
			        .appendTo(li);
			});
		});
		return false;
	});
});