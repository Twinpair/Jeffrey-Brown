class MessageMailer < ApplicationMailer

  def send_message(message)
    @message = message
    mail to: "jeffreytakesyourphoto@gmail.com", subject: "Message received on personal website"
  end

end
