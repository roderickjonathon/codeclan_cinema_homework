require_relative( 'models/customer.rb')
require_relative( 'models/film.rb')
require_relative( 'models/ticket.rb')
require('pry')


customer1 = Customer.new({
  "name" => "Sarah",
  "funds" => 40
  })
  customer2 = Customer.new({
    "name" => "Jonny",
    "funds" => 60
    })
    customer1.save()
    customer2.save()

    customer3 = Customer.new({
      "name" => "Yuki",
      "funds" => 4000
      })

      customer3.save()

      customer1.funds = 50
      customer1.update()
      all_customers = Customer.all()
      # customer3.delete_customer()

film1 =  Film.new({
  "title" => "Lord of the Rings",
  "price" => 5
})
    film2 = Film.new({
      "title" => "Eagle vs Shark",
      "price" => 6
    })
      film3 = Film.new({
        "title" => "The Matrix",
        "price" => 8
        })
          film1.save()
          film2.save()
          film3.save()
          film1.price = 7
          film1.update()


ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id

})
  ticket2 = Ticket.new({
    "customer_id" => customer2.id,
    "film_id" => film2.id
    })
    ticket1.save()
    ticket2.save()
    all_tickets = Ticket.all()

























          binding.pry
          nil
