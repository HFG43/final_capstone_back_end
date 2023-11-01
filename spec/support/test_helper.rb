module TestHelper
  def parse_json(json)
    JSON.parse(json)
  end

  def response_body
    parse_json(response.body)
  end
end
