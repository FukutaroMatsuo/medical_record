require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @record = records(:one)
  end

  test "should get index" do
    get records_url, as: :json
    assert_response :success
  end

  test "should create record" do
    assert_difference('Record.count') do
      post records_url, params: { record: { assessment: @record.assessment, day: @record.day, objective: @record.objective, patient_id: @record.patient_id, plan: @record.plan, subjective: @record.subjective, user_id: @record.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show record" do
    get record_url(@record), as: :json
    assert_response :success
  end

  test "should update record" do
    patch record_url(@record), params: { record: { assessment: @record.assessment, day: @record.day, objective: @record.objective, patient_id: @record.patient_id, plan: @record.plan, subjective: @record.subjective, user_id: @record.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy record" do
    assert_difference('Record.count', -1) do
      delete record_url(@record), as: :json
    end

    assert_response 204
  end
end
