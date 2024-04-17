# == Schema Information
#
# Table name: blocks
#
#  id               :bigint           not null, primary key
#  name             :string           default(""), not null
#  what_word_first  :string           default("")
#  what_word_second :string           default("")
#  what_word_third  :string           default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  residence_id     :bigint           not null
#
# Indexes
#
#  index_blocks_on_residence_id  (residence_id)
#
# Foreign Keys
#
#  fk_rails_...  (residence_id => residences.id) ON DELETE => cascade
#
class Block < ApplicationRecord
  belongs_to :residence
  has_one :sub_block, dependent: :destroy
  has_many :rooms, dependent: :destroy
end
