# frozen_string_literal: true

#
# Design decisions:
# - Using released_at allows us to know when the alias has been released, and not allowing true deletion allows for history
#   retention, particularly if we were to track visits to this specfic alias/url. This is preferable to using acts_as_paranoid
#   for soft-delete as it still makes sense to provide details about released URLs later for reporting purposes.
#
# - Using SecureRandom.alphanumeric(7) mimics the pattern of shortening alias provided by bitly.
#
# - Duplicate URL values can exist with different aliases, in case a different tracking group is desired for the same destination.
#
class UrlAlias < ApplicationRecord
  validates :alias, presence: true
  validates :url, url: true, presence: true
  validate :unclaimed_alias, on: :create

  before_validation :clean_values

  scope :active, -> { where(released_at: nil) }
  scope :latest, -> { order(created_at: :desc) }

  def release
    return true if released_at.present?

    update(released_at: Time.zone.now)
  end

  def self.latest_alias(alias_text)
    # If an alias has already been released, and no new mapping exists with the same alias, just use the old one so that it doesn't break.
    base_rel = where(alias: alias_text)
    base_rel.active.first || base_rel.latest.first
  end

  def self.rando_alias
    SecureRandom.alphanumeric(7)
  end

  private

  def unclaimed_alias
    errors.add(:base, 'Alias already claimed') \
      if self.class.active.find_by(alias: self.alias).present?
  end

  def clean_values
    self.alias = self.alias&.gsub(/[^0-9a-z]+/i, '')&.presence || self.class.rando_alias
    self.url = url.squish
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
#  index_url_aliases_on_url                (url)
#
