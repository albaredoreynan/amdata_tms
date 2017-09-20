module ApplicationHelper

	def is_admin?
		if current_user.role_type == "Administrator"
			return true
		end
	end
end
