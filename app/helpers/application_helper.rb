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

	def wicked_pdf_image_tag_for_public(img, options={})
	    if img[0] == "/"
	      new_image = img.slice(1..-1)
	      image_tag "file://#{Rails.root.join('public', new_image)}", options
	    else
	      image_tag "file://#{Rails.root.join('public', 'images', img)}", options
	    end
	end

end
