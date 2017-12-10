
require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post('/sessions', body: { email: email, password: password })

    @auth = response['auth_token']
    if @auth == nil
      puts 'Invalid Credentials'
    else
      puts 'Welcome'
    end

  end

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_messages(page = nil)
    if page == nil
      response = self.class.get("/message_threads", headers: { "authorization" => @auth })
    else 
      response = self.class.get("/message_threads", headers: { "authorization" => @auth })
    end

    JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, message)
    response = self.class.post("/messages", body: { "recipient_id": recipient_id, "subject": subject, "stripped-text": message}, headers: { "authorization" => @auth})
  end



end