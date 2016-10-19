class CheckInsApi < Grape::API
  desc 'Get a list of check_ins'
  params do
    optional :ids, type: Array, desc: 'Array of check_ins ids'
  end
  get do
    check_ins = params[:ids] ? CheckIn.where(id: params[:ids]) : CheckIn.all
    represent check_ins, with: CheckInRepresenter
  end

  desc 'Create an check_ins'
  params do
  end

  post do
    check_ins = CheckIn.create!(permitted_params)
    represent check_ins, with: CheckInRepresenter
  end

  params do
    requires :id, desc: 'ID of the check_ins'
  end
  route_param :id do
    desc 'Get an check_ins'
    get do
      check_ins = CheckIn.find(params[:id])
      represent check_ins, with: CheckInRepresenter
    end

    desc 'Update an check_ins'
    params do
    end
    put do
      # fetch check_ins record and update attributes.  exceptions caught in app.rb
      check_ins = CheckIn.find(params[:id])
      check_ins.update_attributes!(permitted_params)
      represent check_ins, with: CheckInRepresenter
    end
  end
end
