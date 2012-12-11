module ApplicationHelper

	def markdown(text)
		HTML::Pipeline::MarkdownFilter.new(text).call.html_safe
	end

end
