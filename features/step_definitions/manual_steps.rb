When(/^I view the employment income manual$/) do
  visit "/guidance/employment-income-manual"
end

When(/^I click on "(.*?)"$/) do |link_text|
  click_on link_text
end

When(/^I visit a non\-existent employment income manual section$/) do
  visit "/guidance/employment-income-manual/nonexistent-manual-section"
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Then /^I should get a page not found response$/ do
  expect(page.status_code).to eq(404)
end
