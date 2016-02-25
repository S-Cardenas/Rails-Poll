class Question < ActiveRecord::Base
  validates :poll_id, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    primary_key: :id,
    foreign_key: :poll_id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :question_id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    hash = Hash.new(0)
    responses.all.each do |response|
      hash[response.answer_choice.text] += 1
    end
    hash
  end

end
