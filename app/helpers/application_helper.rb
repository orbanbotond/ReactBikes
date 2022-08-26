# frozen_string_literal: true

module ApplicationHelper
	def nav_link_class(resource)
		classs = ["nav-link"]
		classs << "active" if request.path.include?(resource)
		classs.join(" ")
	end

	def rater_tag(rate, max=5)
		rate = rate || 0
		content_tag(:div, class: 'react-rater') do
		  value = []
		  rate.times do
		   value << content_tag(:div, content_tag(:div, "*", class: 'react-rater-star is-disabled is-active'))
		  end
		 (5-rate).times do
		   value << content_tag(:div, content_tag(:div, "", class: 'react-rater-star is-disabled'))
		  end
		  value.join.html_safe
		end
	end
end
