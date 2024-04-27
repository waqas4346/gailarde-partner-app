# == Schema Information
#
# Table name: rooms
#
#  id           :bigint           not null, primary key
#  name         :string           default(""), not null
#  created_at   :datetime
#  updated_at   :datetime
#  block_id     :bigint
#  residence_id :bigint
#  sub_block_id :bigint
#
# Indexes
#
#  index_rooms_on_block_id      (block_id)
#  index_rooms_on_residence_id  (residence_id)
#  index_rooms_on_sub_block_id  (sub_block_id)
#
# Foreign Keys
#
#  fk_rails_...  (block_id => blocks.id) ON DELETE => cascade
#  fk_rails_...  (residence_id => residences.id) ON DELETE => cascade
#  fk_rails_...  (sub_block_id => sub_blocks.id) ON DELETE => cascade
#
class Room < ApplicationRecord
  belongs_to :residence, optional: true
  belongs_to :block, optional: true
  belongs_to :sub_block, optional: true
end
