@snippets
Feature: Snippets
  In order to have snippets on my website
  As an administrator
  I want to manage snippets

  Background:
    Given I am a logged in refinery user
    And I have no snippets

  @snippets-list @list
  Scenario: Snippets List
   Given I have snippets titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of snippets
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @snippets-valid @valid
  Scenario: Create Valid Snippet
    When I go to the list of snippets
    And I follow "Add New Snippet"
    And I fill in "Title" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "This is a test of the first string field was successfully added."
    And I should have 1 snippet

  @snippets-invalid @invalid
  Scenario: Create Invalid Snippet (without title)
    When I go to the list of snippets
    And I follow "Add New Snippet"
    And I press "Save"
    Then I should see "Title can't be blank"
    And I should have 0 snippets

  @snippets-edit @edit
  Scenario: Edit Existing Snippet
    Given I have snippets titled "A title"
    When I go to the list of snippets
    And I follow "Edit this snippet" within ".actions"
    Then I fill in "Title" with "A different title"
    And I press "Save"
    Then I should see "'A different title' was successfully updated."
    And I should be on the list of snippets
    And I should not see "A title"

  @snippets-duplicate @duplicate
  Scenario: Create Duplicate Snippet
    Given I only have snippets titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of snippets
    And I follow "Add New Snippet"
    And I fill in "Title" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 snippets

  @snippets-delete @delete
  Scenario: Delete Snippet
    Given I only have snippets titled UniqueTitleOne
    When I go to the list of snippets
    And I follow "Remove this snippet forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 snippets
 
