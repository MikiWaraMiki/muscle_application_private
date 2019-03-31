class User < ApplicationRecord
    before_save { self.email = email.downcase} 
    validates :name, presence: {message:"は必須入力項目です"}, 
        length: {maximum: 17, message:"%{value}は17文字以下で入力してください",allow_blank: true}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: {message:"は必須入力項目です"}, 
        length: {maximum: 100,message:"%{value}は100文字以下で入力してください",allow_blank: true}, 
        uniqueness: {case_sensitive: false, message:"%{value}はすでに登録済みです", allow_blank: true}, 
        format: { with: VALID_EMAIL_REGEX, message:"メールアドレスの形式が不正です", allow_blank: true }
    #password
    has_secure_password
    validates  :password, presence:true, length:{minimum: 8,allow_nil: true}
end
