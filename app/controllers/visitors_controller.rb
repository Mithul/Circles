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
		@depth_cirlces={}
		@circles=[]
		calc_points(ctf,[0,0,1],depth+1)
		@depth_cirlces.each do |d,c|
			puts c.to_json
			@circles = @circles + c
		end
		# circles.each_with_index do |c,i| 
		# 	size = 0
		# 	size = ctf.circles[i].circles.count if ctf.circles[i]
		# 	point=[0,500,size+1]
		# 	rotate(point,diff*i)
		# 	circle = {circle: c,point: point ,depth: depth}
		# 	calc_points(c,point,depth+1)
		# 	@circles.append(circle)
		# end
	end


	private
	def calc_points(circle,centre,depth)
		circles = circle.circles
		members = circle.members
		num = circles.count + members.count
		radius=800
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
				calc_points(c,point,depth+1)
				cc.append(circle)
				i=i+1
				# @circles.append(circle)
			end
			members.each do |m|
				point=[0,radius/depth]
				rotate(point,diff*i)
				# puts point.to_json
				point[0]=point[0]+centre[0]
				point[1]=point[1]+centre[1]
				circle = {unit: m,point: point, depth: depth, type: 'member'}
				# calc_points(c,point,depth+1)
				cc.append(circle)
				i=i+1
			end

			@depth_cirlces[depth]=cc
			puts @depth_cirlces.to_json
		end
	end


end
