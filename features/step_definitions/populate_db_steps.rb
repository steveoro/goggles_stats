#
# *** Scenario: Populate DB with a local CSV file ***
#

Given(/^an existing and valid CSV data file$/) do
  FileTest.exists?( File.join(Rails.root, "test/fixtures/users_x_day-20150101-20150826.csv") )
end


When(/^I launch the dedicated rake task$/) do
  pending # Write code here that turns the phrase above into concrete actions
end


Then(/^I should import successfully the data$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
#-- ----------------------------------------------------------------------------
#++
