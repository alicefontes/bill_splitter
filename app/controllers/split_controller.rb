class SplitController < ApplicationController
  def show
  end

  def new
    @price = params[:price].to_f.round(2)
    @quantity = params[:quantity].to_i
    @number_of_people_sharing = params[:number_of_people_sharing].to_i

    if params[:quantity].blank? || params[:number_of_people_sharing].blank?
      @answer = 0.0
    else
      c = CalculadoraRuby::Calc.new
      expression = "#{@price}*#{@quantity}/#{@number_of_people_sharing}"
      @total = "Valor total: #{@price*@quantity.round(2)}"
      @answer = "Total para cada um: #{(c.calcular(expression)).round(2)}"
    end

    r = RestClient.post "https://infinite-meadow-93515.herokuapp.com/items" , name: params[:name], price: params[:price], quantity: params[:quantity], number_of_people_sharing: params[:number_of_people_sharing]
    # r = RestClient.post "http://localhost:8000/items" , name: params[:name], price: params[:price], quantity: params[:quantity], number_of_people_sharing: params[:number_of_people_sharing]
    JSON.parse(r.body)

    render 'newproduct'
  end

  def list
    r = RestClient.get('https://infinite-meadow-93515.herokuapp.com/items')
    # r = RestClient.get('http://localhost:8000/items')
    # r = RestClient.get('#{Rails.application.config_for(:url)}/items')
    @renderme = JSON.parse(r.body)

    render 'list'
  end

  def view
    r = RestClient.get("https://infinite-meadow-93515.herokuapp.com/item/#{params[:item]}")
    # r = RestClient.get("http://localhost:8000/item/#{params[:item]}")
    @single_product = JSON.parse(r.body)
    render 'view'
  end

  def delete
    RestClient.delete("https://infinite-meadow-93515.herokuapp.com/item/#{params[:item]}")
    # RestClient.delete("http://localhost:8000/item/#{params[:item]}")
    render 'deleted'
  end

  def edit
    r = RestClient.get("https://infinite-meadow-93515.herokuapp.com/item/#{params[:item]}")
    # r = RestClient.get("http://localhost:8000/item/#{params[:item]}")
    @single_product = JSON.parse(r.body)
    render 'editor'
  end

  def save_edit
    r = RestClient.put "https://infinite-meadow-93515.herokuapp.com/item/#{params[:item]}" , name: params[:new_name], price: params[:new_price], quantity: params[:new_quantity], number_of_people_sharing: params[:new_number_of_people_sharing]
    # r = RestClient.put "http://localhost:8000/item/#{params[:item]}" , name: params[:new_name], price: params[:new_price], quantity: params[:new_quantity], number_of_people_sharing: params[:new_number_of_people_sharing]
    puts JSON.parse(r.body)

    redirect_to view_path(item: params[:item])
  end
end
