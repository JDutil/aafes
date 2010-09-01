authorization do
  role :guest do
    has_permission_on :roles, :to => :read
    has_permission_on :users, :to => :manage#[:show, :edit, :update]
  end
  
  role :client do
    includes :guest
    
    has_permission_on :clients, :to => :show
    has_permission_on :transactions, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
    has_permission_on :approvals, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
    has_permission_on :settlements, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
    has_permission_on :credits, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete] do
      #if_attribute :
    end
    has_permission_on [:users], :to => [:show, :edit, :update]
  end
  
  role :admin do
    has_permission_on [:users, :clients, :client_users, :approvals, :settlements, :credits, :transactions,:roles], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
  end
  
end

privileges do
  # privilege :manage do
  #   includes [:index, :show, :new, :create, :edit, :update, :delete]
  # end
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
