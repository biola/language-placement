class Admin::ApplicationController < ApplicationController
  layout 'admin/application'

  before_action :authenticate!
end
