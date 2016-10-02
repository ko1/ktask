class Result < ApplicationRecord
  belongs_to :task

  def status
    case
    when t = self.completed_at
      "completed at #{t}"
    when t = self.invoked_at
      "executing at #{t}"
    else
      "registered at #{self.created_at}"
    end
  end

  def self.register task
    result = Result.new(task: task)
    result.save!
    result
  end
end
