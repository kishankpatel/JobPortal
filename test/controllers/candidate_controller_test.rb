require 'test_helper'

class CandidateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get candidate_index_url
    assert_response :success
  end

end
