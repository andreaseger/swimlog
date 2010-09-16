class CommentsController < ApplicationController
  load_and_authorize_resource
  #before_filter :authenticate_user!
  def create
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment.post, :notice => 'Comment was successfully created.') }
        format.js
      else
        format.html { redirect_to @comment.post }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(@comment.post) }
      format.xml  { head :ok }
    end
  end



#  def edit
#    @comment = Comment.find(params[:id])
#  end
#
#
#  def update
#    @comment = Comment.find(params[:id])
#
#    respond_to do |format|
#      if @comment.update_attributes(params[:comment])
#        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
end

