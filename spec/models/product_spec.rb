require 'rails_helper'
require 'spec_helper'
require 'vcr_setup'

RSpec.describe Product, type: :model do

	describe "basic test" do
		context "ok?" do
			let :produto do
				Rails.env = "test"
				VCR.use_cassette('teste2') do
          Product.new_product name: "alo", quantity: 2, price: 20, number_of_people_sharing: 2
				end
			end

			#
			# it 'records an http request', :vcr do
			# 	expect(make_http_request).to eq(200)
			# end

			it 'verifies an http request' do
				expect(produto.empty?).to eq(false)
			end
		end
	end


	# describe "show option" do
	# 	context "has 200 status code if requested" do
	# 	subject { response.status }
	#
	# 	before { get :show }
	#
	# 	it { is_expected.to eq 200 }
	# 	end
	# end
	#
	# describe "split value" do
	# 	context "with valid params" do
	# 		subject { response.status }
	#
	# 		before do
	# 			post :split_value, params: { :item => "40", :quantity => "2", :number_of_people_sharing => "2" }
	# 		end
	#
	# 		context "has 200 status code if requested" do
	# 			it { is_expected.to eq 200 }
	# 		end
	#
	# 		context "doing the math right" do
	# 			it { expect(assigns(:answer)).to eq 40 }
	# 		end
	#
	# 		context "rendering" do
	# 			it { expect(subject).to render_template("show") }
	# 		end
	# 	end
	#
	# 	context "with invalid params" do
	# 		before do
	# 			post :split_value, params: { :item => "", :quantity => "", :number_of_people_sharing => "" }
	# 		end
	#
	# 		context "should return 0.0 if the parameters are empty" do
	# 			it { expect(assigns(:answer)).to eq 0.0 }
	# 		end
	#
	# 		context "should return 0.0 without parameters" do
	# 			before do
	# 				post :split_value
	# 			end
	#
	# 			it { expect(assigns(:answer)).to eq 0.0}
	# 		end
	# 	end
	# end
end
