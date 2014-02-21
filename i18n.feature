Feature: Internationalization (I18n)

  Cucumber supports feature files written in many different languages.
  A feature written in another than the default language (English) 
  must start with a comment line in the following form
  "# language: <code>"
  where <code> refers to a two-letter (ISO 639-1) language code.

  Scenario: A non-english Feature
    Given the following feature:
      """
      # language: de

      Funktionalität: Ein Feature

        Szenario: Ein Szenario
          Wenn ich "A" sage
          Dann muss ich auch "B" sagen
      """
    When Cucumber runs the feature
    Then the feature passes

  Scenario: Only One Language per File
    The "# language: <code>"-directive is ignored if it is not the
    very first non-empty line in the file.

    Given the following feature:
      """

      Feature: some feature

      # language: de
        Scenario: some scenario
          When I say "A"
          Then I must say "B" as well
      """
    When Cucumber runs the feature
    Then the feature passes

