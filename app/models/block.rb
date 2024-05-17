# == Schema Information
#
# Table name: blocks
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
  has_many :sub_blocks, dependent: :destroy
  has_many :rooms, dependent: :destroy
end
