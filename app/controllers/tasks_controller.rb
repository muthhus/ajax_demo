class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new
    
    respond_to do |format|
      format.html # new.html.erb
      
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    @task.note = 'Empty Note'
    @task.priority = 0;

    respond_to do |format|
      if @task.save
        @tasks = Task.all

        # insert at first position        
        @task_before = 'tablehead'
        
        # only if we find the task and only if it is not the first task, we set a new position to insert
        @taskindex = @tasks.index(@task)
        if @taskindex 
          if @taskindex > 0  
            @task_before = 'task_' + @tasks.at(@taskindex - 1).id.to_s
          end
        end
        
        format.html { redirect_to(@task, :notice => 'Task was successfully created.') }
        format.js
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.js
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    if params[:taskname]
      @task.name = params[:taskname]
    end

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def taskname
    @task = Task.find(params[:id])
    
    render :layout => false, :inline => "<%= @task.name %>"  
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.js
      format.xml  { head :ok }
    end
  end
end
