require 'test_helper'

class DetailTest < ActiveSupport::TestCase
  test 'should not save detail without email' do
    detail = Detail.new
    assert_not detail.save, 'Saved the detail without an email'
  end

  test 'should create detail with valid attributes' do
    person = Person.new(name: 'John Doe')
    detail = Detail.new(email: 'test@example.com', title: 'Dr.', age: 30, phone: '123-456-7890', person: person)
    assert detail.save, 'Could not save the detail with valid attributes'
  end
end
