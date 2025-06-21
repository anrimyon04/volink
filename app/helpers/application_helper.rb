module ApplicationHelper
    def logged_in?
        user_signed_in? # Deviseのヘルパーを呼び出す
    end
end
