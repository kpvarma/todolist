class TodosController < ApplicationController
  
  #before_filter :require_user, :set_navs, :parse_filters_from_url
  layout "public"
  #authorize_actions_for Item, :actions => {:index => :delete}
  
  before_filter :parse_pagination_params, :only=>:index
  
  # GET /todos
  # GET /todos.js
  # GET /todos.json
  def index
    
    get_collections
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
      format.js {}
    end
  end

  # GET /todos/1
  # GET /todos/1.js
  # GET /todos/1.json
  def show
    ## Creating the todo object  
    @todo = Todo.find(params[:id])
    
    respond_to do |format|
      format.html { get_collections and render :action => :index }
      format.json { render json: @todo }
      format.js {}
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    ## Intitializing the todo object 
    @todo = Todo.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
      format.js {}
    end
  end

  # GET /todos/1/edit
  def edit
    ## Fetching the todo object 
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.js
  # POST /todos.json
  def create
    ## Creating the todo object  
    @todo = Todo.new(params[:todo])
    
    ## Validating the data
    @todo.valid?
    
    respond_to do |format|
      if @todo.errors.blank?
        
        # Saving the todo object
        @todo.save
        
        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Todo")
        store_flash_message(message, :success)
        
        format.html { 
          redirect_to todo_url(@todo), notice: message
        }
        format.json { render json: @todo, status: :created, location: @todo }
        format.js {}
      else
        
        # Setting the flash message
        message = @todo.errors.full_messages.to_sentence
        store_flash_message(message, :alert)
        
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.js
  # PUT /todos/1.json
  def update
    ## Fetching the todo
    @todo = Todo.find(params[:id])
    
    ## Updating the @todo object with params
    @todo.update_attributes(params[:todo])
    
    ## Validating the data
    @todo.valid?
    
    respond_to do |format|
      if @todo.errors.blank?
        
        # Saving the todo object
        @todo.save
        
        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Todo")
        store_flash_message(message, :success)
        
        format.html { 
          redirect_to todo_url(@todo), notice: message 
        }
        format.json { head :no_content }
        format.js {}
        
      else
        
        # Setting the flash message
        message = @todo.errors.full_messages.to_sentence
        store_flash_message(message, :alert)
        
        format.html { 
          render action: "edit" 
        }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
        format.js {}
        
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.js
  # DELETE /todos/1.json
  def destroy
    ## Fetching the todo
    @todo = Todo.find(params[:id])
    
    respond_to do |format|
      ## Destroying the todo
      @todo.destroy
      
      # Fetch the todos to refresh ths list and details box
      get_collections
      @todo = @todos.first
      
      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "Todo")
      store_flash_message(message, :success)
      
      format.html { 
        redirect_to todos_url notice: message
      }
      format.json { head :no_content }
      format.js {}
        
    end
  end
  
  private
  
  def set_navs
    set_nav("Todo")
  end
  
  def get_collections
    # Fetching the todos
    relation = Todo.where("")
    @filters = {}
    
    if params[:todo] && params[:todo][:query]
      @query = params[:todo][:query].strip
      if !@query.blank?
        relation = relation.where("
          LOWER(title) LIKE LOWER('%#{@query}%')")
      end
    end
    
    @todos = relation.order("created_at desc").page(@current_page).per(@per_page)
    
    ## Initializing the @todo object so that we can render the show partial
    @todo = @todos.first unless @todo
    
    return true
    
  end
  
end
