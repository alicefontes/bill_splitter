class Product < ApplicationRecord
  def self.new_product
    r = RestClient.post "#{Settings.url}/items", name: params[:name], price: params[:price], quantity: params[:quantity], number_of_people_sharing: params[:number_of_people_sharing]
    JSON.parse(r.body)
  end

  def self.all
    r = RestClient.get("#{Settings.url}/items")
    JSON.parse(r.body)
  end

  def self.visualize
    r = RestClient.get("#{Settings.url}/item/#{params[:item]}")
    JSON.parse(r.body)
  end

  def self.exclude
    RestClient.delete("#{Settings.url}/item/#{params[:item]}")
  end

  def self.editing
    r = RestClient.get("#{Settings.url}/item/#{params[:item]}")
    JSON.parse(r.body)
  end

  def self.save_edition
    r = RestClient.put "#{Settings.url}/item/#{params[:item]}", name: params[:new_name], price: params[:new_price], quantity: params[:new_quantity], number_of_people_sharing: params[:new_number_of_people_sharing]
    puts JSON.parse(r.body)
  end
end
