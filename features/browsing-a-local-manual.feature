Feature: Browsing a local manual
  As a member of the public
  I want to be able to view a local manual and its sections

  Scenario: Viewing an existing manual
    When I view the employment income manual
    And I click on "EIM00500"
    Then I should see "EIM00500 - Employment income"

  Scenario: Visiting a nonexistent document
    When I visit a non-existent employment income manual section
    Then I should get a page not found response 
