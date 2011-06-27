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
  assert_passing_scenario
end

Then /^the scenario fails$/ do
  assert_failing_scenario
end

Then /^the scenario is pending$/ do
  assert_pending_scenario
end

Then /^the scenario is undefined$/ do
  assert_undefined_scenario
end

Then /^the step "([^"]*)" is skipped$/ do |pattern|
  assert_skipped(pattern)
end

Then /^the feature passes$/ do
  assert_no_partial_output(failed_output, all_output)
  assert_success true
end
