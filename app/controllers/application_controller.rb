class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def hello
    render html: "hello, world"
  end
  
  def my_name
    render html: "Kent Spence"
  end
end
