Feature: Hooks
  Cucumber provides a number of hooks which allow us to run blocks at various
  points in the Cucumber test cycle. You can put them in your support/env.rb
  file or any other file under the support directory, for example in a file
  called support/hooks.rb. There is no association between where the hook is
  defined and which scenario/step it is run for, but you can use tagged hooks
  if you want more fine grained control.

  Scenario: General before hook
    Given a before hook that causes an error
    And a step definition matching /^a step passes$/
    When I run the following feature:
      """
        Feature: A before hook runs before every scenario
          Scenario: The hook runs before this scenario
            Given a step passes

          Scenario: The hook also runs before this scenario
            Given a step passes
      """
    Then the feature should have 2 failing scenarios
    And 2 skipped steps
