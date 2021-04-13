require "sinatra/base"
require "./message"
class MensajeroSms < Sinatra::Base
    configure :development do
        require "dotenv/load"
    end

    # get "/" do
    #     puts "Hola Mundo"
    # end
  
    # POST /messages es la ruta que envía un mensaje sms
    # Params: { sent_by, sent_to, body}
    post "/crear_mensajes" do
        message = Message.new( params["sent_by"], params["sent_to"], params["body"] )
        puts message.sent_by
        puts message.sent_to
        puts message.body

        if message.save
           puts "Mensaje enviado y almacenado en CSV"
        else
           puts "Ocurrió un error"
        end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end