# frozen_string_literal: true

class SocialNetworksChecker
  attr_reader :instagram, :twitter, :facebook

  delegate :result, to: :instagram, prefix: true
  delegate :result, to: :twitter, prefix: true
  delegate :result, to: :facebook, prefix: true

  def self.check(force: false)
    new(force: force).check
  end

  def initialize(force:)
    @instagram = ApiCheck::Instagram.new(force: force)
    @twitter = ApiCheck::Twitter.new(force: force)
    @facebook = ApiCheck::Facebook.new(force: force)
  end

  def check
    [instagram, twitter, facebook].map do |social|
      Thread.new { social.result }
    end.each(&:join)
    self
  end
end
