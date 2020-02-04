# frozen_string_literal: true

require 'rails_helper'

describe SocialNetworksSerializer do
  subject(:serializer) do
    described_class.new(social_networks_checker)
  end

  let(:social_networks_checker) do
    SocialNetworksChecker.new(force: false)
  end

  describe '#serialize' do
    context 'no results' do
      before do
        social_networks_checker.expects(:twitter_result).returns(nil)
        social_networks_checker.expects(:facebook_result).returns(nil)
        social_networks_checker.expects(:instagram_result).returns(nil)
      end

      it 'serialize results' do
        expect(serializer.serialize).to eql(facebook: [],
                                            instagram: [],
                                            twitter: [])
      end
    end

    context 'array results' do
      before do
        social_networks_checker.expects(:twitter_result).returns([1, 2, 3])
        social_networks_checker.expects(:facebook_result).returns([4, 5, 6])
        social_networks_checker.expects(:instagram_result).returns([7, 8, 9])
      end

      it 'serialize results' do
        expect(serializer.serialize).to eql(facebook: [4, 5, 6],
                                            instagram: [7, 8, 9],
                                            twitter: [1, 2, 3])
      end
    end

    context 'not array results' do
      before do
        social_networks_checker.expects(:twitter_result).returns(1)
        social_networks_checker.expects(:facebook_result).returns({})
        social_networks_checker.expects(:instagram_result).returns('a')
      end

      it 'serialize results' do
        expect(serializer.serialize).to eql(facebook: [],
                                            instagram: [],
                                            twitter: [])
      end
    end
  end
end
