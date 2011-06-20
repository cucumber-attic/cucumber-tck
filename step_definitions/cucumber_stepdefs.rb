require File.dirname(__FILE__) + '/cucumber_mappings'

World(CucumberMappings)

Given /^a scenario "([^"]*)" with:$/ do |scenario_name, steps|
  @scenario_name = scenario_name
  scenario_with_steps(scenario_name, steps)
end

Given /^the following feature:$/ do |feature|
  write_feature(feature)
end

Given /^the step "([^"]*)" has a passing mapping$/ do |step_name|
  write_passing_mapping(step_name)
end

Given /^the step "([^"]*)" has a pending mapping$/ do |step_name|
  write_pending_mapping(step_name)
end

Given /^the step "([^"]*)" has a failing mapping$/ do |step_name|
  write_failing_mapping(step_name)
end

When /^Cucumber executes the scenario "([^"]*)"$/ do |scenario_name|
  run_scenario(scenario_name)
end

When /^Cucumber runs the feature$/ do
  run_feature
end

When /^Cucumber runs the scenario with steps for a calculator$/ do
  write_calculator_code
  write_mappings_for_calculator
  run_scenario(@scenario_name)
end

Then /^the scenario passes$/ do
  assert_partial_output("1 scenario (1 passed)", all_output)
  assert_success true
end

Then /^the scenario fails$/ do
  assert_partial_output("1 scenario (1 failed)", all_output)
  assert_success false
end

Then /^the scenario is pending$/ do
  assert_partial_output("1 scenario (1 pending)", all_output)
  assert_success true
end

Then /^the scenario is undefined$/ do
  assert_partial_output("1 scenario (1 undefined)", all_output)
  assert_success true
end

Then /^the step "([^"]*)" is skipped$/ do |pattern|
  assert_skipped(pattern)
end

Then /^the feature passes$/ do
  assert_no_partial_output("failed", all_output)
  assert_success true
end
