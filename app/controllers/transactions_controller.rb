class TransactionsController < ApplicationController
  before_filter :load_client
  filter_resource_access
  
  # GET /transactions
  # GET /transactions.xml
  def index
    @transactions = @client.transactions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.xml
  def show
    @transaction = @client.transactions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.xml
  def new
    @transaction = @client.transactions.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = @client.transactions.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.xml
  def create
    @transaction = @client.transactions.new(params[:transaction])
    @transaction.user = current_user
    
    if @transaction.cc_number.blank? and @transaction.amount.blank?
      flash[:error] = "You must provide a card number and amount to charge."
      render :action => "new" and return
    end
    
    code_ok, message = @transaction.ms_approval

    respond_to do |format|
      if code_ok and @transaction.save
        format.html { redirect_to(client_transaction_path(@client, @transaction), :notice => 'Transaction was successfully Approved.') }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        flash[:error] = message
        format.html { render :action => "new", :error => message }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.xml
  def update
    @transaction = @client.transactions.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(client_transaction_path(@client, @transaction), :notice => 'Transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.xml
  def destroy
    @transaction = @client.transactions.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(client_transactions_url(@client)) }
      format.xml  { head :ok }
    end
  end
  
  private
    def load_client
      @client = Client.find(params[:client_id])
    end
end