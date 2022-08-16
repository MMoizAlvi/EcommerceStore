require 'rails_helper'
require 'spec_helper'
require 'faker'
require 'devise'

RSpec.describe "CartsController", type: :controller do
  context CartsController do
    let(:user) { FactoryBot.create(:user) }
    let(:user_test) { FactoryBot.create(:user) }
    let(:cart_product) { FactoryBot.create(:cart_product) }
    let(:cart) { FactoryBot.create(:cart) }
    let(:product) { FactoryBot.create(:product, user: user) }

    describe "POST /create" do
      it 'appending products to cart_product with signin' do
        sign_in(user_test)
        expect { post :create, params: {product_id: product.id } }.to change(CartProduct, :count).by(1)
        expect(response).to have_http_status(:found)
        expect(flash[:notice]).to eq('Added to cart!')
      end

      it 'appending products to cart_product without signin' do
        expect { post :create, params: { product_id: product.id } }.to change(CartProduct, :count).by(1)
        expect(response).to have_http_status(:found)
        expect(flash[:notice]).to eq('Added to cart!')
      end

      it 'appending products to cart_product with authentication failed' do
        sign_in(user)
        expect { post :create, params: { product_id: product.id } }.to change(CartProduct, :count).by(0)
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end

      it 'appending products to cart_product failed' do
        allow_any_instance_of(CartProduct).to receive(:save) { false }
        expect { post :create, params: { product_id: product.id } }.not_to change{ CartProduct.count }
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to be_truthy
      end
    end

    describe "PUT /Update" do
      it 'Update quantity for cart_product with sign_in' do
        sign_in(user)
        cart.products << product
        put :update, params: {product_id: product.id, id: cart.id, product: product.id, quantity: 3}, session: {cart_id: cart.id}
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq('cart updated!')
      end

      it 'Update quantity for cart_product without sign_in' do
        cart.products << product
        put :update, params: {product_id: product.id, id: cart.id, product: product.id, quantity: 3}, session: {cart_id: cart.id}
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq('cart updated!')
      end

      it 'Update quantity for cart_product failed' do
        sign_in(user)
        cart.products << product
        allow_any_instance_of(CartProduct).to receive(:save) { false }
        put :update, params: {product_id: product.id, id: cart.id, product: product.id, quantity: 3}, session: {cart_id: cart.id}
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to be_truthy
      end
    end

    describe "DELETE /destroy" do
      it 'remove from cart_product with signin' do
        sign_in(user)
        cart.products << product
        delete :destroy, params: {product_id: product.id, id: cart.id, product: product.id}, session: {cart_id: cart.id}
        expect(response).to have_http_status(:found)
        expect(flash[:notice]).to eq('Product removed from cart!')

      end

       it 'remove from cart_product without signin' do
        cart.products << product
        delete :destroy, params: {product_id: product.id, id: cart.id, product: product.id}, session: {cart_id: cart.id}
        expect(response).to have_http_status(:found)
        expect(flash[:notice]).to eq('Product removed from cart!')
      end

      it 'remove from cart_product failed' do
        sign_in(user)
        cart.products << product
        allow_any_instance_of(CartProduct).to receive(:destroy) { false }
        delete :destroy, params: {product_id: product.id, id: cart.id, product: product.id}, session: {cart_id: cart.id}
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to be_truthy
      end
    end

    describe "GET /show" do
      it 'show cart_product when user signin' do
        sign_in(user)
        get :show, params: { id: cart.id, product_id: product.id}
        expect(response).to have_http_status(:ok)
      end

      it 'show cart_product when user not signin' do
        get :show, params: { id: cart.id, product_id: product.id}
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
