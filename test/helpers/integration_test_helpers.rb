module IntegrationTestHelpers
  def jsonapi_delete(type, id)
    type = normalized_type(type)
    url = "/api/#{type}/#{id}"
    args = { headers: headers }
    delete url, **args
  end

  def jsonapi_get(type, id=nil)
    type = normalized_type(type)
    if id.nil?
      url = "/api/#{type}"
    else
      url = "/api/#{type}/#{id}"
    end
    args = { headers: headers }
    get url, **args
  end

  def jsonapi_patch(type, id, attributes, relationships=[])
    type = normalized_type(type)
    url = "/api/#{type}/#{id}"
    args = {
      params: {
        data: {
          attributes: attributes,
          id: id,
          relationships: format_relationships(relationships),
          type: type,
        }
      }.to_json,
      headers: headers,
    }
    p "----------"
    p args
    p "----------"
    patch url, **args
  end

  def jsonapi_post(type, attributes, relationships=[])
    type = normalized_type(type)
    url = "/api/#{type}"
    args = {
      params: {
        data: {
          attributes: attributes,
          relationships: format_relationships(relationships),
          type: type,
        }
      }.to_json,
      headers: headers,
    }
    post url, **args
  end

  def headers
    {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json',
    }
  end

  def normalized_type(type)
    type.to_s.downcase.dasherize.pluralize
  end

  def format_relationships(relationships)
    relationship_obj = {}
    relationships.each do |relationship|
      type = normalized_type(relationship.model_name)
      relationship_obj[type.singularize] = {
        data: {
          id: relationship.id,
          type: type,
        }
      }
    end
    relationship_obj.to_json
  end

  def add_headers_to_args(args)
    args[:headers] ||= { }
    args[:headers]['Content-Type'] ||= 'application/vnd.api+json'
    args[:headers]['Accept'] ||= 'application/vnd.api+json'
  end
end
