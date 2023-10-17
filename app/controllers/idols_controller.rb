# frozen_string_literal: true

# Manages interactions with idols.
class IdolsController < ApplicationController
  before_action :login_required

  def index
    @idols = Idol.where(user_id: current_user.id)
  end

  def show
    @idol = Idol.find(params[:id])
  end

  def new
    @idol = Idol.new
    @idol.albums.build
  end

  def edit
    @idol = Idol.find(params[:id])
  end

  def create
    @idol = current_user.idols.build(idol_params)
    if @idol.save
      redirect_to mypages_path, success: t('idols.create.success')
    else
      flash.now[:danger] = t('idols.error')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @idol = Idol.find(params[:id])
    if @idol.update(idol_params)
      redirect_to idol_path(@idol), success: t('idols.update.success')
    else
      flash.now[:danger] = t('idols.error')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @idol = Idol.find(params[:id])
    @idol.destroy
    redirect_to mypages_path,success: t('idols.destroy.success')
  end

  private

  def idol_params
    params.require(:idol).permit(:name, :birth_date, :is_selected)
  end
end
