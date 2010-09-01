Feature: Manage settlements
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new settlement
    Given Client "test@test.com" authenticates
    And I am on the new settlement page
    When I fill in "Auth code" with "1234"
    And I fill in "Auth ticket" with "12345"
    And I fill in "Cc number" with "123456"
    And I fill in "Amount" with "999"
    And I press "Submit"
    Then I should see "1234"
    And I should see "12345"
    And I should see "123456"
    And I should see "999"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  # Scenario: Delete settlement
  #   Given the following settlements:
  #     |auth_code|auth_ticket|cc_number|amount|facility_number|
  #     |1|1|1|1|1|
  #     |2|2|2|2|2|
  #     |3|3|3|3|3|
  #     |4|4|4|4|4|
  #   When I delete the 3rd settlement
  #   Then I should see the following settlements:
  #     |Auth code|Auth ticket|Cc number|Amount|Facility number|
  #     |1|1|1|1|1|
  #     |2|2|2|2|2|
  #     |4|4|4|4|4|
             