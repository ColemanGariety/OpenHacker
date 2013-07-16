module ApplicationHelper
	def your_entry
	  @your_entry = Entry.find_by_challenge_id_and_user_id(current_open_challenge.id, current_user.id)
	end
end
