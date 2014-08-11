require 'sinatra'
require 'json'

get '/' do
  redirect latest_version
end

get '/:version' do
  raise "API version doesn't exist" unless params[:version][/v[12]/i]

  eval(params[:version].upcase).meta.to_json
end

get '/:version/sub' do
  raise "API version doesn't exist" unless params[:version][/v[12]/i]
  { result:eval("#{params[:version].upcase}::Subber").remove_vowls(params['string']) }.to_json
end

def latest_version
  'V2'
end


module V1
  def self.meta
    {
      info: "welcome! You're using #{self} of the worst api ever!!",
      endpoints:[
        {
          slug:'/:version/sub',
          method:'get',
          params:'string',
          info:'removes vowls from a given string'
        }
      ]
    }
  end

  class Subber
    def self.remove_vowls string
      string.gsub(/[aeiou]/, '')
    end
  end
end

module V2
  def self.meta
    {
      info:"welcome! You're using #{self} of the worst api ever!!",
      endpoints:[
        {
          slug:'/:version/sub',
          method:'get',
          params:'string',
          info:"replaces vowls from a given string with '*' characters"
        }
      ]
    }
  end

  class Subber
    def self.remove_vowls string
      string.gsub(/a|e|i|o|u/, '*')
    end
  end
end