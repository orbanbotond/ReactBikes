# frozen_string_literal: true

require "rails_helper"

describe Crud::User::Contracts::Create do
  let(:contract) { described_class.new User.new }
  let(:params) { { email: "akarmi", password: "new_password" } }

  context "negative cases" do
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
