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
      c = CalculadoraRuby::Calc.new
      expression = "#{@price}*#{@quantity}/#{@number_of_people_sharing}"
      @total = "Valor total: #{@price*@quantity.round(2)}"
      @answer = "Total para cada um: #{(c.calcular(expression)).round(2)}"
    end

    @product = Product.new_product params
    render 'newproduct'
  end

  def list
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
    Product.save_edition params[:item], params
    redirect_to view_path(item: params[:item])
  end
end
