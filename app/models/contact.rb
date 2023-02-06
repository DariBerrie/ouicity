class Contact < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,  captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      subject: "What do you think of our app?",
      to: "hello@dari.codes",
      from: "darigoldman@gmail.com",
      reply_to: %("#{name}" <#{email}>)
    }
  end
end
