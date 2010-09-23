class FinalBoxesController < ApplicationController
  # GET /final_boxes
  # GET /final_boxes.xml
  def index
    @final_boxes = FinalBox.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @final_boxes }
    end
  end

  # GET /final_boxes/1
  # GET /final_boxes/1.xml
  def show
    @final_box = FinalBox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @final_box }
    end
  end

  # GET /final_boxes/new
  # GET /final_boxes/new.xml
  def new
    @final_box = FinalBox.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @final_box }
    end
  end

  # GET /final_boxes/1/edit
  def edit
    @final_box = FinalBox.find(params[:id])
  end

  # POST /final_boxes
  # POST /final_boxes.xml
  def create
    @final_box = FinalBox.new(params[:final_box])

    respond_to do |format|
      if @final_box.save
        flash[:notice] = 'FinalBox was successfully created.'
        format.html { redirect_to(@final_box) }
        format.xml  { render :xml => @final_box, :status => :created, :location => @final_box }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @final_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /final_boxes/1
  # PUT /final_boxes/1.xml
  def update
    @final_box = FinalBox.find(params[:id])

    respond_to do |format|
      if @final_box.update_attributes(params[:final_box])
        flash[:notice] = 'FinalBox was successfully updated.'
        format.html { redirect_to(@final_box) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @final_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /final_boxes/1
  # DELETE /final_boxes/1.xml
  def destroy
    @final_box = FinalBox.find(params[:id])
    @final_box.destroy

    respond_to do |format|
      format.html { redirect_to(final_boxes_url) }
      format.xml  { head :ok }
    end
  end
end
