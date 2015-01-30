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
  session[:blank] = 0
  session[:lives] = 3
  @deck = Deck.where(id: params[:deck]).first
  session[:current] = @deck.cards.first.id
  @product = Faker::Commerce.product_name
  erb :instructions
end

post '/play/:question_id' do
  if session[:lives] < 1
    session[:gameover] = "true"
    redirect to("/gameover")
  end
  card = Card.where(id: params[:question_id]).first
  @question = card.question
  session[:question] += 1
  session[:current] += 1
  if params[:answer] != nil
    answer = Card.where(id: (params[:question_id].to_i-1)).first.answer.downcase
    if params[:answer] == ""
      puts "No answer given"
      @le_feedback = "Come on! You gotta at least try right?"
      session[:blank] += 1
      session[:lives] -= 1
    elsif params[:answer].downcase == answer
      puts "Correct!"
      @le_feedback = "Correct!"
      session[:correct] += 1
    elsif params[:answer].downcase != answer
      puts "Incorrect!"
      @le_feedback = "Sorry, but the answer was \"#{answer}\""
      session[:lives] -= 1
    end
  end
  erb :game
end

get '/gameover' do
  puts session[:gameover]
  if session[:gameover] == "true"
    Round.create
    session[:gameover] = ""
    erb :gameover
  else erb :uhoh
  end
end

get '/loool' do
  redirect to("http://www.youtube.com/watch?v=dQw4w9WgXcQ/")
end