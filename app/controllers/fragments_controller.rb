class FragmentsController < ApplicationController
  
  before_filter :authenticate_user!

  def hashie

    @fragment = Fragment.find_by_hashie(params[:hashie])
    
  end

  # GET /fragments
  # GET /fragments.json
  def index
    @fragments = current_user.fragments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fragments }
    end
  end

  # GET /fragments/1
  # GET /fragments/1.json
  def show
    @fragment = current_user.fragments.find(params[:id])

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
    @fragment = current_user.fragments.find(params[:id])
  end

  # POST /fragments
  # POST /fragments.json
  def create
    
    @fragment = Fragment.new(params[:fragment])
    
    current_user.fragments << @fragment
    
    respond_to do |format|
      if @fragment.save
        format.html { redirect_to @fragment, notice: 'Fragment was successfully created.' }
        format.json { render json: @fragment, status: :created, location: @fragment }
      else
        format.html { render action: "new" }
        format.json { render json: @fragment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fragments/1
  # PUT /fragments/1.json
  def update
    @fragment = current_user.fragments.find(params[:id])

    respond_to do |format|
      if @fragment.update_attributes(params[:fragment])
        format.html { redirect_to @fragment, notice: 'Fragment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fragment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fragments/1
  # DELETE /fragments/1.json
  def destroy
    @fragment = current_user.fragments.find(params[:id])
    @fragment.destroy

    respond_to do |format|
      format.html { redirect_to fragments_url }
      format.json { head :no_content }
    end
  end
end