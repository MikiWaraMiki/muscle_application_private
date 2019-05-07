class Users::Mailer < Device::Mailer
    def confirmation_instructions
        super
    end
    
    def reset_password_instructions
        super
    end
    
    def unlock_instructions
        super
    end
end