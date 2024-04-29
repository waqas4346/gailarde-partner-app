# == Schema Information
#
# Table name: sub_blocks
#
#  id               :bigint           not null, primary key
#  name             :string           default(""), not null
#  what_word_first  :string           default("")
#  what_word_second :string           default("")
#  what_word_third  :string           default("")
#  created_at       :datetime
#  updated_at       :datetime
#  block_id         :bigint           not null
#
# Indexes
#
#  index_sub_blocks_on_block_id  (block_id)
#
# Foreign Keys
#
#  fk_rails_...  (block_id => blocks.id) ON DELETE => cascade
#
class SubBlock < ApplicationRecord
  belongs_to :block
  has_many :rooms, dependent: :destroy
  has_many :addresses, dependent: :destroy
end
