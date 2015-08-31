#language: en

@critical
Feature: import_data

In order to have stats data on a DB
As a system user
I want to populate it with different kind of existing data

Scenario: Populate DB with a local CSV file 
Given an existing and valid CSV data file
When I launch the dedicated rake task
Then I should import successfully the data
