# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do
  User.destroy_all
  user1 = User.create!(user_name:'any_old_name')
  user2 = User.create!(user_name:'fred')
  user3 = User.create!(user_name:'sennacy')
  user4 = User.create!(user_name:'paprika')
  Poll.destroy_all
  poll1 = Poll.create!(title:'does it work', author_id:user1.id)

  Question.destroy_all
  q1 = Question.create!(text:'what is it?', poll_id: poll1.id)
  q2 = Question.create!(text:'where is it?', poll_id: poll1.id)
  # answer1 = AnswerChoice.create!(text:"Does it work",)

  AnswerChoice.destroy_all
  a1 = AnswerChoice.create!(text: 'george', question_id: q1.id)
  a2 = AnswerChoice.create!(text: 'mark', question_id: q1.id)

  Response.destroy_all
  r1 = Response.create!(answer_choice_id: a1.id, respondant_id:user2.id)
  r2 = Response.create!(answer_choice_id: a2.id, respondant_id:user3.id)
  r3 = Response.create!(answer_choice_id: a2.id, respondant_id:user4.id)
end
