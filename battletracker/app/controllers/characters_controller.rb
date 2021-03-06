class CharactersController < ApplicationController
  before_action :bounce

  def index
    @user = current_user
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      current_user.characters << @character
      redirect_to characters_path
    else
      p 'hello'
      render 'new'
    end
  end

  def destroy
    Character.find_by(id: params[:id]).destroy
    redirect_to characters_path
  end

  def edit
    @character = Character.find_by(id: params[:id])
    # @id = params[:id]
  end

  def update
    @character = Character.find_by(id: params[:id])
    if @character.update(character_params)
      redirect_to characters_path
    else
      render 'edit'
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :job, :total_hp, :current_hp, :armor_class, :initiative, :alive)
  end
end
