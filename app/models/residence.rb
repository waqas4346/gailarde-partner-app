# == Schema Information
#
# Table name: residences
#
#  id                       :bigint           not null, primary key
#  active                   :boolean          default(TRUE)
#  address                  :string           default("")
#  apartment                :string           default("")
#  city                     :string           default("")
#  contact_email            :string           default(""), not null
#  contact_name             :string           default(""), not null
#  contact_phone            :string           default(""), not null
#  country                  :string           default("")
#  delivery_general_info    :text             default("")
#  delivery_into_room       :boolean          default(FALSE)
#  delivery_pickup_location :string           default("")
#  delivery_reception       :boolean          default(FALSE)
#  manned_reception         :boolean          default(FALSE)
#  name                     :string           default(""), not null
#  no_pallets               :boolean          default(FALSE)
#  postcode                 :string           default("")
#  pre_arrival_delivery     :integer
#  residence_block          :string           default("")
#  vehicle_size             :string           default("")
#  weekend_delivery         :boolean          default(FALSE)
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
  has_many :blocks, dependent: :destroy
  has_many :rooms, dependent: :destroy


end
