require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :id, :title, :price
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT into films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

   def self.all()
     sql = "SELECT * FROM films"
     films = SqlRunner.run(sql)
     return films.map { |film| Film.new(film) }
   end

  def delete_film()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
            INNER JOIN tickets
            ON tickets.customer_id = $1
            ORDER BY name"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
  end

  def how_many_customers()
    return self.customers.count
  end






end
