class CreateCheckIn
  attr_reader :record, :errors
  
  def initialize(args)
    @user = args[:user]
    @business = args[:business]
    @business_token = args[:business_token]
    @record = nil
  end

  def call
    return @record if @record
    if valid?
      @record = CheckIn.create(user: @user, business: @business)
    else
      false
    end
  end

  def valid?
    required_params? && valid_time? && valid_token?
  end

  def errors
    @errors ||= Array.new
  end

    private

  def required_params?
    if @user.is_a?(User) && @business.is_a?(Business) && @business_token.is_a?(String)
      true
    else
      append_error("Invalid parameters provided", 400)
      false
    end
  end

  def valid_token?
    if @business_token != @business.token
      append_error('Invalid token', 400)
      return false
    end
    true
  end
  
  def valid_time?
    if token_valid_at > Time.now
      append_error('Too soon since previous check-in', 400)
      false
    else
      true
    end
  end

  def token_valid_at
    prev = @user.last_check_in_at @business
    if prev
      prev.created_at + @business.check_in_timeout
    else
      Time.now - 1
    end
  end

  def append_error(message = 'Bad request', code = 400)
    errors << { message: message, code: code }
  end
  
end