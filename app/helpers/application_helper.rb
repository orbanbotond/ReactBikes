# frozen_string_literal: true

module ApplicationHelper
	def nav_link_class(resource)
		classs = ["nav-link"]
		classs << "active" if request.path.include?(resource)
		classs.join(" ")
	end

	def toggle_tag(value)
		if value
	    '<div class="react-toggle react-toggle--checked react-toggle--disabled"><div class="react-toggle-track"><div class="react-toggle-track-check"><svg width="14" height="11" viewBox="0 0 14 11"><path d="M11.264 0L5.26 6.004 2.103 2.847 0 4.95l5.26 5.26 8.108-8.107L11.264 0" fill="#fff" fill-rule="evenodd"></path></svg></div><div class="react-toggle-track-x"><svg width="10" height="10" viewBox="0 0 10 10"><path d="M9.9 2.12L7.78 0 4.95 2.828 2.12 0 0 2.12l2.83 2.83L0 7.776 2.123 9.9 4.95 7.07 7.78 9.9 9.9 7.776 7.072 4.95 9.9 2.12" fill="#fff" fill-rule="evenodd"></path></svg></div></div><div class="react-toggle-thumb"></div><input disabled="" class="react-toggle-screenreader-only" type="checkbox" checked=""></div>'.html_safe
	  else
			'<div class="react-toggle react-toggle--disabled"><div class="react-toggle-track"><div class="react-toggle-track-check"><svg width="14" height="11" viewBox="0 0 14 11"><path d="M11.264 0L5.26 6.004 2.103 2.847 0 4.95l5.26 5.26 8.108-8.107L11.264 0" fill="#fff" fill-rule="evenodd"></path></svg></div><div class="react-toggle-track-x"><svg width="10" height="10" viewBox="0 0 10 10"><path d="M9.9 2.12L7.78 0 4.95 2.828 2.12 0 0 2.12l2.83 2.83L0 7.776 2.123 9.9 4.95 7.07 7.78 9.9 9.9 7.776 7.072 4.95 9.9 2.12" fill="#fff" fill-rule="evenodd"></path></svg></div></div><div class="react-toggle-thumb"></div><input disabled="" class="react-toggle-screenreader-only" type="checkbox"></div>'.html_safe
		end
	end

	def rater_tag(rate, max=5)
		rate = rate || 0
		content_tag(:div, class: 'react-rater') do
		  value = []
		  rate.times do
		   value << content_tag(:div, content_tag(:div, "★", class: 'react-rater-star is-disabled is-active'))
		  end
		 (5-rate).times do
		   value << content_tag(:div, content_tag(:div, "★", class: 'react-rater-star is-disabled'))
		  end
		  value.join.html_safe
		end
	end
end
