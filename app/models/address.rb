# == Schema Information
#
# Table name: addresses
#
#  id              :bigint           not null, primary key
#  address         :string           default(""), not null
#  apartment       :string           default(""), not null
#  city            :string           default(""), not null
#  country         :string           default(""), not null
#  postcode        :string           default(""), not null
#  residence_block :string           default(""), not null
#  created_at      :datetime
#  updated_at      :datetime
#  block_id        :bigint
#  residence_id    :bigint
#  sub_block_id    :bigint
#
# Indexes
#
#  index_addresses_on_block_id      (block_id)
#  index_addresses_on_residence_id  (residence_id)
#  index_addresses_on_sub_block_id  (sub_block_id)
#
# Foreign Keys
#
#  fk_rails_...  (block_id => blocks.id) ON DELETE => cascade
#  fk_rails_...  (residence_id => residences.id) ON DELETE => cascade
#  fk_rails_...  (sub_block_id => sub_blocks.id) ON DELETE => cascade
#
class Address < ApplicationRecord
end
