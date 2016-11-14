class AddVolunteerReviewedToRequestPostJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :request_post_jobs, :volunteer_reviewed, :boolean
  end
end
