class SplitController < ApplicationController
  def show
  end

  def split_value
    @item = params[:item].to_f
    @quantidade = params[:quantidade].to_i
    @numPessoas = params[:numPessoas].to_i
    if params[:quantidade].blank? || params[:numPessoas].blank?
      @resposta = 0.0
    else
      c = CalculadoraRuby::Calc.new
      expression = "#{@item}*#{@quantidade}/#{@numPessoas}"
      @resposta = (c.calcular(expression)).round(2)
    end
    render 'show'
  end
end
