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

When(/^I follow the link to the manual update history$/) do
  click_on "See all updates"
end

Then(/^I can see a summary of changes made to the manual$/) do
  page.find(".js-subsection-title", text: "1 April 2014").click
  expect(page).to have_content("Employment income: general: table of contents")
end
