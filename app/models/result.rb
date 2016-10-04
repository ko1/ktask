class Result < ApplicationRecord
  belongs_to :task

  def self.register task
    Result.create(task: task)
  end

  def _status
    status = case
    when t = self.completed_at
      'completed'
    when t = self.invoked_at
      'invoked'
    else
      t = self.created_at
      'queued'
    end
    [status, t]
  end

  def status
    _status[0]
  end

  def status_with_time
    st = _status
    "#{st[0]} at #{st[1]}"
  end
end
