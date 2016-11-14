class AddRequestReviewedToRequestPostJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :request_post_jobs, :request_reviewed, :boolean
  end
end
