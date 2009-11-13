Feature: "Manage products"
  In order to sell products
  As a seller
  I want to manage my products

  Scenario: "Create a new product"
    Given I go to the site
    And I click the "mi-tienda-btn" link
    And I click the "Agregar producto" link

    # And I am logged in
    # And I am a seller
    And there is a product form
    When I fill the "name" field with "Mi Primer producto creado usando BDD" 
    And I fill the "description" field with "Mi Primer producto creado usando BDD" 
    And I fill the "price" field with "$999,999.00"
    And I select "Nuevo" for the "condition" field
    And I fill the "type" field with "spec"
    And I fill the "quantity" field with "always"
    And I click the "Post Product" link
    Then I should see 'The product has been created'
