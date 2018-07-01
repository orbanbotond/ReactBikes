# frozen_string_literal: true

require "rails_helper"

describe Login::Contracts::Default do
  let(:contract) { described_class.new({}) }
  let(:params) { { email: "email@gmail.com", password: "pwd" } }
  let!(:user) { create :user, email: params[:email], password: params[:password] }

  context "negative cases" do
    context "email is not email format" do
      let(:params) { super().merge email: "email" }

      it "fails validation" do
        expect(contract.validate params).to be_falsey
      end
    end

    context "email/pwd does not match" do
      it "fails validation" do
        expect(contract.validate (params.merge password: "wrong pwd")).to be_falsey
      end
    end

    [:email, :password].each do |field|
      context "#{field} is missing" do
        let(:params) { super().except(field) }

        it "fails validation" do
          expect(contract.validate params).to be_falsey
        end
      end

      context "#{field} is empty" do
        let(:params) { super().merge(field => "") }

        it "fails validation" do
          expect(contract.validate params).to be_falsey
        end
      end
    end
  end

  context "positive case" do
    it "passes validation" do
      expect(contract.validate params).to be_truthy
    end
  end
end
