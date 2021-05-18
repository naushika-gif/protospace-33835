class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show,:update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:new, :create, :index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
     @prototype = Prototype.new
    #新しい空箱を生成する時は単数にする方がわかりやすい
  end

  def create
     @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    prototype = Prototype.find(params[:id])
    
    if prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    # privateメソッドとしてprototype_paramsを定義し、title/catchcopy/conceptをprototypeテーブルへ保存できるようにしている
    # →バリデーションによって保存ができない場合でも入力済みの項目は消えない
    # パラメーターの中に、ログインしているユーザーのidと紐付いている、メッセージの内容contentを受け取れるように許可
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user == @prototype.user
    redirect_to action: :index
    end
  end
end
# AかつBがfalseとなる。A＝サインインしているか B＝投稿者か
# どちらもIdで比べている