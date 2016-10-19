class UsersApi < Grape::API
  desc 'Get a list of users'
  params do
    optional :ids, type: Array, desc: 'Array of users ids'
  end
  get do
    users = params[:ids] ? User.where(id: params[:ids]) : User.all
    represent users, with: UserRepresenter
  end

  desc 'Create an users'
  params do
  end

  post do
    users = User.create!(permitted_params)
    represent users, with: UserRepresenter
  end

  params do
    requires :id, desc: 'ID of the users'
  end
  route_param :id do
    desc 'Get an users'
    get do
      users = User.find(params[:id])
      represent users, with: UserRepresenter
    end

    desc 'Update an users'
    params do
    end
    put do
      # fetch users record and update attributes.  exceptions caught in app.rb
      users = User.find(params[:id])
      users.update_attributes!(permitted_params)
      represent users, with: UserRepresenter
    end
  end
end
