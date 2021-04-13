class Message
    attr_accessor :sent_by, :sent_to, :body, :length, :created_at
  
    def initialize(sent_by, sent_to, body)
      @sent_by = sent_by
      @sent_to = sent_to
      @body    = body
      @length  = body.size
      @created_at = Time.now
    end
  
    def send_sms_with_twilio
      begin
        require "twilio-ruby"
        account_sid = ENV["TWILIO_ACCOUNT_ID"]
        auth_token  = ENV["TWILIO_AUTH_TOKEN"]
        client = Twilio::REST::Client.new(account_sid, auth_token)
        client.messages.create(from: ENV["TWILIO_PHONE_NUMBER"], to: @sent_to, body: @body)
        return true
      rescue StandardError => error
        puts "Rescued: #{error}"
        return false
      end
    end
  
    def save_record_into_csv
      begin
        csv = File.open("db/messages.csv", "a")
        csv.puts "#{@sent_by}, #{@sent_to}, #{@body}, #{@length}, #{@created_at}"
        csv.close
        return true
      rescue StandardError => error
        puts "Rescued: #{error}"
        return false
      end
    end
  
    def save
      send_sms_with_twilio && save_record_into_csv
    end
  end