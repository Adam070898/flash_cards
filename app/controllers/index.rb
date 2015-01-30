require 'faker'
get '/' do
  puts session[:user]
  if session[:user] != nil
    redirect to("/welcome")
  else
    erb :index
  end
end

post '/' do
  puts session[:user]
  user = User.where(email: params[:email].downcase, password: params[:password].downcase)
  if user != []
    session[:user] = user.first.id
    puts session[:user]
    erb :welcome
  else
    @error = " - Invalid username/password"
    erb :index
  end
end

post '/logout' do
  session[:user] = nil
  session[:deck] = nil
  redirect to("/")
end

get '/welcome' do
  erb :welcome
end

post '/instructions' do
  session[:question] = 0
  session[:correct] = 0
  session[:incorrect] = 0
  session[:blank] = 0
  session[:lives] = 3
  @deck = Deck.where(id: params[:deck]).first
  @product = Faker::Commerce.product_name
  erb :instructions
end

post '/play/:question_id' do
  card = Card.where(id: params[:question_id]).first
  @question = card.question
  session[:question] += 1
  erb :game
end