require 'rails_helper'

RSpec.describe Product, type: :model do

	describe "basic test" do
		context "new product ok?" do
			let :produto do
				VCR.use_cassette('new_product') do
          Product.new_product name: "alo", quantity: 2, price: 20, number_of_people_sharing: 2
				end
			end

			it 'verifies not empty' do
				expect(produto.empty?).to eq(false)
			end

      it 'verifies name' do
        expect(produto["name"]).to eq("alo")
      end

      it 'verifies price' do
        expect(produto["price"]).to eq(20)
      end

      it 'verifies quantity' do
        expect(produto["quantity"]).to eq(2)
      end

      it 'verifies number_of_people_sharing' do
        expect(produto["number_of_people_sharing"]).to eq(2)
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

#se fizer algo p checar os nomes, cada vez que o banco mudasse o teste iria quebrar
#melhor testar apenas se nao é vazia e se as quantidades sao > 0
      it 'verifies not empty list' do
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

  context "show one ok?" do
		let(:product_id) { "5833583505c1fa00040fecc1" }
    let :shown_product do
      VCR.use_cassette('show_one_product') do
        Product.visualize product_id
      end
    end

    it 'verifies show' do
      expect(shown_product["id"]).to eq(product_id)
    end

    it 'verifies quantity != 0' do
      expect(shown_product["quantity"]).to be > 0
    end

    it 'verifies number_of_people_sharing != 0' do
      expect(shown_product["number_of_people_sharing"]).to be > 0
    end

    it 'verifies price != 0' do
      expect(shown_product["price"]).to be > 0
    end
  end

  context "delete ok?" do
    let :product_deleted do
      VCR.use_cassette('delete_product') do
        Product.exclude "5833583505c1fa00040fecc1"
      end
    end

    it 'verifies delete' do
      expect(product_deleted).to be true
    end
  end

  context "edit ok?" do
    let :product_edited_saved do
      VCR.use_cassette('editing_product6') do
        Product.save_edition "583c72ad2dceb80004af9042", new_name: "novo nome", new_quantity: 3, new_price: 17, new_number_of_people_sharing: 2
      end
    end

    it 'verifies edit' do
      expect(product_edited_saved["name"]).to eq("novo nome")
    end
  end

end
