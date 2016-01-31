module Vitocars
    class Client
    attr_accessor :token, :request

    URL = "http://api.vitocars.net/api/"

    def initialize(token, lang = "ru")
      @request = HTTPI::Request.new(URL)
      @token = token
      @lang = lang
    end

    def get(query)
      resp = call(query)
      if 200 == resp.code
        JSON.parse(resp.body)
      else 
        raise Error, "Get finished bad: #{resp.inspect}"
      end
    end

    def post(query)
      resp = call(query)
      if 200 == resp.code
        resp = JSON.parse(resp.body)
        raise Error, "Post finished bad: #{resp.inspect}" unless resp.key?("ok")
      else
        raise Error, "Post finished bad: #{resp.inspect}"
      end
      true
    end

    def call(query)
      signup_request(query)
      HTTPI.post(request)
    end

    def signup_request(query)
      request.query = {token_id: token, lang: lang}.merge(query)
    end
  end
end