# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# amazing_amazon_march_2021
Labs project Cohort 40

We will update the model Product.rb as shown in solution

We will test by creating product in rails console like this:

product=Product.create({title:"banana-1",description:"Healthy Fruit"})

But it will create a product with capitalize title and price = 1.0 like this:

<Product id: 1003, title: "Banana-1", description: "Healthy Fruit", price: 1.0, created_at: "2019-10-22 16:29:46", updated_at: "2019-10-22 16:29:46">

#Product model custom methods

Where created a scope, similar to arrow functions in node which searches a word in title, example in rails console:

Product.search('apple')

#CRUD: New and Create

$>rails g controller Products new create 

Here g is the sugar syntax of generate.
Note: Contoller should be always in plural form like: Products
