# == Schema Information
#
# Table name: sub_blocks
#
#  id               :bigint           not null, primary key
#  active           :boolean          default(TRUE)
#  address          :string           default("")
#  apartment        :string           default("")
#  city             :string           default("")
#  country          :string           default("")
#  name             :string           default(""), not null
#  postcode         :string           default("")
#  residence_block  :string           default("")
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
end
