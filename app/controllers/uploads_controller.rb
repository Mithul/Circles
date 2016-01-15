class UploadsController < ApplicationController
	def list
		@uploads = Upload.all
		if request.xhr?
	      render :json => @uploads.map{|u| {id: u.id,name: u.name,user: u.user.member.name, url: u.file.url}}
	    end
	end

	def delete
		@upload = Upload.find(params[:id])
		if current_user and (current_user.admin? or current_user == @upload.user) and @upload.reports.length==0
			@upload.destroy
			render text: 'Done'
		else
			return head(:forbidden)
		end
	end
end
