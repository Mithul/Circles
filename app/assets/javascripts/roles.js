$(document).ready(function(){
	$('.ajax-role a').click(function(){
		var href = this.href;
		$.ajax({
		  url: href,
		}).done(function(data) {
			modal = $('#roles-modal');
			modal.modal('show');
			var cList = $('#roles-modal ul.roles');
			cList.html('');
			modal.find('.modal-title').html(data['title']);
			modal.find('a.roles-full').attr("href", href);
			$.each(data['roles'], function(i)
			{
				var li = $('<li/>')
			        .addClass('role')
			        .appendTo(cList);
			    var name = $('<h3/>')
			    	.addClass('role-title')
			        .text(data['roles'][i][0])
			        .appendTo(li);
			    var description = $('<p/>')
			        .text(data['roles'][i][1])
			        .appendTo(li);
			});
		});
		return false;
	});
});