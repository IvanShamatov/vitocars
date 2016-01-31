module Vitocars
  class API
    attr_accessor :client

    def initialize(token, lang="ru")
      @client = Client.new(token, lang)
    end

    def models
      query = {data: {range: 1}.to_json}
      client.get("GetModelsList", query)
    end

    def parts
      query = {data: {range: 1}.to_json}
      client.get("GetPart/NamesList", query)
    end

    def all
      query = {data: {range: 1}.to_json}
      client.get("GetPart/FullList", query)
    end

    def add_item(hash)
      i = {part_unique: hash[:sku],
           brand_id:    hash[:brand],
           model_id:    hash[:model],
           category_id: hash[:category],
           part_name_id: hash[:part_name],
           price:       hash[:price],
           description: hash[:description],
           quantity:    hash[:quantity],
           is_new:      hash[:is_new]}
      query = {data: i.to_json}
      client.post("Record/Write", query)
    end

    def sell_item(hash)
      i = {part_unique: hash[:sku], 
           quantity:    hash[:quantity]}
      query = {data: i.to_json}
      client.post("RegisterOperation/Sale", query)
    end

    def debit_item(hash)
      i = {part_unique: hash[:sku],
           quantity: hash[:quantity],
           flag: 1,
           description: "debit"}
      query = {data: i.to_json}
      client.post("RegisterOperation/Debit", query)
    end

    def add_picture(hash)
      i = {part_unique: hash[:sku],
           photo_url:   hash[:url]}
      query = {data: i.to_json}
      client.post("Photo", query)
    end
  end
end