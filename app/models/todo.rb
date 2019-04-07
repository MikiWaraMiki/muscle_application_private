require 'date'
class Todo < ApplicationRecord
    belongs_to :user, optional: true
    validates :title,
        presence: true,
        length: {minimum:1, maximum:100, message:"文字数は1~100に納めてください"}
    validates :set_count,
        presence:{message: "セット数を入力してください"},
        numericality: {greater_than: 0 }
    validates :weight,
        presence:true,
        numericality: {greater_than: 0}
    validates :clear_plan,
        presence: true
    validate :date_valid?

    def gruopby_count_by_title
        todo_complete = self.find_by(cleared: true)
        todo_complete.group('todos.title').count
    end

    private
    def date_valid?
        now = Time.now.in_time_zone
        errors.add(:clear_plan, "過去の日付が入力されています") if clear_plan < now
    end

end
