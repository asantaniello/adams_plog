class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #This authenticates admin whenever a post is to be created, updated or destroyed.
  before_action :authenticate_admin!, except: [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end


  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
   @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Created post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error saving post!"
      render :new
    end
  end

=begin
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
=end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "Successfully updated post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error updating post!"
      render :edit
    end
  end

=begin
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # DELETE /posts/1
  # DELETE /posts/1.json
  # The destroy action removes the post permanently from the database
  def destroy
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to posts_path
    else
      flash[:alert] = "Error updating post!"
    end
  end

=begin
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
=end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
  def find_post
    @post = Post.find(params[:id])
    end
end
