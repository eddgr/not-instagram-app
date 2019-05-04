class PostsController < ApplicationController
  before_action :require_login, only: :edit

  # READ
  def index
    @posts = Post.all.order('posts.created_at DESC')
    # order by created_at in descending order so newest shows first

    # show only posts that contain photos in the index page
    @photos = @posts.select do |post|
      post.photo.attached?
    end.sample(9)
  end

  def show
    set_post
  end

  def explore
    # using the same @var as index
    @posts = Post.all.order('posts.created_at DESC')
    @photos = @posts.select do |post|
      post.photo.attached?
    end.sample(9)

    # original idea
    # posts of people that I'm currently not following
    # go through each post in Post.all
    # if post does not equal post from following or self, show
    # @discover = Post.all.sample(9)
  end

  # CREATE
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Successfully posted!"
      redirect_to @post
    else
      render :new
    end
  end

  # UPDATE
  def edit
    set_post
  end

  def update
    if set_post.update(post_params)
      flash[:success] = "Post successfully updated!"
      redirect_to set_post
    else
      render :edit
    end
  end

  # DESTROY
  def destroy
    flash[:success] = "Post successfully deleted!"
    set_post.destroy
    redirect_to user_path(current_user)
  end

  # HIDDEN METHODS
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :user_id, :photo)
  end

end
