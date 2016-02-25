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
    hash = {}
    self.answer_choices
    .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
    .group(:id)
    .select('answer_choices.*, COUNT(responses.id) AS num_votes')
    .each do |response|
      hash[response.text] = response.num_votes
    end
    hash
  end



  # SELECT
  #   answer_choices.*, COUNT(responses.id) AS num_votes
  # FROM
  #   answer_choices
  # LEFT OUTER JOIN
  #   responses ON responses.answer_choice_id = answer_choices.id
  # GROUP BY
  #   answer_choices.id





  # def results
  #   hash = Hash.new(0)
  #   responses.all.each do |response|
  #     hash[response.answer_choice.text] += 1
  #   end
  #   hash
  # end

end
