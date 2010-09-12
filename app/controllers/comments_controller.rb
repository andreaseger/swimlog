class CommentsController < ApplicationController

  def create
    @comment =  Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@comment.post, :notice => 'Comment was successfully created.') }
        format.js
      else
        format.html { redirect_to @comment.post }
      end
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
#  def destroy
#    @comment = Comment.find(params[:id])
#    @comment.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(comments_url) }
#      format.xml  { head :ok }
#    end
#  end
end

