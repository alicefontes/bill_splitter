require 'rails_helper'
require 'spec_helper'
require 'vcr_setup'

RSpec.describe Product, type: :model do

  before do
    Rails.env = "test"
  end

	describe "basic test" do
		context "new product ok?" do
			let :produto do
				VCR.use_cassette('teste_new') do
          Product.new_product name: "alo", quantity: 2, price: 20, number_of_people_sharing: 2
				end
			end

			it 'verifies an http request' do
				expect(produto.empty?).to eq(false)
			end

      it 'verifies not empty' do
        expect(produto["name"]).to eq("alo")
      end
		end

    context "show all ok?" do
			let :products do
				VCR.use_cassette('teste_all') do
          Product.all
				end
			end

			it 'verifies not empty' do
				expect(products.empty?).to eq(false)
			end
      # it 'verifies name' do
      #   expect(produtos).to eq()
      # end
      #o que eu preciso verificar aqui?
		end
	end

  context "show one ok?" do
    let :shown_product do
      VCR.use_cassette('show_one_product') do
        Product.visualize "5833583505c1fa00040fecc1"
      end
    end

    it 'verifies show' do
      expect(shown_product["id"]).to eq("5833583505c1fa00040fecc1")
    end
  end

  context "delete ok?" do
    let :product_deleted do
      VCR.use_cassette('delete_product') do
        Product.exclude "5833583505c1fa00040fecc1"
      end
    end

    it 'verifies delete' do
      expect(product_deleted["id"]).to eq(nil)
    end
  end

  # context "edit ok?" do
  #   let :product_edited do
  #     VCR.use_cassette('editing_product2') do
  #       Product.editing "5833583505c1fa00040fecc1"
  #     end
  #   end
  #
  #   it 'verifies edit' do
  #     expect(product_edited["id"]).to eq("5833583505c1fa00040fecc1")
  #   end
  # end
  #
  # context "edit ok?" do
  #   let :product_edited_saved do
  #     VCR.use_cassette('editing_product6') do
  #       Product.save_edition item: "5833583505c1fa00040fecc1", new_name: "novo nome", new_quantity: 2, new_price: 20, new_number_of_people_sharing: 2
  #     end
  #   end
  #
  #   it 'verifies edit' do
  #     expect(product_edited_saved["name"]).to eq("novo nome")
  #   end
  # end

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
