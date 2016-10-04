class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    @results = Result.all
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deq
    begin
      worker = params['worker']
      @result = result = Result.where(invoked_at: nil).order(:id).first
      if result
        Result.transaction do
          @task = result.task
          result.invoked_at = Time.now
          result.worker = worker || 'unknown-worker'
          result.save!

          if @task.repeat
            repeat_result = Result.create(task: @task, memo: 'repeating')
          end
        end
        @result_id = result.id
      else
        @task = Task.new(id: 0, name: 'sleep', script: 'sleep 60', priority: 0, repeat: false)
        @result_id = 0
      end
    rescue => e
      raise
    end
  end

  def complete
    result = Result.find(params[:id])
    json_param = params[:json] || raise('no json parameter specified')
    update_params = JSON.parse(json_param)

    if result
      raise "already completed" if result.completed_at
      result.summary = update_params['summary'] || raise('summary is not specified')
      result.result = update_params['result']   || raise('result is not specified')
      result.completed_at = Time.now
      result.save!
      @status = 'ok'
    else
      raise 'not found'
    end
  rescue => e
    @status = e.to_s
    raise
  else
    @status = 'OK'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:task_id, :summary, :result)
    end
end
