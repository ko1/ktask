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
    "#{st[0]} at #{time_rep(Integer(Time.now - st[1]))} ago"
  end

  def worker_signature
    if /\A(.+?)-/ =~ w = self.worker
      $1
    else
      w
    end
  end

  def status_with_length
    s, t = _status
    if s == 'completed'
      "#{s} (#{time_rep Integer(t - self.invoked_at)})"
    else
      s
    end 
  end

  def time_rep sec
    case 
    when sec > 60 * 60
      h = sec / (60 * 60)
      m = (sec % (60 * 60)) / 60
      s = sec % 60
      "#{h}h#{m}m#{s}s"
    when sec > 60
      m = sec / 60
      s = sec % 60
      "#{m}m#{s}s"
    else
      "#{sec}s"
    end
  end
end
