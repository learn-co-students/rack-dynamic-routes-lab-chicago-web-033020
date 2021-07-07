
class Application

# Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
  def call(env)
    response = Rack::Response.new
    request = Rack::Request.new(env)

    if request.path.match(/items/)
      item_name = request.path.split("/items/").last
      ##turn /items/something into something
      item = @@items.find { |item| item.name == item_name }
      # 如果 item，
      # 也就是 @@items.find { |item| item.name == item_name }
        # https://blog.csdn.net/weixin_33807284/article/details/92367062
        # find返回满足条件的第一条记录，而select返回满足条件的全部记录
      # 被找出来了 =》 存在
      if item
      # If a user requests /items/<Item Name> 
      # it should return the price of that item
      response.write item.price
      response.status = 200
      else
# IF a user requests an item that you don't have, then return a 400 and an error message
      response.write "Item not found"
      response.status = 400
      end
    else
      response.write "Route not found"
      response.status = 404
    end
    response.finish
  end
end
