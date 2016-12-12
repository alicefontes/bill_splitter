require 'rails_helper'
require 'spec_helper'
require 'vcr_setup'

describe ProductController, type: :controller do

	# describe "test new product" do
	# 	context "ok?" do
	# 		let :new_products do
	# 			VCR.use_cassette('lista') do
	# 				post :new
	# 				#(name: "alo", quantity: 2, price: 20, number_of_people_sharing: 2)
	# 			end
	# 		end
	# 		it "render" do
	# 			expect(new_products.status).to eq(200)
	# 		end
	# 	end
	# end

	describe "controller test" do

		context "when listing the products" do
			let (:fake_new_product) do
				{ name: 'Product 1', price: 20, quantity: 2, number_of_people_sharing: 3 }
			end

			before do
				allow(Product).to receive(:new_product).and_return(fake_new_product)

				post :new , fake_new_product
			end

			it "verifies if the status is right" do
				expect(response.status).to eq(200)
			end

			it "verifies if it is rendering right" do
				expect(response).to render_template('newproduct')
			end
		end

		##
		context "when listing the products" do
			before do
				allow(Product).to receive(:all).and_return([
					{
						name: 'Product 1',
						price: 20
					},
					{
						name: 'Product 2',
						price: 10
					}
				])

				get :list
			end

			it "verifies if the status is right" do
				expect(response.status).to eq(200)
			end

			it "verifies if it is rendering right" do
				expect(response).to render_template('list')
			end

			it "verifies how many items are on the list" do
				expect(assigns(:renderme).size).to eq(2)
			end
		end
	end

	context "when showing one product" do
		let (:fake_product_id) {"44353353535"}
		before do
			expect(Product).to receive(:visualize).with(fake_product_id).and_return({
					name: 'Product 1',
					price: 20,
					quantity: 2,
					number_of_people_sharing: 3
				})

				get :view , item: fake_product_id
		end

		it "check if gets 200 status" do
			expect(response.status).to eq(200)
		end

		it "verifies if it is rendering right" do
			expect(response).to render_template('view')
		end
	end

	context "when deleting one product" do
		let (:fake_product_id) {"44353353535"}
		before do
			expect(Product).to receive(:exclude).with(fake_product_id)

			delete :delete , item: fake_product_id
		end

		it "check if gets 200 status" do
			expect(response.status).to eq(200)
		end

		it "verifies if it is rendering right" do
			expect(response).to render_template('deleted')
		end
	end
	#
	# context "when editing one product" do
	# 	let (:fake_product_id) {"44353353535"}
	# 	let (:parameters_edition) do { name: "Batata", price: 30, number_of_people_sharing: 2, quantity: 2 }
	# 	end
	# 	before do
	# 		expect(Product).to receive(:save_edition).with(fake_product_id, parameters_edition).and_return(200)
	# 	end
	#
	# 	it "check if gets 200 status" do
	# 		put :save_edit , item: fake_product_id
	# 		expect(response.status).to eq(200)
	# 	end
	# end
	#

	###########################################################
	# describe "test render view" do
	# 	context "ok?" do
	# 		let :view_product do
	# 			VCR.use_cassette('lista') do
	# 				get :view
	# 				# como passar o parametro?
	# 				# "5833583505c1fa00040fecc1"
	# 			end
	# 		end
	# 		it "ok?" do
	# 			expect(view_product.status).to eq(200)
	# 		end
	# 	end
	# end

	# describe "test render delete" do
	# 	context "ok?" do
	# 		let :delete_product do
	# 			VCR.use_cassette('lista') do
	# 				delete :delete
		# "5833583505c1fa00040fecc1"
	# 			end
	# 		end
	# 		it "ok?" do
	# 			# expect(delete_product.status).to eq(200)
	# 		end
	# 	end
	# end
	#
	# describe "test render edit" do
	# 	context "ok?" do
	# 		let :edit_product do
	# 			VCR.use_cassette('lista') do
	# 				put :edit
		# "5833583505c1fa00040fecc1"
	# 			end
	# 		end
	# 		it "ok?" do
	# 			# expect(edit_product.status).to eq(200)
	# 		end
	# 	end
	# end
	#
	# 		# VCR.use_cassette('teste') do
	# 		#
	# 		# end
	# 		#
	# 		# it 'records an http request', :vcr do
	# 		# 	expect(make_http_request).to eq(200)
	# 		# end
	#
	# 		it 'verifies an http request' do
	# 			expect(produto.empty?).to eq(false)
	# 		end
	# 	end
	# end
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
