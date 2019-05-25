require_relative("../db/sql_runner.rb")


class Customer

  attr_accessor :name, :funds, :id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end



  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer =  SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    all_customers = SqlRunner.run(sql)
    return all_customers.map { |customer| Customer.new(customer) }
  end

  def delete_customer()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
           INNER JOIN tickets
           ON tickets.film_id = $1
           ORDER BY title"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film) }


  end

  def tickets()
    sql = " SELECT * FROM tickets where film_id = $1"
    values = [@id]
    ticket_data = SqlRunner.run(sql, values)
    return ticket_data.map { |ticket| Ticket.new(ticket) }
  end

  def money_left()
    tickets = self.films()
    ticket_price = tickets.map { |ticket| ticket.price.to_i }
    return @funds - ticket_price[1]
  end


end
