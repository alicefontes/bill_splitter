require 'rails_helper'

describe SplitController, type: :controller do
	context "with valorTotal and numPessoas"do
		# it "calculates the total value" do
		# 	# splitController = SplitController.new
		# 	# splitController.split_value.valorTotal = "40"
		# 	# splitController.split_value.numPessoas = "2"
		# 	# expect(splitController.split_value.resposta).to eq 20
		# 	get :show
		# 	binding.pry
		# end
	end

	it "tudo ok no show?" do
		get :show
		expect(response.status).to eq(200)
	end

	it "tudo ok no split value?" do
		get :split_value
		expect(response.status).to eq(200)
	end
	# 
	# it "fazendo a conta certo?" do
	# 	get :split_value, params: { :item => "40", :quantidade => "2", :numPessoas => "2" }
	# 	# binding.pry
	# 	expect(resposta).to eq (40)
	# end

subject { get :split_value }

	it "renderizando?" do
		expect(subject).to render_template("show")
	end

end
