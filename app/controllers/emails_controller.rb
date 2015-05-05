require 'gandi_email'

class EmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_email_server

  # GET /emails/new
  def new
    @domain = domain
  end

  # POST /emails
  # POST /emails.json
  def create
    # Remove old email
    if current_user.forward_address?
      logger.debug "Removing old email forwarding: #{current_user.forward_address}"
      @email_server.delete(current_user.forward_address)
    end

    # Add email in Gandi
    begin
      @email_server.create(email_params[:forward_address], { 'destinations' => [email_params[:forward_destination]] })
    rescue LibXML::XML::XMLRPC::RemoteCallError => e
      respond_to do |format|
        error = Gandi::parse_error(e.message)
        logger.debug "Email forwarding creation error: #{error}"
        format.html { redirect_to root_path, alert: "Couldn't create email forwarding '#{email_params[:forward_destination]}': #{error}." }
        format.json { head :no_content, status: :unprocessable_entity }
      end
      return
    end

    msg = "Email forwarding created from #{email_params[:forward_address]}@#{@email_domain} to #{email_params[:forward_destination]}"
    logger.info msg

    # Update user with new email
    logger.debug "Updating user with new email forwarding: #{email_params.inspect}"
    current_user.update(email_params)

    respond_to do |format|
      format.html { redirect_to root_path, notice: msg }
      format.json { head :no_content }
    end
  end

  private
    def email_params
      params.permit(:forward_address, :forward_destination)
    end

    def domain
      ENV['GANDI_MAIL_DOMAIN']
    end

    def get_email_server
      @email_server = Gandi::Email.new(@gandi, domain)
    end
end
