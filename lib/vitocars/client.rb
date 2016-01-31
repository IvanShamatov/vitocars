require 'httpi'
module Vitocars
  class Client
    attr_accessor :token, :request, :lang

    URL_PREFIX = "http://api.vitocars.net/api/"

    def initialize(token, lang = "ru")
      @request = HTTPI::Request.new
      @token = token
      @lang = lang
    end

    def get(endpoint, query)
      resp = call(endpoint, query)
      if 200 == resp.code
        JSON.parse(resp.body)
      else 
        raise Error, "Get finished bad: #{resp.inspect}"
      end
    end

    def post(endpoint, query)
      resp = call(endpoint, query)
      if 200 == resp.code
        resp = JSON.parse(resp.body)
        raise Error, "Post finished bad: #{resp.inspect}" unless resp.key?("ok")
      else
        raise Error, "Post finished bad: #{resp.inspect}"
      end
      true
    end

    def call(endpoint, query)
      request.url = "#{URL_PREFIX}#{endpoint}"
      request.query = {token_id: token, lang: lang}.merge(query)
      HTTPI.post(request)
    end
  end
end