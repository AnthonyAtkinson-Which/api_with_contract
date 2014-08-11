require 'spec_helper'

describe 'API with contract' do
  def response
    JSON::parse(last_response.body)
  end

  def fetch(url)
    JSON::parse(Net::HTTP.get_response(URI.parse(url)).body)
  end

  it 'should have up to date docs for /v1 call' do
    get '/v1'
    expect(response).to eql(fetch('http://anthonyatkinson.apiary-mock.com/v1'))
  end

  it 'should have up to date docs for /sub call' do
    get '/v2/sub?string=test'
    expect(response).to eql(fetch('http://anthonyatkinson.apiary-mock.com/v2/sub?string=test'))
  end
end

# These are examples of the type of tests that can be implimented in 
# the api to make sure that the documentation is up to date

# They check that the mock response from apiary matches the response from the api
# Tests like these would ensure that the api docs are not giving bad information