require 'rails_helper'
require 'spec_helper'
require 'faker'
require_relative '../support/controller_macros'

RSpec.describe 'CartsController', type: :controller do
  context CartsController do
    let(:user) { FactoryBot.create(:user) }
    let(:user_test) { FactoryBot.create(:user) }
    let(:cart) { FactoryBot.create(:cart) }
    let(:cart_product) { FactoryBot.create(:cart_product) }
    let(:product) { FactoryBot.create(:product, user: user) }
    before(:each) do
      cart.products << product
    end

    describe 'POST /create' do
      context '#create' do
        login_user

        it 'appending products to cart_product with signin' do
          expect { post :create, params: {product_id: product } }.to change(CartProduct, :count).by(1)
          expect(response).to have_http_status(:found)
          expect(flash[:notice]).to eq('Added to cart!')
        end

        it 'appending products to cart_product without signin' do
          expect { post :create, params: { product_id: product } }.to change(CartProduct, :count).by(1)
          expect(response).to have_http_status(:found)
          expect(flash[:notice]).to eq('Added to cart!')
        end

        it 'appending products to cart_product with authentication failed' do
          sign_in(user)
          expect { post :create, params: { product_id: product } }.to change(CartProduct, :count).by(0)
          expect(response).to have_http_status(:redirect)
          expect(flash[:alert]).to eq('You are not authorized to perform this action.')
        end

        it 'appending products to cart_product failed' do
          allow_any_instance_of(CartProduct).to receive(:save) { false }
          expect { post :create, params: { product_id: product } }.not_to change{ CartProduct.count }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to be_truthy
        end
      end
    end

    describe 'PUT /Update' do
      context '#update' do
        login_user

        it 'Update quantity for cart_product with sign_in' do
          put :update, params: {product_id: product, id: cart, product: product, quantity: 3}, session: {cart_id: cart}
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to eq('cart updated!')
        end

        it 'Update quantity for cart_product without sign_in' do
          sign_out(user)
          put :update, params: {product_id: product, id: cart, product: product, quantity: 3}, session: {cart_id: cart.id}
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to eq('cart updated!')
        end

        it 'Update quantity for cart_product failed' do
          allow_any_instance_of(CartProduct).to receive(:save) { false }
          put :update, params: {product_id: product, id: cart, product: product, quantity: 3}, session: {cart_id: cart}
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to be_truthy
        end
      end
    end

    describe 'DELETE /destroy' do
      context '#destroy' do
        login_user

        it 'remove from cart_product with signin' do
          delete :destroy, params: { product_id: product, id: cart, product: product }, session: { cart_id: cart }
          expect(response).to have_http_status(:found)
          expect(flash[:notice]).to eq('Product removed from cart!')
        end

        it 'remove from cart_product without signin' do
          sign_out(user)
          delete :destroy, params: { product_id: product, id: cart, product: product }, session: { cart_id: cart.id }
          expect(response).to have_http_status(:found)
          expect(flash[:notice]).to eq('Product removed from cart!')
        end

        it 'remove from cart_product failed' do
          allow_any_instance_of(CartProduct).to receive(:destroy) { false }
          delete :destroy, params: { product_id: product, id: cart, product: product }, session: { cart_id: cart }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to be_truthy
        end
      end
    end

    describe 'GET /show' do
      context '#show' do
        login_user

        it 'show cart_product when user signin' do
          get :show, params: { id: cart, product_id: product}
          expect(response).to have_http_status(:ok)
        end

        it 'show cart_product when user not signin' do
          sign_out(user)
          get :show, params: { id: cart, product_id: product}
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
