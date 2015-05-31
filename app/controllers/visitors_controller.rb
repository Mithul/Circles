class VisitorsController < ApplicationController
	include ApplicationHelper

	def index
		@impress_enable=true
		@max_depth = 1
		depth = 0
		ctf = Circle.find_by_name('CTF')
		circles = ctf.circles
		num = ctf.circles.count
		diff = 360/num
		i = 0
		@dfs=[]
		@depth_cirlces={}
		@circles=[]
		calc_points(ctf,[0,0,1],depth+1)
		@depth_cirlces.each do |d,c|
			puts d
			@max_depth = d
			@circles = @circles + c
		end
		@circles=@dfs
		# circles.each_with_index do |c,i| 
		# 	size = 0
		# 	size = ctf.circles[i].circles.count if ctf.circles[i]
		# 	point=[0,500,size+1]
		# 	rotate(point,diff*i)
		# 	circle = {circle: c,point: point ,depth: depth}
		# 	calc_points(c,point,depth+1)
		# 	@circles.append(circle)
		# end
		puts '*'*100
		puts @max_depth
	end

	def upload
	end

	def parser
		require 'csv'
		csv_text = File.read(params[:members][:file].tempfile)
		csv = CSV.parse(csv_text, :headers => true)
		members = []
		ctf = Circle.find_by_name('CTF')
		if !ctf
			ctf = Circle.new
			ctf.name = 'CTF'
			ctf.save
		end
		csv.each do |row|
			circle = Circle.find_by_name(row["TEAM"])
			if !circle
				circle = Circle.new
				circle.name = row["TEAM"]
			end
			circle.save
			ctf.circles << circle
			member = Member.find_by_name(row["NAME"])
			if !member
				member = Member.new
				member.name = row["NAME"]
			end
			if !member.circles.include? circle
				member.circles << circle
			end
			member.save
		  # members << member
		end
		ctf.save
		render :text => members.to_json
	end

	private
	def calc_points(circle,centre,depth)
		circles = circle.circles
		members = circle.members
		num = circles.count + members.count
		radius=1000 + num*700
		if num!=0
			@max_depth=depth
			diff = 360/num
			cc = @depth_cirlces[depth]
			if cc == nil
				@depth_cirlces[depth]=[]
				cc = @depth_cirlces[depth]
			end
			i=0
			circles.each do |c| 
				point=[0,radius/depth]
				rotate(point,diff*i)
				# puts point.to_json
				point[0]=point[0]+centre[0]
				point[1]=point[1]+centre[1]
				circle = {unit: c,point: point, depth: depth, type: 'circle'}
				i=i+1
				@dfs.append(circle)
				cc.append(circle)
				calc_points(c,point,depth+1)
			end
			members.each do |m|
				point=[0,radius/depth]
				rotate(point,diff*i)
				# puts point.to_json
				point[0]=point[0]+centre[0]
				point[1]=point[1]+centre[1]
				circle = {unit: m,point: point, depth: depth, type: 'member'}
				# calc_points(c,point,depth+1)
				@dfs.append(circle)
				cc.append(circle)
				puts circle
				puts '*'*100
				i=i+1
			end
			if members.count != 0
				@max_depth = depth+1
			end
			@depth_cirlces[depth]=cc
			# puts @depth_cirlces.to_json
		end
	end


end
