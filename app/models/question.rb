class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  paginates_per 5
=begin
  def self.search(query, page)
    query = "%#{query.downcase}%"
    Question
    .left_joins(:answers, :subject)
    .where(
      "LOWER(questions.description) LIKE :q OR LOWER(answers.description) LIKE :q OR LOWER(subjects.description) LIKE :q",
      q: query
    )
    .distinct
    .includes(:answers, :subject)
    .page(page).per(5)
  end
=end
  scope :_search_, ->(query, page) {
    query = "%#{query.downcase}%"
    Question
    .left_joins(:answers, :subject)
    .where(
      "LOWER(questions.description) LIKE :q OR LOWER(answers.description) LIKE :q OR LOWER(subjects.description) LIKE :q",
      q: query
    )
    .distinct
    .includes(:answers, :subject)
    .page(page).per(5)
  }
end
