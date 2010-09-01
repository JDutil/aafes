Given /^the following approvals:$/ do |approvals|
  Approval.create!(approvals.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) approval$/ do |pos|
  visit approvals_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following approvals:$/ do |expected_approvals_table|
  expected_approvals_table.diff!(tableish('table tr', 'td,th'))
end
