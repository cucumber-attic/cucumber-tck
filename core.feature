Feature: Core feature elements
  In order to have automated acceptance tests
  As a developer
  I want Cucumber to run core feature elements

  Scenario: Feature headers
    Given the following scenario:
      """
      Feature: a feature
        In order to get results
        As a user
        I want to do something
      """
    When Cucumber runs the feature
    Then the feature should have passed

  Scenario: Simple flat steps
    Given the following scenario:
      """
      Given a calculator
      When the calculator computes PI
      Then the calculator returns PI
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed

  Scenario: Given, When, Then, And and But steps
    Given the following scenario:
      """
      Given a calculator
      When the calculator adds up 1 and 2
      And the calculator adds up 3 and 0.14159265
      Then the calculator returns PI
      But the calculator does not return 3
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed


  Scenario: Single-parameter step
    Given the following scenario:
      """
      Given a calculator
      When the calculator computes PI
      Then the calculator returns "3.14159265"
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed

  Scenario: Two-parameter step
    Given the following scenario:
      """
      Given a calculator
      When the calculator adds up "12" and "51"
      Then the calculator returns "63"
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed

  Scenario: Three-parameter step
    Given the following scenario:
      """
      Given a calculator
      When the calculator adds up "3", "4" and "5"
      Then the calculator returns "12"
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed

  Scenario: Steps accepting a DocString parameter
    Given the following scenario:
      """
      Given a calculator
      When the calculator adds up the following numbers:
        \"\"\"
        3
        6
        1
        \"\"\"
      Then the calculator returns "10"
      """
    When Cucumber runs the scenario with steps for a calculator
    Then the scenario should have passed
