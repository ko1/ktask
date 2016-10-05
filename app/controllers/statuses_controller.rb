class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.json
  def index
    @tasks = Task.all
    @results = Result.all
  end
end
