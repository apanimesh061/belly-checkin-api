class CheckInsApi < Grape::API

  helpers do
    def user
      User.find_by_id permitted_params[:user_id]
    end

    def business
      Business.find_by_id permitted_params[:business_id]
    end

    def business_token
      permitted_params[:business_token]
    end
  end

  desc "Create a CheckIn"
  params do
    requires :user_id, type: Integer, desc: "ID of User checking in"
    requires :business_id, type: Integer, desc: "ID of Business where User is checking in"
    requires :business_token, type: String, desc: "Token string to check in at Business"
  end
  post do
    args = { user: user, business: business, business_token: business_token }
    @action = CreateCheckIn.new(args)

    if @action.call
      represent @action.record, with: CheckInRepresenter
    else
      action_error = @action.errors.first
      error! action_error[:message], action_error[:code]
    end
  end

end
