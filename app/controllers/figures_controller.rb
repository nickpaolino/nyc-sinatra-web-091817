class FiguresController < ApplicationController

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end


  post '/figures' do
      @figure = Figure.create(params["figure"])

      if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
      end

      if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
      end

      @figure.save
      redirect to "/figures/#{@figure.id}"
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    # binding.pry
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    # binding.pry
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
    # @figure.name = params[:figure][:name]
    # # binding.pry
    # landmark = Landmark.find(params[:figure][:landmark_ids])
    # @figure.landmarks = landmark
    # title = Title.find(params[:figure][:title_ids])
    # @figure.titles = title
    #
    # # @figure.save
    # redirect "/figures/#{@figure.id}"
  end

end
