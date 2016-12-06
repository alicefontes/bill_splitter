class Product < ApplicationRecord
  def self.new_product
    r = RestClient.post "#{Settings.url}/items", name: params[:name], price: params[:price], quantity: params[:quantity], number_of_people_sharing: params[:number_of_people_sharing]
    JSON.parse(r.body)
  end

  def self.all
    r = RestClient.get("#{Settings.url}/items")
    JSON.parse(r.body)
  end

  def self.visualize params
    r = RestClient.get("#{Settings.url}/item/#{params[:item]}")
    JSON.parse(r.body)
  end

  def self.exclude params
    RestClient.delete("#{Settings.url}/item/#{params[:item]}")
  end

  def self.editing params
    r = RestClient.get("#{Settings.url}/item/#{params[:item]}")
    JSON.parse(r.body)
  end

  def self.save_edition params
    r = RestClient.put "#{Settings.url}/item/#{params[:item]}", name: params[:new_name], price: params[:new_price], quantity: params[:new_quantity], number_of_people_sharing: params[:new_number_of_people_sharing]
    puts JSON.parse(r.body)
  end
end
