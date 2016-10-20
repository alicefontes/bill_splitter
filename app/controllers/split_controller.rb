class SplitController < ApplicationController
  def show
  end

  def split_value
    @item = params[:item].to_f
    @quantity = params[:quantity].to_i
    @number_of_people_sharing = params[:number_of_people_sharing].to_i

    if params[:quantity].blank? || params[:number_of_people_sharing].blank?
      @answer = 0.0
    else
      c = CalculadoraRuby::Calc.new
      expression = "#{@item}*#{@quantity}/#{@number_of_people_sharing}"
      @answer = (c.calcular(expression)).round(2)
    end

    render 'show'
  end

  def list
    r = RestClient.get('http://localhost:8000/items')
    @renderme = JSON.parse(r.body)

    render 'show'
  end
end
