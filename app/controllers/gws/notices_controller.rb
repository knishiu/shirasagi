class Gws::NoticesController < ApplicationController
  include Gws::BaseFilter
  include Gws::CrudFilter

  model Gws::Notice

  navi_view "gws/main/conf_navi"

  private
    def set_crumbs
      @crumbs << [:"mongoid.models.gws/notice", action: :index]
    end

    def fix_params
      { cur_user: @cur_user, cur_site: @cur_site }
    end

  public
    def index
      @items = @model.site(@cur_site).
        allow(:read, @cur_user, site: @cur_site).
        search(params[:s]).
        order_by(released: -1).
        page(params[:page]).per(50)
    end
end
