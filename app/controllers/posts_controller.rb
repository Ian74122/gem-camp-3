class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  require 'csv'

  def index
    @posts = Post.includes(:categories, :user, :comments).page params[:page]

    respond_to do |format|
      format.html
      format.xml { render xml: @posts.as_json }
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << [
            User.human_attribute_name(:email), Post.human_attribute_name(:id),
            Post.human_attribute_name(:title), Post.human_attribute_name(:content),
            Post.human_attribute_name(:categories), Post.human_attribute_name(:created_at)
          ]

          @posts.each do |p|
            csv << [
              p.user&.email, p.id, p.title, p.content,
              p.categories.pluck(:name).join(','), p.created_at
            ]
          end
        end
        render plain: csv_string
      }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    SampleJob.perform_later
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit
    authorize @post, :edit?, policy_class: PostPolicy
  end

  def update
    authorize @post, :update?, policy_class: PostPolicy
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post, :destroy?, policy_class: PostPolicy
    redirect_to posts_path if @post.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, category_ids: [])
  end
end
