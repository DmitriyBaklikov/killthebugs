class FragmentsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:hashie]

  def hashie

    @fragment = Fragment.find_by_hashie(params[:hashie])
    
  end

  def share

    @sharing = Sharing.new(:user_id => params[:user_id], :fragment_id => params[:fragment_id])
    
    if @sharing.save
      redirect_to :fragments, :notice => "Code fragment shared!"
    else
      redirect_to :fragments, :notice => "Cant' share fragment! May be it's already shared"
    end

  end

  def unshare
    
    @sharings = Sharing.where(:user_id => params[:user_id], :fragment_id => params[:fragment_id])
    
    if @sharings.destroy_all
      redirect_to :fragments, :notice => "This sharing removed!"
    else
      redirect_to :fragments, :notice => "Cant' remove sharing! May be it's already deleted"
    end

  end

  def shared
    @fragments = current_user.fragments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fragments }
    end
  end

  # GET /fragments
  # GET /fragments.json
  def index
    @fragments = Fragment.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fragments }
    end
  end

  # GET /fragments/1
  # GET /fragments/1.json
  def show
    
    @fragment = Fragment.find(params[:id])

    if User.find(@fragment.user_id).id == current_user.id
      render :show and return
    elsif @fragment.users.include?(current_user)
      render :show_shared and return
    else
      redirect_to root_path, :alert => "Sorry, you have no access to this page" and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fragment }
    end
  end

  # GET /fragments/new
  # GET /fragments/new.json
  def new
    @fragment = Fragment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fragment }
    end
  end

  # GET /fragments/1/edit
  def edit
    if can_edit_fragment(params[:id])
      @fragment = Fragment.find(params[:id])
    else
      redirect_to root_path, :alert => "Sorry, you cant' edit this code fragment!"
    end
  end

  # POST /fragments
  # POST /fragments.json
  def create
    
    @fragment         = Fragment.new(params[:fragment])
    @fragment.user_id = current_user.id
    
    code = @fragment.code

    code_with_lines = ""
    number = 1
    code.lines.each do |line|
      prefix = ""
      if number < 100 and number > 9
        prefix = "0"
      end
      if number < 10
        prefix = "00"
      end
      code_with_lines += prefix + number.to_s + line
      number += 1
    end

    @fragment.code = code_with_lines

    respond_to do |format|
      if @fragment.save
        format.html { redirect_to fragment_path(@fragment), notice: 'Fragment was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /fragments/1
  # PUT /fragments/1.json
  def update

    if can_edit_fragment(params[:id])

      @fragment = Fragment.find(params[:id])

      respond_to do |format|
        if @fragment.update_attributes(params[:fragment])
          format.html { redirect_to fragment_path(@fragment), notice: 'Fragment was successfully updated.' }
        else
          format.html { render action: "edit" }
        end
      end
    else

      redirect_to root_path, :alert => "Sorry, you cant' update this code fragment!"

    end
  end

  # DELETE /fragments/1
  # DELETE /fragments/1.json
  def destroy
    @fragment = Fragment.find(params[:id])
    @fragment.destroy

    respond_to do |format|
      format.html { redirect_to fragments_url }
      format.json { head :no_content }
    end
  end
end
