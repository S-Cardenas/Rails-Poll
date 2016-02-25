class Response < ActiveRecord::Base
  validates :answer_choice_id, presence: true
  validates :respondant_id, presence: true
  validate :not_duplicate_response
  validate :not_rigged

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    primary_key: :id,
    foreign_key: :answer_choice_id
  )

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :respondant_id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  has_one(
    :poll,
    through: :question,
    source: :poll
  )

  private
  def sibling_responses
    question.responses.where.not(id: id)
  end

  def respondant_already_answered?
      sibling_responses.exists?(respondant_id: respondant_id)
  end

  def not_duplicate_response
    if respondant_already_answered?
      errors[:base] << "User already responded"
    end
  end 

  def not_rigged
    if question.poll.author.id == respondant_id #Doing two queries, need to refactor
      errors[:base] << "Cheater!"
    end
  end

end
