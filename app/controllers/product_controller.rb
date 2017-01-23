class ProductController < ApplicationController
  def show
  end

  def new
    @price = params[:price].to_f.round(2)
    @quantity = params[:quantity].to_i
    @number_of_people_sharing = params[:number_of_people_sharing].to_i

    if params[:quantity].blank? || params[:number_of_people_sharing].blank?
      @answer = 0.0
    else
      calculator = CalculadoraRuby::Calc.new
      expression = "#{@price}*#{@quantity}/#{@number_of_people_sharing}"
      @total = "Valor total: #{@price*@quantity.round(2)}"
      @answer = "Total para cada um: #{(calculator.calcular(expression)).round(2)}"
    end
    @product = Product.new_product product_params
    render 'newproduct'
  end

  def list
    @title = "list"
    @renderme = Product.all
    render 'list'
  end

  def view
    @single_product = Product.visualize params[:item]
    render 'view'
  end

  def delete
    Product.exclude params[:item]
    render 'deleted'
  end

  def edit
    @single_product = Product.visualize params[:item]
    render 'editor'
  end

  def save_edit
    Product.save_edition params[:item], product_params
    redirect_to view_path(item: params[:item])
  end

  def drunk
    render 'drinking'
  end

  def result
    @beer_quantity = params[:beer_quantity].to_i
    render 'newresult'
  end

  def product_params
    params.permit(:id, :name, :price, :quantity, :number_of_people_sharing, :new_name, :new_price, :new_quantity, :new_number_of_people_sharing, :beer_quantity)
  end
end
