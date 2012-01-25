@slides
Feature: Slides
  In order to have slides on my website
  As an administrator
  I want to manage slides

  Background:
    Given I am a logged in refinery user
    And I have no slides

  @slides-list @list
  Scenario: Slides List
   Given I have slides titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of slides
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @slides-valid @valid
  Scenario: Create Valid Slide
    When I go to the list of slides
    And I follow "Add New Slide"
    And I fill in "Text" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 slide

  @slides-invalid @invalid
  Scenario: Create Invalid Slide (without text)
    When I go to the list of slides
    And I follow "Add New Slide"
    And I press "Save"
    Then I should see "Text can't be blank"
    And I should have 0 slides

  @slides-edit @edit
  Scenario: Edit Existing Slide
    Given I have slides titled "A text"
    When I go to the list of slides
    And I follow "Edit this slide" within ".actions"
    Then I fill in "Text" with "A different text"
    And I press "Save"
    Then I should see "'A different text' was successfully updated."
    And I should be on the list of slides
    And I should not see "A text"

  @slides-duplicate @duplicate
  Scenario: Create Duplicate Slide
    Given I only have slides titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of slides
    And I follow "Add New Slide"
    And I fill in "Text" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 slides

  @slides-delete @delete
  Scenario: Delete Slide
    Given I only have slides titled UniqueTitleOne
    When I go to the list of slides
    And I follow "Remove this slide forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 slides
 