module Vitocars
  class API
    attr_accessor :client

    def initialize(token: token, lang: lang)
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

    def add_item(item)
      i = {part_unique: item.art,
           brand_id: item.zbrand.vid,
           model_id: item.zmodel.vid,
           category_id: item.zcategory.vid,
           part_name_id: item.zpart.vid,
           price: item.price,
           description: item.description,
           quantity: 1,
           is_new: item.used ? 0 : 1}
      query = {data: i.to_json}
      client.post("Record/Write", query)
    end

    def sell_item(item)
      i = {part_unique: item.art, 
           quantity: 1}
      query = {data: i.to_json}
      client.post("RegisterOperation/Sale", query)
    end

    def debit_item(item)
      i = "{\"part_unique\":\""+item.art+"\",\"quantity\":1,\"flag\":1,\"description\":\"debit\"}"
      query = {data: i.to_json}
      client.post("RegisterOperation/Debit", query)
    end

    def add_picture(pic)
      i = "{\"part_unique\":\""+pic.item.art+"\",\"photo_url\":\""+pic.url+"\"}"
      query = {data: i}
      client.post("Photo", query)
    end
  end
end