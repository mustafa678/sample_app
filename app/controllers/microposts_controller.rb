class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destory]
  before_filter :authorized_user, :only => :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  private

  def authorized_user
    @micropost = Micropost.find(params[:id]) or nil
    redirect_to root_path unless current_user?(@micropost.user)
  end
end
