Feature: "Category Select Component"
  In order to associate items to categories
  It is necessary an UI to have the user pick a category

  Scenario: "There must exist a component for browsing categories"
    Given I open component "Category Select"
    Then I should see UI for component "Category Select"
