class Gws::Facility
  include SS::Document
  include Gws::Reference::User
  include Gws::Reference::Site
  include SS::Addon::Markdown
  include Gws::Addon::GroupPermission

  seqid :id
  field :name, type: String

  permit_params :name

  validates :name, presence: true

  scope :search, ->(params) {
    criteria = where({})
    return criteria if params.blank?

    criteria = criteria.keyword_in params[:keyword], :name if params[:keyword].present?
    criteria
  }
end
