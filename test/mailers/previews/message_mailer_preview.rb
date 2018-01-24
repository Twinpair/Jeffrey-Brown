# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/message_mailer/send_message
  def send_message
    message = Message.first
    MessageMailer.send_message(message)
  end

end
