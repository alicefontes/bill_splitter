class SplitController < ApplicationController
  def show
  end

  def new
    @price = params[:price].to_f
    @quantity = params[:quantity].to_i
    @number_of_people_sharing = params[:number_of_people_sharing].to_i

    if params[:quantity].blank? || params[:number_of_people_sharing].blank?
      @answer = 0.0
    else
      c = CalculadoraRuby::Calc.new
      expression = "#{@price}*#{@quantity}/#{@number_of_people_sharing}"
      @answer = (c.calcular(expression)).round(2)
    end

    r = RestClient.post "http://localhost:8000/items" , name: params[:name], price: params[:price], quantity: params[:quantity], number_of_people_sharing: params[:number_of_people_sharing]
    JSON.parse(r.body)

    render 'show'
  end

  def list
    r = RestClient.get('http://localhost:8000/items')
    @renderme = JSON.parse(r.body)

    render 'show'
  end

  def view
    r = RestClient.get("http://localhost:8000/item/#{params[:item]}")
    @single_product = JSON.parse(r.body)
    render 'show'
  end
end
