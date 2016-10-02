class ApisController < ApplicationController
  def deq
    begin
      worker = params['worker']
      result = Result.where(invoked_at: nil).order(:id).first
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
    update_params = JSON.parse(params[:json])

    if result
      raise "already completed" if result.completed_at
      result.summary = update_params['summary']
      result.result = update_params['result']
      result.completed_at = Time.now
      result.save!
      @status = 'ok'
    else
      raise 'not found'
    end
  rescue => e
    @status = e.to_s
  else
    @status = 'OK'
  end
end
