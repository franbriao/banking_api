class ApplicationController < ActionController::API
  private

  def authenticate
    api_key = request.headers['X-Api-Key']

    @account = Account.where(api_key: api_key).first if api_key

    return if @account

    render json: { errors: { missing_api_key: 'Inform valid API Key on X-Api-Key header to perform this action' } }, 
           status: :unauthorized

    false
  end
end
