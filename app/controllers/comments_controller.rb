class CommentsController < ApplicationController
  before_action :set_post, only: %i[ new update index ]
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = @post.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
    @post = @comment.post
  end

  # GET /comments/new
  def new
    @comment = @post.comments.build
    set_user
  end

  # GET /comments/1/edit
  def edit
    @post = @comment.post
  end

  # POST /comments or /comments.json
  def create
    @comment = @post.comments.build(comment_params)
    set_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to request.referrer || @comment.post, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.includes(:post, :user).find(params[:id])
    end

    def set_post
      @post = Post.includes(comments: :user).find(params[:post_id])
    end

    def set_user
      @comment.user = current_user
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:post_id, :title, :body)
    end
end
