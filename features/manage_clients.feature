Feature: Manage clients
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: a client cannot access clients index
    Given Client "test@test.com" authenticates
    And I am on the home page
    When I visit clients path
    Then I should see "You don't have permission for that."
    
  Scenario: a client cannot access clients edit
    Given Client "test@test.com" authenticates
    And I am on the home page
    When I visit edit client path
    Then I should see "You don't have permission for that."
    
  Scenario: a client cannot access clients new
    Given Client "test@test.com" authenticates
    And I am on the home page
    When I visit new client path
    Then I should see "You don't have permission for that."
  
  Scenario: a client access show action
    Given Client "test@test.com" authenticates
    And I am on the home page
    When I visit client path
    Then I should see the client "test@test.com" belongs to