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

Given /^the step "([^"]*)" has a mapping failing with the message "([^"]*)"$/ do |step_name, message|
  write_failing_mapping_with_message(step_name, message)
end

Given /^a World variable initialized to (\d+)$/ do |value|
  write_world_variable_with_numeric_value(value)
end

Given /^a World function$/ do
  write_world_function
end

Given /^a custom World constructor$/ do
  write_custom_world_constructor
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

When /^Cucumber executes a scenario that increments the World variable by (\d+)$/ do |increment_value|
  write_mapping_incrementing_world_variable_by_value("I increment", increment_value)
  write_mapping_logging_world_variable_value("I log the variable value")
  write_feature <<-EOF
Feature:
  Scenario:
    When I increment
    Then I log the variable value
EOF
  run_feature
end

When /^Cucumber executes two scenarios that increment the World variable by (\d+)$/ do |increment_value|
  write_mapping_incrementing_world_variable_by_value("I increment", increment_value)
  write_mapping_logging_world_variable_value("I log the variable value", "1")
  write_mapping_logging_world_variable_value("I log the variable value again", "2")
  write_feature <<-EOF
Feature:
  Scenario:
    When I increment
    Then I log the variable value
  Scenario:
    When I increment again
    Then I log the variable value again
EOF
  run_feature
end

#"
When /^Cucumber executes a scenario that calls the World function$/ do
  write_mapping_calling_world_function("I call the world function")
  write_feature <<-EOF
Feature:
  Scenario:
    When I call the world function
EOF
  run_feature
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

Then /^the scenario called "([^"]*)" is reported as failing$/ do |scenario_name|
  assert_scenario_reported_as_failing(scenario_name)
end

Then /^the scenario called "([^"]*)" is not reported as failing$/ do |scenario_name|
  assert_scenario_not_reported_as_failing(scenario_name)
end

Then /^the step "([^"]*)" passes$/ do |pattern|
  assert_passed(pattern)
end

Then /^the step "([^"]*)" is skipped$/ do |pattern|
  assert_skipped(pattern)
end

Then /^the feature passes$/ do
  assert_no_partial_output(failed_output, all_output)
  assert_success true
end

Then /^the failure message "([^"]*)" is output$/ do |message|
  assert_partial_output(message, all_output)
  assert_success false
end

Then /^the World variable should have contained (\d+) at the end of the (|first |second )scenario$/ do |value, scenario_number|
  time = scenario_number == "2" ? 2 : 1
  assert_world_variable_held_value_at_time value, time
end

Then /^the World function should have been called$/ do
  assert_world_function_called
end
