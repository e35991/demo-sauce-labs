require 'spec_helper'
set :environment, :test

describe "Building Test" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "should respond to /building/:id" do
    get '/building/freedom-tower'
    last_response.should be_ok
    last_response.body.should match(/Freedom Tower/)
    last_response.body.should_not match(/Burj Khalifa/)
    last_response.body.should match(/Top Floor: 1268 ft/)
  end

  it "should return json stats" do
    get '/building/freedom-tower.json'
    last_response.should be_ok
    last_response.header["Content-Type"].should match(/application\/json/)
    last_response.body.should eq('{"stats":[{"item":"top","number":"1268","heading":"Top Floor: "},{"item":"tip","number":"1776","heading":"Tip: "}]}')
  end
end
