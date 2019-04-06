# frozen_string_literal: true

module APIHelpers
  extend ActiveSupport::Concern

  def expect_created
    call_api_endpoint_just_once
    expect(response.status).to eq(201)
  end

  def expect_success_no_content
    call_api_endpoint_just_once
    expect(response.status).to eq(204)
  end

  # def expect_destroyed
  #   call_api_endpoint_just_once
  #   expect(response_json["destroyed"]).to be_truthy
  # end

  def expect_success
    call_api_endpoint_just_once
    # expect(response).to be_success
    expect(response).to have_http_status(200)
  end

  def expect_not_found
    call_api_endpoint_just_once
    expect(response.status).to eq(404)
  end

  def expect_unauthorized
    call_api_endpoint_just_once
    expect(response.status).to eq(401)
  end

  def expect_forbidden
    call_api_endpoint_just_once
    expect(response.status).to eq(403)
  end

  def expect_bad_request
    call_api_endpoint_just_once
    expect(response.status).to eq(400)
  end

  def expect_first_in_the_array_includes(field)
    expect(response_json.first.keys).to include(field)
  end

  def expect_contains_field(field)
    expect(response_json.keys).to include(field)
  end

  def expect_json
    call_api_endpoint_just_once
    expect { response_json }.to_not raise_error
  end

  def expect_error_code(code)
    call_api_endpoint_just_once
    expect(response_json["error_code"]).to eq(code)
  end

  def expect_error_message(msg)
    call_api_endpoint_just_once
    expect(response_json["error_message"]).to include(msg)
  end

  def response_json
    @response_json ||= begin
      call_api_endpoint_just_once
      json = JSON.parse(response.body)
      if json.respond_to? :with_indifferent_access
        json.with_indifferent_access
      else
        json
      end
    end
  end

  included do
    after(:each) do
      @response_json = nil
    end
  end

  def call_api_endpoint_just_once
    subject
  end
end
