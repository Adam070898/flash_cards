enable :sessions
require 'faker'
require 'byebug'
# Cards are not randomized because while making the card reader I thought 200 ids
# Was too much for a session[:variable]
# Apparently not, and I should have made a guess module in the first place

get '/' do
  if session[:user] != nil
    redirect to("/welcome")
  else
    erb :index
  end
  # erb :uhoh
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
  puts User.where(id: session[:user]).first.rounds
  erb :welcome
end

post '/instructions' do
  session[:correct] = 0
  session[:lives] = 3
  session[:deck] = params[:deck]
  @deck = Deck.where(id: params[:deck]).first
  session[:current] = @deck.cards.first.id
  @product = Faker::Commerce.product_name
  erb :instructions
end

# This clearly isn't separation of concerns, however, due to the redirect causing all my sessions to dissapear, I used this.
post '/play/:question_id' do
  if session[:lives] < 1
    puts session.inspect
    new_round = Round.create(correct: session[:correct], deck_id: session[:deck])
    new_round.save
    User.where(id: session[:user]).first.rounds << new_round
    @correct = session[:correct]
    erb :gameover
  else
    card = Card.where(id: params[:question_id]).first
    @question = card.question
    session[:current] += 1
    if params[:answer] != nil
      answer = Card.where(id: (params[:question_id].to_i-1)).first.answer.downcase
      if params[:answer] == ""
        puts "No answer given"
        @le_feedback = "Come on! You gotta at least try right?"
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
end

get '/loool' do
  redirect to("http://www.youtube.com/watch?v=dQw4w9WgXcQ/")
end