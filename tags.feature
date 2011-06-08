Feature: Tags
  In order to be able to run certain tagged tests
  As a developer
  I want to be able to specify which tags to run(or not run)

  Scenario: Run all tests with the tag '@sample-tag'
    Given the following feature:
      """
      @parent-tag
      Feature: Sample
        
        @sample-tag
        Scenario: Sample scenario
          Given passing
        
        @another-sample-tag
        Scenario: Another sample scenario
          Given passing
          
        @sample-tag @another-sample-tag
        Scenario: Yet another sample scenario
          Given passing
      """
    And the following feature:
      """
      @another-parent-tag
      Feature: Second Sample
        
        Scenario: Second Sample scenario
          Given passing
        
        @sample-tag
        Scenario: Holy cow, another sample scenario
          Given passing
          
        Scenario: Oh god when will it stop sample scenario
          Given passing
      """
    When I run cucumber with tags "@sample-tag"
    Then it should pass with exactly:
      """
      @parent-tag
      Feature: Sample
      
        @another-sample-tag
        Scenario: Another sample scenario
          Given passing
          
      @another-parent-tag
      Feature: Second Sample    
          
        @sample-tag
        Scenario: Holy cow, another sample scenario
          Given passing
        
      3 scenarios (3 passed)
      3 steps (3 passed)
      0m3.750s
      """
  
  Scenario: Run all tests without the tag '@sample-tag'
    Given the following feature:
      """
      @parent-tag
      Feature: Sample
        
        @sample-tag
        Scenario: Sample scenario
          Given passing
        
        @another-sample-tag
        Scenario: Another sample scenario
          Given passing
          
        @sample-tag @another-sample-tag
        Scenario: Yet another sample scenario
          Given passing
      """
    And the following feature:
      """
      @another-parent-tag
      Feature: Second Sample
        
        Scenario: Second Sample scenario
          Given passing
        
        @sample-tag
        Scenario: Holy cow, another sample scenario
          Given passing
          
        Scenario: Oh god when will it stop sample scenario
          Given passing
      """
    When I run cucumber with tags "~@sample-tag"
    Then it should pass with exactly:
      """
      @parent-tag
      Feature: Sample
      
        @sample-tag
        Scenario: Sample scenario
          Given passing
      
      @another-parent-tag
      Feature: Second Sample
        
        Scenario: Second Sample scenario
          Given passing
        
        Scenario: Oh god when will it stop sample scenario
          Given passing
        
      3 scenarios (3 passed)
      3 steps (3 passed)
      0m3.750s
      """
      
  Scenario: Run all tests with the feature tag '@parent-tag'
    Given the following feature:
      """
      @parent-tag
      Feature: Sample
        
        @sample-tag
        Scenario: Sample scenario
          Given passing
        
        @another-sample-tag
        Scenario: Another sample scenario
          Given passing
          
        @sample-tag @another-sample-tag
        Scenario: Yet another sample scenario
          Given passing
      """
    And the following feature:
      """
      @another-parent-tag
      Feature: Second Sample
        
        Scenario: Second Sample scenario
          Given passing
        
        @sample-tag
        Scenario: Holy cow, another sample scenario
          Given passing
          
        Scenario: Oh god when will it stop sample scenario
          Given passing
      """
    When I run cucumber with tags "@parent-tag"
    Then it should pass with exactly:
      """
      @parent-tag
      Feature: Sample
        
        @sample-tag
        Scenario: Sample scenario
          Given passing
        
        @another-sample-tag
        Scenario: Another sample scenario
          Given passing
          
        @sample-tag @another-sample-tag
        Scenario: Yet another sample scenario
          Given passing
          
      3 scenarios (3 passed)
      3 steps (3 passed)
      0m3.750s
      """
      
  Scenario: Run all the tests with the tags '@sample-tag' OR '@another-sample-tag'
    Given the following feature:
      """
      @parent-tag
      Feature: Sample
        
        @sample-tag
        Scenario: Sample scenario
          Given passing
        
        @another-sample-tag
        Scenario: Another sample scenario
          Given passing
          
        @sample-tag @another-sample-tag
        Scenario: Yet another sample scenario
          Given passing
      """
    And the following feature:
      """
      @another-parent-tag
      Feature: Second Sample
        
        Scenario: Second Sample scenario
          Given passing
        
        @sample-tag
        Scenario: Holy cow, another sample scenario
          Given passing
          
        Scenario: Oh god when will it stop sample scenario
          Given passing
      """
    When I run cucumber with tags "@parent-tag,@another-sample-tag"
    Then it should pass with exactly:
      """
      @parent-tag
      Feature: Sample
        
        @sample-tag
        Scenario: Sample scenario
          Given passing
        
        @another-sample-tag
        Scenario: Another sample scenario
          Given passing
          
        @sample-tag @another-sample-tag
        Scenario: Yet another sample scenario
          Given passing
          
      @another-parent-tag
      Feature: Second Sample
        
        @sample-tag
        Scenario: Holy cow, another sample scenario
          Given passing
      
      4 scenarios (4 passed)
      4 steps (4 passed)
      0m3.750s
      """
