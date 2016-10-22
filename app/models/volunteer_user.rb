class VolunteerUser < BasicUser
    store_accessor :sti_store, :zip_code, :points, :rev_count, :no_search
end
