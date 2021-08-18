class CollectionsController < ApplicationController
  def import
    csv_data = CSV.parse(request.body.read)
    begin
      collection = Collection.find(params[:collection_id])
    rescue
      render json: {}, status: :not_found
      return
    end

    begin
      collection.transaction do
        csv_data.each do |row|
          front = row[0]
          back = row[1]

          Card.create!(front: front, back: back, collection: collection)
        end
      end
      data = serialize_collection(collection)
      data[:meta] = { cards_imported: csv_data.length }
      headers['Content-Type'] = 'application/vnd.api+json'
      render json: data, status: :ok
    rescue => e
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  # Adapted from https://github.com/cerebris/jsonapi-resources/issues/1149#issuecomment-853780242
  def serialize_collection(collection)
    serializer = JSONAPI::ResourceSerializer.new(resource_klass)
    resource_set = resource_set(collection)
    resource_set.populate!(serializer, context, {})
    serializer.serialize_resource_set_to_hash_single(resource_set)
  end

  def resource_set(collection)
    id_tree = JSONAPI::PrimaryResourceIdTree.new
    directives = JSONAPI::IncludeDirectives.new(resource_klass, ['cards']).include_directives

    identity = JSONAPI::ResourceIdentity.new(resource_klass, collection.id)
    fragment = JSONAPI::ResourceFragment.new(identity)
    id_tree.add_resource_fragment(fragment, directives[:include_related])

    cards_relationship = resource_klass._relationship(:cards)
    collection.cards.each do |card|
      rid = JSONAPI::ResourceIdentity.new(cards_relationship.resource_klass, card.id)
      fragment.add_related_identity(:cards, rid)
    end

    JSONAPI::ResourceSet.new(id_tree)
  end
end
