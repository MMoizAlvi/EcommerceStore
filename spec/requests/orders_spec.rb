require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user_test) { FactoryBot.create(:user) }
  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product, user: user) }
  let(:order) { FactoryBot.create(:order, user: user) }

  describe "GET new" do
    it 'test new order method user signed in' do
      sign_in(user)
      get new_product_cart_order_path(cart, product), params: { order: { user: user }, format: :json }
      expect(response).to have_http_status(204)
    end
  end

  describe "POST create" do
    it 'create order when user signed in' do
      sign_in(user)
      post product_cart_orders_path(cart, product)
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eq('Order Created!')
    end

    it 'redirect to login order when user not signed in' do
      post product_cart_orders_path(cart, product)
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eq('Please sign_in/sign_up first!')
    end

    it 'failed to create order when user signed in' do
      sign_in(user)
      allow_any_instance_of(Order).to receive(:save) { false }
      post product_cart_orders_path(cart, product)
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to be_truthy
    end
  end

  describe "GET show" do
    it 'shows order to current user' do
      sign_in(user)
      get product_cart_order_path(cart, product, order)
      expect(response).to have_http_status(:ok)
    end

    it 'failed to show the order to user' do
      get product_cart_order_path(cart, product, order)
      expect(response).to have_http_status(:redirect)
    end
  end
end
