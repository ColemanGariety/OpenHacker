module EntriesHelper
	private

  def count_votes(value, id)
  	Vote.where(:value => value, :entry_id => id).count
  end
  
end
