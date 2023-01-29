require 'rails_helper'
require 'spec_helper'
require 'faker'
require_relative '../support/controller_macros'

RSpec.describe 'Orders', type: :controller do
  context OrdersController do
    let(:user) { FactoryBot.create(:user) }
    let(:cart) { FactoryBot.create(:cart) }
    let(:product) { FactoryBot.create(:product) }
    let(:order) { FactoryBot.create(:order, user: user) }
    let(:cupon) { FactoryBot.create(:cupon) }

    describe 'POST /create' do
      context '#create' do
        login_user

        it 'create order and check response when user signed in' do
          post :create, params: { cart_id: cart, product_id: product, id: order }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to eq('Order Created!')
        end

        it 'redirect to login order when user not signed in' do
          sign_out(user)
          post :create, params: { cart_id: cart, product_id: product, id: order }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to eq('Please sign_in/sign_up first!')
        end

        it 'failed to create order when user signed in' do
          allow_any_instance_of(Order).to receive(:save) { false }
          post :create, params: { cart_id: cart, product_id: product, id: order }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to be_truthy
        end
      end
    end

    describe 'GET /new' do
      context '#new' do
        it 'test new order method user signed in' do
          get :new, params: { cart_id: cart, product_id: product, id: order, user: user, format: :json }
          expect(response).to have_http_status(:no_content)
        end
      end
    end

    describe 'POST /find_cupon' do
      context '#find_cupon' do
        login_user

        it 'finding valid cupon' do
          cupon
          order
          post :find_cupon, params: { cart_id: cart, product_id: product, id: order, promo_code: 'AZADI' }
          expect(response).to have_http_status(:redirect)
        end

        it 'cupon failed when user not sign_in' do
          sign_out(user)
          post :find_cupon, params: { cart_id: cart, product_id: product, id: order }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to eq('Please sign_in/sign_up first!')
        end

        it 'finding valid cupon with failed regex' do
          cupon
          post :find_cupon, params: { cart_id: cart, product_id: product, id: order, promo_code: 'AzAdI' }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to eq('Invalid Promo code!')
        end

        it 'invalid cupon valid til' do
          cupon.valid_til = Time.now - 35.days
          cupon.save
          post :find_cupon, params: { cart_id: cart, product_id: product, id: order, promo_code: 'AZADI' }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to eq('Invalid Promo code!')
        end

        it 'invalid cupon when cupon is nil' do
          post :find_cupon, params: { cart_id: cart, product_id: product, id: order }
          expect(response).to have_http_status(:redirect)
          expect(flash[:notice]).to eq('Invalid Promo code!')
        end
      end
    end

    describe 'GET /show' do
      context '#show' do
        login_user

        it 'shows order to current user' do
          get :show, params: { cart_id: cart, product_id: product, id: order }
          expect(order.total_amount).to eq(10000)
          expect(response).to have_http_status(:ok)
        end

        it 'failed to show the order to user' do
          sign_out(user)
          get :show, params: { cart_id: cart, product_id: product, id: order }
          expect(response).to have_http_status(:redirect)
        end
      end
    end
  end
end
