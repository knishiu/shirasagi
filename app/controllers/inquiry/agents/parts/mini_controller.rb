class Inquiry::Agents::Parts::MiniController < ApplicationController
  include Cms::PartFilter::View
  include SimpleCaptcha::ControllerHelpers
  helper Cms::ListHelper

  public
    def new
# sekiguchi todo #     
#      @items = Inquiry::Node::Form.site(@cur_site).public.
#        where(@cur_part.condition_hash).
#        order_by(@cur_part.sort_hash).
#        limit(@cur_part.limit)
      @cur_node = @cur_part.parent
      @columns = Inquiry::Column.site(@cur_site).
        where(node_id: @cur_node.id, state: "public").
        order_by(order: 1)


      @items = []
      @data = {}
      @columns.each do |column|
        @items << [column, params[:item].try(:[], "#{column.id}")]
        @data[column.id] = [params[:item].try(:[], "#{column.id}")]
        if column.input_confirm == "enabled"
          @items.last << params[:item].try(:[], "#{column.id}_confirm")
          @data[column.id] << params[:item].try(:[], "#{column.id}_confirm")
        end
      end
      @answer = Inquiry::Answer.new(site_id: @cur_site.id, node_id: @cur_node.id)
      @answer.remote_addr = request.env["HTTP_X_REAL_IP"] || request.remote_ip
      @answer.user_agent = request.user_agent
      @answer.set_data(@data)
#  コピー元        
#      @items = Inquiry::Node::Form.site(@cur_site).public.
#        where(@cur_node.condition_hash).
#        page(params[:page]).
#        per(@cur_node.limit)

#      items = @items.partition { |item| item.reception_enabled? && item.reception_close_date.present? }
#      items[0] = items[0].sort_by do |item|
#        item.reception_close_date.to_i
#      end
#      items[1] = items[1].sort_by do |item|
#        if item.reception_start_date.present?
#          item.reception_start_date.to_i
#        else
#          0
#        end
 #     end

#      @items = items.flatten

    end

end
