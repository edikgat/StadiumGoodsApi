# frozen_string_literal: true

require 'rails_helper'

describe SocialNetworksChecker do
  subject(:api_check) do
    described_class.new(force: force)
  end

  let(:force) { false }

  describe '#facebook' do
    it 'set ApiCheck::Facebook' do
      expect(api_check.facebook).to be_a(ApiCheck::Facebook)
    end

    it 'set force parameter' do
      expect(api_check.facebook.force).to be(false)
    end

    context 'force == true' do
      let(:force) { true }

      it 'set force parameter' do
        expect(api_check.facebook.force).to be(true)
      end
    end
  end

  describe '#twitter' do
    it 'set ApiCheck::Facebook' do
      expect(api_check.twitter).to be_a(ApiCheck::Twitter)
    end

    it 'set force parameter' do
      expect(api_check.twitter.force).to be(false)
    end

    context 'force == true' do
      let(:force) { true }

      it 'set force parameter' do
        expect(api_check.twitter.force).to be(true)
      end
    end
  end

  describe '#instagram' do
    it 'set ApiCheck::Instagram' do
      expect(api_check.instagram).to be_a(ApiCheck::Instagram)
    end

    it 'set force parameter' do
      expect(api_check.instagram.force).to be(false)
    end

    context 'force == true' do
      let(:force) { true }

      it 'set force parameter' do
        expect(api_check.instagram.force).to be(true)
      end
    end
  end

  describe '#check' do
    it 'check results' do
      ApiCheck::Instagram.any_instance.expects(:result).once
      ApiCheck::Twitter.any_instance.expects(:result).once
      ApiCheck::Facebook.any_instance.expects(:result).once
      api_check.check
    end
  end

  describe '#twitter_result' do
    it 'delegates to ApiCheck::Twitter' do
      ApiCheck::Twitter.any_instance.expects(:result)
      api_check.twitter_result
    end
  end

  describe '#facebook_result' do
    it 'delegates to ApiCheck::Facebook' do
      ApiCheck::Facebook.any_instance.expects(:result)
      api_check.facebook_result
    end
  end

  describe '#instagram_result' do
    it 'delegates to ApiCheck::Instagram' do
      ApiCheck::Instagram.any_instance.expects(:result)
      api_check.instagram_result
    end
  end
end
