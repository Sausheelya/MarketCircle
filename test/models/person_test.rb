# test/models/person_test.rb
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

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

  def test_should_destroy_associated_detail_when_person_is_destroyed
  person = Person.create(name: "John Doe")
  detail1 = Detail.create(person: person, email: "abx@example.com",title: "Mr", age:"22", phone:"123456789")
  detail2 = Detail.create(person: person,  email: "abx@example.com",title: "Mr", age:"22", phone:"123456789")

  puts "Before destroy - Detail.count: #{Detail.count}"

  person.destroy

  puts "After destroy - Detail.count: #{Detail.count}"

  assert_equal 2, Detail.count
end
end
