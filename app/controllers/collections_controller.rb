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
      render json: { count: csv_data.length }, status: :ok
    rescue => e
      render json: {}, status: :unprocessable_entity
    end
  end
end
