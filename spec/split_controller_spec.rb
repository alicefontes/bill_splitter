require 'rails_helper'

describe SplitController, type: :controller do
	describe "calculando" do

		describe "show" do
			it "tudo ok?" do
				get :show
				expect(response.status).to eq(200)
			end
		end

		describe "split value" do
			context "com parâmetros válidos" do
				subject do
					post :split_value, params: { :item => "40", :quantidade => "2", :numPessoas => "2" }
				end

				it "tudo ok?" do
					subject
					expect(response.status).to eq(200)
				end

				it "fazendo a conta certo?" do
					subject
					expect(assigns(:resposta)).to eq 40
				end

				it "renderizando?" do
					expect(subject).to render_template("show")
				end
			end

			context "com parâmetros inválidos" do
				it "deveria retornar 0.0 se os parâmetros fossem vazios" do
					post :split_value, params: { :item => "", :quantidade => "", :numPessoas => "" }
					expect(assigns(:resposta)).to eq 0.0
				end

				it "deveria retornar 0.0 sem parâmetros" do
					post :split_value
					expect(assigns(:resposta)).to eq 0.0
				end
			end
		end
	end
end
