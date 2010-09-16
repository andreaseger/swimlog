class PostsController < ApplicationController
  load_and_authorize_resource
  #before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @posts }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @post }
    end
  end

  def new
    8.times {@post.items.build}
    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @post }
    end
  end

  def edit
  end

  def create
    @post.user = current_user
    @post.schedule = generate_schedule_hash(params[:post][:items_attributes].to_a)
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    params[:post][:schedule] = generate_schedule_hash(params[:post][:items_attributes].to_a)
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  private
  def generate_schedule_hash(items)
    schedule = ""
    items.each do |item|
      i = item[1][:level]
      schedule << "p(level-" << i << "). " << item[1][:text] << "\n\n"
    end
    schedule
  end
end

