class PagesController < ApplicationController
  def home
    @task = Task.new if signed_in?
    @priorities = [['high', 3],['medium', 2],['low', 1]]
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
