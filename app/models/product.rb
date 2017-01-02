class Product
  def self.new_product params
    response = RestClient.post "#{Settings.url}/items", name: params[:name], price: params[:price], quantity: params[:quantity], number_of_people_sharing: params[:number_of_people_sharing]
    JSON.parse(response.body)
  end

  def self.all
    response = RestClient.get("#{Settings.url}/items")
    JSON.parse(response.body)
  end

  def self.visualize item
    response = RestClient.get("#{Settings.url}/item/#{item}")
    JSON.parse(response.body)
  end

  def self.exclude item
    response = RestClient.delete("#{Settings.url}/item/#{item}")
    response.code == 200
  end

  def self.save_edition item, params
    response = RestClient.put "#{Settings.url}/item/#{item}", name: params[:new_name], price: params[:new_price], quantity: params[:new_quantity], number_of_people_sharing: params[:new_number_of_people_sharing]
    JSON.parse(response.body)
  end
end
