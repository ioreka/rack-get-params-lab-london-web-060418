class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.length < 1
        resp.write "Your cart is empty"
      else
        resp.write "Your cart contains:"
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      if @@items.include?(search_term)
        @@cart << search_term
        resp.write "added #{search_term} to cart."
      else
        resp.write "We don't have that item."
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
end
