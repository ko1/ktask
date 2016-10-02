require 'test_helper'

class ApisControllerTest < ActionDispatch::IntegrationTest
  def deq
    get api_deq_url(:json, worker: wid = "worker-#{Time.now.to_s}")
    work = JSON.parse(@response.body)
    result = Result.find(rid = work.dig('work', 'result_id'))
    assert_equal result.worker, wid
    rid
  end

  def complete rid
    result = {
      summary: sum = "summary of #{rid}",
      result: res = "result of #{rid}",
    }
    get api_complete_url(rid, :json, json: result.to_json)
    result = Result.find(rid)
    assert_equal sum, result.summary
    assert_equal res, result.result
    assert_match /completed/, result.status
  end

  test 'should controll work queue' do
    rids = [deq, deq, deq]
    rids.each{|rid|
      complete rid
    }
  end
end
