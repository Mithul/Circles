module ApplicationHelper

	def rotate(point,angle)
		angle = -angle * Math::PI/ 180
		point1=[]
		# puts Math.cos(angle)
		# puts Math.sin(angle)
		point1[0]=point[0]*Math.cos(angle) - point[1]*Math.sin(angle)
		point1[1]=point[0]*Math.sin(angle) + point[1]*Math.cos(angle)
		point[0] = point1[0].to_i
		point[1] = point1[1].to_i
	end

end
