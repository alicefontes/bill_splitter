require 'rails_helper'
require 'spec_helper'
require 'vcr_setup'

describe ProductController, type: :controller do

	describe "controller test" do

		context "when adding a new product" do
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

		context "when adding a new product with no name" do
			let (:fake_new_product) do
				{ name: '', price: 20, quantity: 2, number_of_people_sharing: 3 }
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

		context "when adding a new product with blank quantity" do
			let (:fake_new_product) do
				{ name: 'blank quantity', price: 20, quantity: nil, number_of_people_sharing: 3 }
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

		context "when adding a new product with blank number_of_people_sharing" do
			let (:fake_new_product) do
				{ name: 'blank', price: 20, quantity: 3, number_of_people_sharing: nil }
			end

			before do
				allow(Product).to receive(:new_product).and_return(fake_new_product)

				post :new , fake_new_product
			end

			it "verifies if the status is right and if its rendering right" do
				expect(response.status).to eq(200)
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
end
