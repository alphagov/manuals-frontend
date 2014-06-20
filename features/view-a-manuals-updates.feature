Feature: View a Manual's Updates
  As a member of the public
  I want to be able to view a local manual's updates

  Scenario: Viewing a Manual's Updates Page
    When I view the manual page
    And I follow the link to the manual update history
    Then I should see the manual's updates

  @javascript
  Scenario: Viewing a specific update
    When I view the manual page
    And I follow the link to the manual update history
    Then I can see a summary of changes made to the manual
