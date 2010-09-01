Feature: Manage users
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: unsucessful login
    Given I am the registered user test@test.com
    And I am on the login page
    When I login with invalid credentials
    Then I should be on the bad login page
    And I should see "is not valid"
  
  Scenario: successful login
    Given I am the registered user test@test.com
    And I am on the login page
    When I login with valid credentials
    Then I should be on the home page
    And I should see "Login successful!"
    
  Scenario: logout
    Given Client "test@test.com" authenticates
    When I follow "Logout"
    Then I should see "Logout successful!"
    
  Scenario: add new users
    Given Admin "admin@test.com" authenticates
    When I follow "Users"
    And I follow "New User"
    And I fill in "user_email" with "new@test.com"
    And I fill in "user_password" with "1234"
    And I fill in "user_password_confirmation" with "1234"
    And I press "Save"
    Then I should see "User was successfully created."