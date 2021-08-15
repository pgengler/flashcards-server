module IntegrationTestHelpers
  def jsonapi_delete(model)
    type = type_from_model(model)
    url = "/api/#{type}/#{model.id}"
    args = { headers: headers }
    delete url, **args
  end

  def jsonapi_get(model_or_type)
    if model_or_type.is_a?(ApplicationRecord)
      type = type_from_model(model_or_type)
      url = "/api/#{type}/#{model_or_type.id}"
    else
      type = normalized_type(model_or_type)
      url = "/api/#{type}"
    end
    args = { headers: headers }
    get url, **args
  end

  def jsonapi_patch(model, attributes, relationships=[])
    type = type_from_model(model)
    url = "/api/#{type}/#{model.id}"
    data = {
      attributes: attributes,
      id: model.id,
      type: type,
    }
    unless relationships.empty?
      data[:relationships] = format_relationships(relationships)
    end

    args = {
      params: {
        data: data,
      }.to_json,
      headers: headers,
    }

    patch url, **args
  end

  def jsonapi_post(type, attributes, relationships=[])
    type = normalized_type(type)
    url = "/api/#{type}"
    data = {
      attributes: attributes,
      type: type,
    }
    unless relationships.empty?
      data[:relationships] = format_relationships(relationships)
    end

    args = {
      params: {
        data: data,
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
    type.to_s.underscore.downcase.dasherize.pluralize
  end

  def type_from_model(model)
    raise TypeError, 'argument must be a model' unless model.is_a?(ApplicationRecord)
    normalized_type model.model_name
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
    relationship_obj
  end

  def add_headers_to_args(args)
    args[:headers] ||= { }
    args[:headers]['Content-Type'] ||= 'application/vnd.api+json'
    args[:headers]['Accept'] ||= 'application/vnd.api+json'
  end
end
