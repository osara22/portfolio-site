class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail(to: ENV['SMTP_USERNAME'], from: @contact.email, subject: '【お問い合わせ】')
  end
end
