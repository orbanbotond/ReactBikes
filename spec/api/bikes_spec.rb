# frozen_string_literal: true

require "rails_helper"

describe "GET /api/bike_models" do
  let(:path) { "/api/bike_models" }
  subject { get path, params: params, headers: developer_header }
  let(:session_token) { 'token-xxx123123' }
  let!(:user) { create :user, hashed_session_token: User.pwd_hash(session_token) }
  let(:params) { {} }
  let(:developer_header) { {"X-Auth-Token" => session_token} }

  context 'creates a bike' do
    context 'negative cases' do
      it_behaves_like "unauthenticated"
    end

    context 'positive cases' do
    end
  end

  context 'returns all the bikes' do
    context 'negative cases' do
      it_behaves_like "unauthenticated"
    end

    context 'positive cases' do
    end
  end

  context 'reservation of a bike' do
    context 'negative cases' do
      it_behaves_like "unauthenticated"
    end

    context 'positive cases' do
    end
  end

  context 'returns a bike' do
    context 'negative cases' do
      it_behaves_like "unauthenticated"
    end

    context 'positive cases' do
    end
  end

  context 'deletes a bike' do
    context 'negative cases' do
      it_behaves_like "unauthenticated"
    end

    context 'positive cases' do
    end
  end

  context 'updates a bike' do
    context 'negative cases' do
      it_behaves_like "unauthenticated"
    end

    context 'positive cases' do
    end
  end
end
