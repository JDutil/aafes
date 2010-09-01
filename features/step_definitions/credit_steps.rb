Given /^the following credits:$/ do |credits|
  Credit.create!(credits.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) credit$/ do |pos|
  visit credits_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following credits:$/ do |expected_credits_table|
  expected_credits_table.diff!(tableish('table tr', 'td,th'))
end
