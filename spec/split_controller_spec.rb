require 'rails_helper'

describe SplitController, type: :controller do
	context "calculando" do

	it "tudo ok no show?" do
		get :show
		expect(response.status).to eq(200)
	end

	it "tudo ok no split value?" do
		get :split_value
		expect(response.status).to eq(200)
	end

	it "fazendo a conta certo?" do
		get :split_value, params: { :item => "40", :quantidade => "2", :numPessoas => "2" }
		# binding.pry
		expect(assigns(:resposta)).to eq 40
	end

subject { get :split_value }

	it "renderizando?" do
		expect(subject).to render_template("show")
	end

	end
end
