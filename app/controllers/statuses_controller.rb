class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.json
  def index
    @tasks = Task.all
    @completed_results = Result.where.not(completed_at: nil)
    @not_completed_results    = Result.where(completed_at: nil)
  end
end
