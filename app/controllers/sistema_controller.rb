class SistemaController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  authorize_resource
  include ApplicationHelper
  include SistemaHelper

  require 'csv'

  def layout_by_resource
    if current_admin.super_admin?
      'sistema'
    else
      'admin'
    end
  end
end
