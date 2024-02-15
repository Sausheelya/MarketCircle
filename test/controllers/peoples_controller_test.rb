# test/controllers/peoples_controller_test.rb

require "test_helper"

class PeoplesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get people_url
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference("Person.count") do
      post people_url, params: { person: { name: "John", detail_attributes: { email: "john@example.com" } } }
    end

    assert_redirected_to people_url
  end

  test "should show person" do
    person = people(:one)
    get person_url(person)
    assert_response :success
  end

  test "should get edit" do
    person = people(:one)
    get edit_person_url(person)
    assert_response :success
  end

  test "should update person" do
    person = people(:one)
    patch person_url(person), params: { person: { name: "Updated Name" } }
    assert_redirected_to people_url
  end

  test "should destroy person" do
    person = people(:one)
    assert_difference("Person.count", -1) do
      delete person_url(person)
    end

    assert_redirected_to people_url
  end

  test "should destroy associated detail when person is destroyed" do
    person = people(:one)
    assert_difference("Detail.count", -1) do
      delete person_url(person)
    end

    assert_redirected_to people_url
  end

  

  test "should render JSON on custom destroy" do
    person = people(:one)
    delete custom_destroy_person_url(person, format: :json)
    assert_response :success
    assert_equal "application/json", @response.media_type
  end
end
