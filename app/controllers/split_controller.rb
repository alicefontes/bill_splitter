class SplitController < ApplicationController
  def show
  end

  def test
    return 2
  end

  def split_value
    @item = params[:item].to_f
    @quantidade = params[:quantidade].to_i
    @numPessoas = params[:numPessoas].to_i
    @resposta = @item*@quantidade/@numPessoas
    render 'show'
  end
end
