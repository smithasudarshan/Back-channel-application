class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all
    @posts = Post.find(:all, :order=> "post_id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id=session[:user_id]


    respond_to do |format|
      if @post.save
        parent_postid = @post.id
        @post.post_id=parent_postid
        @post.update_attribute("post_id", parent_postid)
        @post.update_attribute("user_id", session[:user_id])

        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  def createreply
    @post = Post.find(params[:id])

  end

  def reply
    @post = Post.new
    @post.post_id = params[:parent_post_id]
    @post.post =  params[:post]
    @post.user_id = session[:user_id]

    respond_to do |format|
    if @post.save()
        format.html { redirect_to '/posts', notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
    end
    end
  end

  def upVote
    @post = Post.find(params[:id])
    @child_post = Post.find(:all, :conditions => "post_id = '#{params[:id]}'")

    if @post.id != @post.post_id
      @parent_post = Post.find(:first, :conditions => "id = '#{@post.post_id}'")
    end

    @vote = Vote.new
    @vote.post_id = params[:id]
    @vote.user_id = session[:user_id]
    @vote.save()

    @post.weight += 1

    @post.save()
    if !@parent_post.nil?
      @parent_post.weight += 1
      @parent_post.save()
    end

    redirect_to posts_path
  end

  def voteCount
    @post = Post.find(params[:id])
    @temp = Vote.find(:all, :conditions => "post_id = '#{@post.id}'")
    @count = @temp.size

  end


  def votes

    @vote = Vote.new
    #@post = Post.find(params[:id])
    @post.post_id = params[:parent_post_id]
    @post.user_id = session[:user_id]

    @vote.user_id = @post.user_id
    @vote.post_id = @post.post_id

    respond_to do |format|
    if @vote.save()
        format.html { redirect_to posts_path, notice: 'Voted successfully.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
    end
    end

    #@vote.new(:user_id => @post.user_id, :post_id => @post.post_id).save


    end

  def search
    @searchFor = params[:search]
    @searchType = params[:searchType]

    @searchFor = @searchFor.downcase

    @searchResult = ""
    if @searchType.to_s == "2"
      @keywords = "%".concat(@searchFor)
      @keywords = @keywords.split(" ").join("%")
      @searchResult = Post.find(:all, :conditions => "lower(post) like '#{@keywords}%' ")
    else
      @users = User.find(:all, :conditions => "lower(username) like '%#{@searchFor}%' or lower(fullname) like '%#{@searchFor}%'")

      if !@users.nil?
	      @userIdList = ""
	      @users.each do |users|
		@userIdList = @userIdList + users.id.to_s.concat(",")
	      end

	      @userIdList = @userIdList.chop


	      @searchResult = Post.find(:all, :conditions => "user_id in (#{@userIdList})")
	end
    end
  end

  def reports
    @posts = Post.all
    @posts = Post.find(:all, :order=> "post_id")

  end

end
