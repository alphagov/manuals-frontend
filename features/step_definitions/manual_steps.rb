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
  stub_fake_manual
  stub_fake_manual_updates
  click_on "See all updates"
end

Then(/^I can see a summary of changes made to the manual$/) do
  page.find(".js-subsection-title", text: "20 June 2014").click
  expect(page).to have_content("Added section on fillings")
end

When(/^I view the manual page$/) do
  stub_fake_manual
  visit "/guidance/my-manual-about-burritos"
end

Then(/^I should see the manual's updates$/) do
  expect(page).to have_content("Updates: My manual about Burritos")
end
