Feature: Data Tables

  Scenario: a data table interpreted as an array
    Given a scenario with:
      """
      Given the following cukes:
        | Cucumis sativus | Cucumber     |
        | Cucumis anguria | Burr Gherkin |
      """
    And the step "the following cukes:" has a passing mapping that receives a data table
    When Cucumber executes the scenario
    Then the scenario passes
    And the received data table array equals the following:
      """
      [
        [ "Cucumis sativus", "Cucumber" ],
        [ "Cucumis anguria", "Burr Gherkin" ]
      ]
      """
