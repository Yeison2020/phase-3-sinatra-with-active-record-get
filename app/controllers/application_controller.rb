class ApplicationController < Sinatra::Base

  # Setting default the data the browser will receive 
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end


  get '/games' do 
    # get all the games from database
    # return s JSON response with an array of all the game data
    # Note I can remove the order or litmit Its just funtionality
    games = Game.all.order(:title).limit(15)
    games.to_json
  end

   # use the :id syntax to create a dynamic route
   get '/games/:id' do
    # look up the game in the database using its ID
    game = Game.find(params[:id])
    # send a JSON-formatted response of the game data
    # game.to_json This added will add  to the database the ID associated with game if
    # game.to_json(include: :reviews)
    # game.to_json(include: { reviews: { include: :user } })
    #-------------------------------------------
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })






  end

end
