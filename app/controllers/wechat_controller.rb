class WechatController < ApplicationController
  before_action :check_wechat_signature

  def index
    render :text => params[:echostr]
  end

  def create
    logger.info "Create: ******************************"
    logger.info params
    logger.info "Create: ******************************"
    render text: "ok"
  end

  private
  def check_wechat_signature
    array = ["this-is-my-private-token", params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end
