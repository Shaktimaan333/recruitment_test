module ApplicationHelper
	def full_title(page_title = "")
		if page_title.empty?
			"Quiz"
		else
			"#{page_title} | Quiz"
		end
	end
end
