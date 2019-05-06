class ApplicationController < ActionController::Base
  def hello
    render html: "¡hola, mundo!"
  end
end
