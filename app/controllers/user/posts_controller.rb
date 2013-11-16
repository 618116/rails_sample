class User::PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_filter :load_user

  def load_user
  	@user = User.find(params[:user_id])
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = @user.posts
    @comments = @user.comments
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = @user.posts.find(params[:id])
    @comment = @post.comments.build
  end

  # GET /posts/new
  def new
    @post = @user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @user = User.find(params[:user_id])
      @post = @user.posts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :texts)
    end
end