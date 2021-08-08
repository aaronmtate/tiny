require "test_helper"

class UrlAliasTest < ActiveSupport::TestCase
  # validates :alias, presence: true
  # validates :url, presence: true

  # scope :active, -> { where(released_at: nil) }

  # def release
  #   return if released_at.blank?

  #   self.update(released_at: Time.zone.now)
  # end

  # def self.rando_alias
  #   SecureRandom.alphanumeric(7)
  # end



  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: url_aliases
#
#  id          :integer          not null, primary key
#  alias       :string           not null
#  released_at :datetime
#  url         :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_url_aliases_on_alias              (alias)
#  index_url_aliases_on_uniq_active_alias  (alias) UNIQUE WHERE released_at IS NULL
#  index_url_aliases_on_uniq_active_url    (url) UNIQUE WHERE released_at IS NULL
#  index_url_aliases_on_url                (url)
#
