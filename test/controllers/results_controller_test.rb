require 'test_helper'

class ResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @result = results(:one)
  end

  test "should get index" do
    get results_url
    assert_response :success
  end

  test "should get new" do
    get new_result_url
    assert_response :success
  end

  test "should create result" do
    assert_difference('Result.count') do
      post results_url, params: { result: {
        result: @result.result,
        summary: @result.summary,
        task_id: @result.task_id,
        invoked_at: @result.invoked_at,
        completed_at: @result.completed_at,
      } }
    end

    assert_redirected_to result_url(Result.last)
  end

  test "should show result" do
    get result_url(@result)
    assert_response :success
  end

  test "should get edit" do
    get edit_result_url(@result)
    assert_response :success
  end

  test "should update result" do
    patch result_url(@result), params: { result: {
      result: @result.result,
      summary: @result.summary,
      task_id: @result.task_id,
      invoked_at: @result.invoked_at,
      completed_at: @result.completed_at,
    } }
    assert_redirected_to result_url(@result)
  end

  test "should destroy result" do
    assert_difference('Result.count', -1) do
      delete result_url(@result)
    end

    assert_redirected_to results_url
  end

  def register name
    post register_task_url(tasks(name), :json)
    registered_result_id = JSON.parse(@response.body)["registered_result"]
  end

  def deq expected
    post deq_results_url(:json, params: {worker: w="worker-#{Time.now.to_i}"})
    r = JSON.parse(@response.body)
    assert_equal expected, r['work']['name']
    result_id = r['work']["result_id"]
    result = Result.find(result_id)
    assert_equal result.worker, w
    assert_not_nil result.invoked_at
    result_id
  end
  
  test 'should deq and complete' do
    Result.delete_all

    register :one
    register :one
    register :two # repeatable
    rids = %w(one one two two two).map{|e| deq(e)}
    rids.each{|rid|
      post complete_result_url(rid, :json), params: {json: {summary: s="sum#{Time.now.to_i}", result: r="result#{Time.now.to_i}"}.to_json}
      assert_equal 'OK', JSON.parse(@response.body)['status']
      result = Result.find(rid)
      assert_equal s, result.summary
      assert_equal r, result.result
      assert_not_nil result.completed_at
    }
  end

end
