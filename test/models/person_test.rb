# test/models/person_test.rb
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup do
    @person = people(:one)
  end

  test 'should not save person without name' do
    person = Person.new
    assert_not person.save, 'Saved the person without a name'
  end

  test 'should create person with valid attributes' do
    person = Person.new(name: 'John Doe')
    assert person.save, 'Could not save the person with valid attributes'
  end

  test 'should destroy associated detail when person is destroyed' do
    detail = Detail.new(email: 'test@example.com', title: 'Dr.', age: 30, phone: '123-456-7890', person: @person)
    detail.save

    assert_difference('Detail.count', -1) do
      @person.reload.destroy
    end
  end
end
