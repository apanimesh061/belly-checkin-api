class BusinessesApi < Grape::API
  desc 'Get a list of businesses'
  params do
    optional :ids, type: Array, desc: 'Array of businesses ids'
  end
  get do
    businesses = params[:ids] ? Business.where(id: params[:ids]) : Business.all
    represent businesses, with: BusinessRepresenter
  end

  desc 'Create an businesses'
  params do
  end

  post do
    businesses = Business.create!(permitted_params)
    represent businesses, with: BusinessRepresenter
  end

  params do
    requires :id, desc: 'ID of the businesses'
  end
  route_param :id do
    desc 'Get an businesses'
    get do
      businesses = Business.find(params[:id])
      represent businesses, with: BusinessRepresenter
    end

    desc 'Update an businesses'
    params do
    end
    put do
      # fetch businesses record and update attributes.  exceptions caught in app.rb
      businesses = Business.find(params[:id])
      businesses.update_attributes!(permitted_params)
      represent businesses, with: BusinessRepresenter
    end
  end
end
