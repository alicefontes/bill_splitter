require 'rails_helper'

RSpec.describe Product, type: :model do

	describe "model test" do
		context "when creating a new product" do
			let :produto do
				VCR.use_cassette('new_product') do
          Product.new_product name: "alo", quantity: 2, price: 20, number_of_people_sharing: 2
				end
			end

			it 'verifies if it isnt empty' do
				expect(produto.empty?).to eq(false)
			end

      it 'verifies if params were saved right' do
        expect(produto["name"]).to eq("alo")
        expect(produto["price"]).to eq(20)
        expect(produto["quantity"]).to eq(2)
        expect(produto["number_of_people_sharing"]).to eq(2)
      end
		end

    context "when showing all products" do
			let :products do
				VCR.use_cassette('teste_all') do
          Product.all
				end
			end

			it 'verifies if it isnt empty' do
				expect(products.empty?).to eq(false)
			end

#se fizer algo p checar os nomes, cada vez que o banco mudasse o teste iria quebrar
#melhor testar apenas se nao é vazia e se as quantidades sao > 0
      it 'verifies if the list isnt empty' do
        a = 0
        products.each do |p|
          a = a+1
        end
        expect(a).to be > 0
      end

      it 'verifies quantity != 0' do
        products.each do |p|
          expect(p["quantity"]).to be > 0
        end
      end

      it 'verifies number_of_people_sharing != 0' do
        products.each do |p|
          expect(p["number_of_people_sharing"]).to be > 0
        end
      end

      it 'verifies price != 0' do
        products.each do |p|
          expect(p["price"]).to be > 0
        end
      end
		end
	end

  context "when showing one product" do
		let(:product_id) { "583c703a2dceb80004af9040" }
    let :shown_product do
      VCR.use_cassette('show_one_product1') do
        Product.visualize product_id
      end
    end

    it 'verifies id' do
      expect(shown_product["id"]).to eq(product_id)
    end

		it 'verifies params' do
      expect(shown_product["name"]).to eq("Costela")
      expect(shown_product["quantity"]).to eq(1)
      expect(shown_product["number_of_people_sharing"]).to eq(2)
      expect(shown_product["price"]).to eq(60)
    end
  end

  context "when deleting a product" do
		let(:product_id) { "5833583505c1fa00040fecc1" }
    let :product_deleted do
      VCR.use_cassette('delete_product') do
        Product.exclude product_id
      end
    end

    it 'verifies if it has been deleted' do
      expect(product_deleted).to be true
    end
  end

  context "when editing a product" do
    let :product_edited_saved do
      VCR.use_cassette('editing_product6') do
        Product.save_edition "583c72ad2dceb80004af9042", new_name: "novo nome", new_quantity: 3, new_price: 17, new_number_of_people_sharing: 2
      end
    end

    it 'verifies edition checking if the name has been properly saved' do
      expect(product_edited_saved["name"]).to eq("novo nome")
    end
  end

end
