require "sinatra"
require "active_record"
require "gschool_database_connection"
require "rack-flash"
require "./lib/messages_table"
require "./lib/comment_table"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
    @message_table = MessagesTable.new(GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"]))
    @comment_table = CommentsTable.new(GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"]))
  end

  get "/" do
    messages = @message_table.all
    comments = @comment_table.all
    erb :home, locals: {messages: messages,
                        comments: comments

    }
  end

  post "/messages" do
    message = params[:message]
    if message.length <= 140
      @message_table.create(message)
    else
      flash[:error] = "Message must be less than 140 characters."
    end
    redirect "/"
  end

  get "/edit/:id" do
    message = @message_table.find(params[:id])
    p message["id"]
    erb :edit_message, locals: {message: message}
  end

  patch "/edit/:id" do
    @message_table.update(params[:message], params[:id])
    redirect "/"
  end

  delete "/delete/:id" do
    @message_table.delete(params[:id])
    redirect "/"
  end

  get "/comment/:id" do
    message = @message_table.find(params[:id])
    erb :add_comment, locals: {message: message}
  end

  post "/comment/:id" do
    @comment_table.create(params[:comment], params[:id])
    redirect "/"
  end

  post "/like/:id" do
    like = @database_connection.sql("SELECT like_num from messages where id = #{params[:id]}").first

    if like["like_num"]
      likes = like["like_num"].to_i
    else
      likes = 0
    end

    likes += 1
    @database_connection.sql("UPDATE messages set like_num = #{likes} where id = #{params[:id]}").first
    redirect "/"
  end


end