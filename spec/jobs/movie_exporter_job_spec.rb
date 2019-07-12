require 'rails_helper'

RSpec.describe MovieExporterJob, type: :job do
  describe ".perform_later" do
    let(:user) { create(:user) }
    let(:file_path) { "tmp/movies.csv" }

    it "enqueues job" do
      ActiveJob::Base.queue_adapter = :test
      expect { MovieExporterJob.perform_later(user, file_path) }.to have_enqueued_job(MovieExporterJob).with(user, file_path)
    end
  end
end
