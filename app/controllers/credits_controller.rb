class CreditsController < ApplicationController
  before_filter :load_client
  before_filter :load_transaction
  filter_resource_access
  
  # GET /credits
  # GET /credits.xml
  def index
    @credits = @transaction.credits.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @credits }
    end
  end

  # GET /credits/1
  # GET /credits/1.xml
  def show
    @credit = @transaction.credits.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @credit }
    end
  end

  # GET /credits/new
  # GET /credits/new.xml
  def new
    @credit = @transaction.credits.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @credit }
    end
  end

  # GET /credits/1/edit
  def edit
    @credit = @transaction.credits.find(params[:id])
  end

  # POST /credits
  # POST /credits.xml
  def create
    @credit = @transaction.credits.new(params[:credit])
    @credit.user = current_user
    
    if @credit.amount.blank?
      flash[:error] = "You must provide an amount to credit."
      render :action => "new" and return
    end
    
    if @credit.amount > (@transaction.settled_amount - @transaction.credited_amount)
      flash[:error] = "You cannot credit for an amount larger than what has been settled."
      render :action => "new" and return
    end
    
    code_ok, message = @credit.ms_credit
    
    respond_to do |format|
      if @credit.save
        format.html { redirect_to(client_transaction_path(@client, @transaction), :notice => 'Credit was successfully processed.') }
        format.xml  { render :xml => @credit, :status => :created, :location => @credit }
      else
        flash[:error] = message
        format.html { render :action => "new" }
        format.xml  { render :xml => @credit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /credits/1
  # PUT /credits/1.xml
  def update
    @credit = @transaction.credits.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        format.html { redirect_to(client_transaction_credit_path(@client, @transaction, @credit), :notice => 'Credit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @credit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /credits/1
  # DELETE /credits/1.xml
  def destroy
    @credit = @transaction.credits.find(params[:id])
    @credit.destroy

    respond_to do |format|
      format.html { redirect_to(client_transaction_credits_url(@client, @transaction)) }
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
