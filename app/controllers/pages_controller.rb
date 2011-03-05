class PagesController < ApplicationController
  def home
    @task = Task.new if signed_in?
    @users = []
    User.all.each do |u|
      @users << [u.name, u.id]
    end
    @users.empty? ? @default = '' : @default = @users[0][1]
  end

  def contact
  end

  def about
  end

end
