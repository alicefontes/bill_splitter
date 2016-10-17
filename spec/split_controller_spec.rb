require 'rails_helper'

describe SplitController, type: :controller do

	describe "show option" do
		context "has 200 status code if requested" do
		subject { response.status }

		before { get :show }

		it { is_expected.to eq 200 }
		end
	end

	describe "split value" do
		context "with valid params" do
			subject { response.status }

			before do
				post :split_value, params: { :item => "40", :quantity => "2", :number_of_people_sharing => "2" }
			end

			context "has 200 status code if requested" do
				it { is_expected.to eq 200 }
			end

			context "doing the math right" do
				it { expect(assigns(:answer)).to eq 40 }
			end

			context "rendering" do
				it { expect(subject).to render_template("show") }
			end
		end

		context "with invalid params" do
			before do
				post :split_value, params: { :item => "", :quantity => "", :number_of_people_sharing => "" }
			end

			context "should return 0.0 if the parameters are empty" do
				it { expect(assigns(:answer)).to eq 0.0 }
			end

			context "should return 0.0 without parameters" do
				before do
					post :split_value
				end

				it { expect(assigns(:answer)).to eq 0.0}
			end
		end
	end
end
