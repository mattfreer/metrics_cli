Feature: Execute GET Request
  I want a command line client for an existing JSON Web API
  It shall except a single argument, which will be the URL of the Web API to use.

  Scenario: Basic UI
    When I get help for "metrics"
    Then the exit status should be 0
    And the banner should be present
    And there should be a one line summary of what the app does
    And the banner should include the version
    And the banner should document that this app takes options
    And the banner should document that this app's arguments are:
      |url|which is required|
    And the following options should be documented:
      |--pretty|

  Scenario: Valid API URL
    When I run `metrics http://localhost:4567`
    Then the stdout should contain "METRIC:"

  Scenario: Valid API URL with --pretty
    When I run `metrics http://localhost:4567 --pretty`
    Then the stdout should contain "+---"

  Scenario: Invalid API URL
    When I run `metrics foobar`
    Then the exit status should be 1
    Then the stderr should contain "Not an URL or IP address"

