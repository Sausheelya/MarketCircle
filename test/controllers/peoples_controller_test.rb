require 'test_helper'

class PeoplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one) # Use the fixture or create a new person for testing
  end

  test 'should get index' do
    get peoples_url
    assert_response :success
  end

  test 'should show person with details' do
    get people_url(@person)
    assert_response :success
    assert_equal JSON.parse(response.body)['id'], @person.id
    assert_not_nil JSON.parse(response.body)['detail']
  end

  test 'should create person with details' do
    assert_difference(['Person.count', 'Detail.count']) do
      post peoples_url, params: {
        person: { name: 'John Doe' },
        detail: { email: 'test@example.com', title: 'Dr.', age: 30, phone: '123-456-7890' }
      }
    end

    assert_response :created
  end
end
