Given /^I go to the site$/ do
  visit "/"
end

Given /^I am logged in$/ do
  pending
end

Given /^I am a seller$/ do
  pending
end

Given /^I click the "([^\"]*)" link$/ do |arg1|
  click_link arg1
end

When /^I click "([^\"]*)" link$/ do |arg1|
  pending
end

Then /^I should see 'The product has been created'$/ do
  pending
end

Given /^there is a product form$/ do
  # check there is a product form
  product_form_visible = selenium.visible? "product-form"
  product_form_visible.should == true
end

When /^I fill the "([^\"]*)" field with "([^\"]*)"$/ do |field, value|
  click_link "Edit #{field.capitalize}"
  fill_in "edit-product-#{field}", :with => value
  click_button "save-product-#{field}"
end

When /^I select "([^\"]*)" for the "([^\"]*)" field$/ do |option, field|
  click_link "Edit #{field.capitalize}"
  select option, :from => "edit-product-#{field}"
  click_button "save-product-#{field}"
end

When /^I select category "([^\"]*)"$/ do |arg1|
  pending
end
