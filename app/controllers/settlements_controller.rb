class SettlementsController < ApplicationController
  before_filter :load_client
  before_filter :load_transaction
  filter_resource_access
  
  # GET /settlements
  # GET /settlements.xml
  def index
    @settlements = @transaction.settlements.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settlements }
    end
  end

  # GET /settlements/1
  # GET /settlements/1.xml
  def show
    @settlement = @transaction.settlements.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @settlement }
    end
  end

  # GET /settlements/new
  # GET /settlements/new.xml
  def new
    @settlement = @transaction.settlements.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @settlement }
    end
  end

  # GET /settlements/1/edit
  def edit
    @settlement = @transaction.settlements.find(params[:id])
  end

  # POST /settlements
  # POST /settlements.xml
  def create
    @settlement = @transaction.settlements.new(params[:settlement])
    @settlement.user = current_user
    
    if @settlement.amount.blank?
      flash[:error] = "You must provide an amount to settle."
      render :action => "new" and return
    end
    
    if @settlement.amount > (@transaction.amount - @transaction.settled_amount)
      flash[:error] = "You cannot settle for an amount larger than what has been approved."
      render :action => "new" and return
    end
    
    code_ok, message = @settlement.ms_settle

    respond_to do |format|
      if code_ok and @settlement.save
        format.html { redirect_to(client_transaction_path(@client, @transaction), :notice => 'Settlement was successfully processed.') }
        format.xml  { render :xml => @settlement, :status => :created, :location => @settlement }
      else
        flash[:error] = message
        format.html { render :action => "new" }
        format.xml  { render :xml => @settlement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settlements/1
  # PUT /settlements/1.xml
  def update
    @settlement = @transaction.settlements.find(params[:id])

    respond_to do |format|
      if @settlement.update_attributes(params[:settlement])
        format.html { redirect_to(client_transaction_settlement_path(@client, @transaction, @settlement), :notice => 'Settlement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @settlement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /settlements/1
  # DELETE /settlements/1.xml
  def destroy
    @settlement = @transaction.settlements.find(params[:id])
    @settlement.destroy

    respond_to do |format|
      format.html { redirect_to(client_transaction_settlements_url(@client, @transaction)) }
      format.xml  { head :ok }
    end
  end
  
  private
    def load_client
      @client = Client.find(params[:client_id])
    end
    
    def load_transaction
      @transaction = @client.transactions.find(params[:transaction_id])
    end
end
