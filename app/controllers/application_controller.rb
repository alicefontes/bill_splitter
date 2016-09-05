class ApplicationController < ActionController::Base
  def show
  end

  def split_value
    @valorTotal = params[:valorTotal].to_f
    @numPessoas = params[:numPessoas].to_i
    @resposta = @valorTotal/@numPessoas
    render 'show'
  end
end
