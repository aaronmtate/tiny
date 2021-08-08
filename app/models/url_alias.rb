# frozen_string_literal: true

#
# Design decisions:
# - Using released_at allows us to know when the alias has been released, and not allowing true deletion allows for history
#   retention, particularly if we were to track visits to this specfic alias/url. This is preferable to using acts_as_paranoid
#   for soft-delete as it still makes sense to provide details about released URLs later for reporting purposes.
#
# - Using SecureRandom.alphanumeric(7) mimics the pattern of shortening alias provided by bitly.
#
class UrlAlias < ApplicationRecord
  validates :alias, presence: true
  validates :url, presence: true

  scope :active, -> { where(released_at: nil) }

  def release
    return if released_at.blank?

    self.update(released_at: Time.zone.now)
  end

  def self.rando_alias
    SecureRandom.alphanumeric(7)
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
