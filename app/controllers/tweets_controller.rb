class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:search].present? 
      search_term = "%#{params[:search]}%"
      @tweets = Tweet.joins(:user) 
                     .where("tweets.body LIKE :search OR tweets.title LIKE :search OR users.name LIKE :search", search: search_term)
    else
      @tweets = Tweet.all
    end
    
    
    if params[:tag_ids]
      @tweets = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          tag_tweets = Tag.find_by(name: key).tweets
          @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
        end
      end
    end

    if params[:tag]
    Tag.create(name: params[:tag])
    end
    @tweets = @tweets.page(params[:page]).per(3)
  end
      

  def new
      @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
  end
      
  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private
  def tweet_params
    params.require(:tweet).permit(:title, :body, :image, tag_ids: [])
  end
end

def post_params
  params.require(:post).permit(:body,:lat,:lng)
end
