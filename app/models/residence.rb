# == Schema Information
#
# Table name: residences
#
#  id                       :bigint           not null, primary key
#  contact_email            :string           default(""), not null
#  contact_name             :string           default(""), not null
#  contact_phone            :string           default(""), not null
#  delivery_general_info    :string           default(""), not null
#  delivery_into_room       :boolean          default(FALSE), not null
#  delivery_pickup_location :string           default(""), not null
#  delivery_reception       :boolean          default(FALSE), not null
#  manned_reception         :boolean          default(FALSE), not null
#  name                     :string           default(""), not null
#  no_pallets               :boolean          default(FALSE), not null
#  pre_arrival_delivery     :integer
#  vehicle_size             :string           default(""), not null
#  weekend_delivery         :boolean          default(FALSE), not null
#  what_word_first          :string           default("")
#  what_word_second         :string           default("")
#  what_word_third          :string           default("")
#  created_at               :datetime
#  updated_at               :datetime
#  partner_id               :bigint           not null
#
# Indexes
#
#  index_residences_on_partner_id  (partner_id)
#
# Foreign Keys
#
#  fk_rails_...  (partner_id => partners.id) ON DELETE => cascade
#
class Residence < ApplicationRecord

  belongs_to :partner
  has_one :block, dependent: :destroy
  has_many :rooms, dependent: :destroy


end
