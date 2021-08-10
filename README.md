# Bulk Discounts

## Table of Contents

- [Background and Description](#background-and-description)
- [Learning Goals](#learning-goals)
- [Setup](#setup)
- [Bulk Discounts](#bulk-discounts)
- [Database Schema](#database-schema)
- [Tools Used](#tools-used)
- [Contributor](#contributor)

## Background and Description

This project is an extension of the Little Esty Shop group project. You will add functionality for merchants to create bulk discounts for their items. A “bulk discount” is a discount based on the quantity of items the customer is buying, for example “20% off orders of 10 or more items”.

## Learning Goals

- Write migrations to create tables and relationships between tables
- Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
- Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
- Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
- Write model tests that fully cover the data logic of the application
- Write feature tests that fully cover the functionality of the application

## Setup

This project is an extension of Little Esty Shop. Students have two options for setup:

- If your Little Esty Shop project is complete, you can use it as a starting point for this project. If you are not the repo owner, fork the project to your account. If you are the repo owner, you can work off the repo without forking, just make sure your teammates have a chance to fork before pushing any commits to your repo
- If your Little Esty Shop project is not complete, fork this repo as a starting point for this project.


## Bulk Discounts

Bulk Discounts are subject to the following criteria:

- Bulk discounts should have a percentage discount as well as a quantity threshold
- Bulk discounts should belong to a Merchant
- A Bulk discount is eligible for all items that the merchant sells. Bulk discounts for one merchant should not affect items sold by another merchant
- Merchants can have multiple bulk discounts
- If an item meets the quantity threshold for multiple bulk discounts, only the one with the greatest percentage discount should be applied
- Bulk discounts should apply on a per-item basis
- If the quantity of an item ordered meets or exceeds the quantity threshold, then the percentage discount should apply to that item only. Other items that did not meet the quantity threshold will not be affected.
- The quantities of items ordered cannot be added together to meet the quantity thresholds, e.g. a customer cannot order 1 of Item A and 1 of Item B to meet a quantity threshold of 2. They must order 2 or Item A and/or 2 of Item B

## Database Schema
![Screen Shot 2021-08-10 at 3 29 01 PM](https://user-images.githubusercontent.com/81600649/128937719-868e8e90-bd46-4835-a403-68ea293f2cd0.png)

## Tools Used

| Development | Testing       | Gems          |
|   :----:    |    :----:     |    :----:     |
| Ruby 2.7.2  | RSpec         | SimpleCov     |
| Rails       |               | Pry           |
| HTML5       |               | Capybara      |
| CSS3        |               | ShouldaMatcher|
| VSCode      |               | Launchy       |
| Atom        |               | Orderly       |
| NagerDate   |               |               |


## Contributor
👤  **Carina Sweet**
- [GitHub](https://github.com/chsweet)
- [LinkedIn](https://www.linkedin.com/in/carina-h-sweet/)
