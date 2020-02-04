# frozen_string_literal: true

require 'rails_helper'

describe Api::SocialNetworksApi do
  describe 'get /' do
    context 'success all' do
      before do
        success_instagram_stub
        success_twitter_stub
        success_facebook_stub
        get '/'
      end

      it_behaves_like 'success response status'

      it 'return correct result structure' do
        expect(json).to eql('twitter' =>
                            [{ 'username' => '@kaiser', 'tweet' => 'If you live to be 100' },
                             { 'username' => '@mike', 'tweet' => 'STOP' }],
                            'facebook' =>
                            [{ 'name' => 'friend', 'status' => "Here's some photos" },
                             { 'name' => 'Drama', 'status' => 'I am in a hospital' }],
                            'instagram' =>
                            [{ 'username' => 'hipster1', 'picture' => 'food' },
                             { 'username' => 'hipster2', 'picture' => 'cat' }])
      end
    end

    context 'error at one api' do
      before do
        success_instagram_stub
        success_twitter_stub
        error_facebook_stub
        get '/'
      end
      it_behaves_like 'success response status'

      it 'return correct result structure' do
        expect(json).to eql('twitter' =>
                            [{ 'username' => '@kaiser', 'tweet' => 'If you live to be 100' },
                             { 'username' => '@mike', 'tweet' => 'STOP' }],
                            'facebook' => [],
                            'instagram' =>
                            [{ 'username' => 'hipster1', 'picture' => 'food' },
                             { 'username' => 'hipster2', 'picture' => 'cat' }])
      end
    end

    context 'error at all api' do
      before do
        error_instagram_stub
        error_twitter_stub
        error_facebook_stub
        get '/'
      end
      it_behaves_like 'success response status'

      it 'return correct result structure' do
        expect(json).to eql('twitter' => [],
                            'facebook' => [],
                            'instagram' => [])
      end
    end

    context 'timeout at one api' do
      before do
        success_instagram_stub
        timeout_twitter_stub
        success_facebook_stub
        get '/'
      end
      it_behaves_like 'success response status'

      it 'return correct result structure' do
        expect(json).to eql('twitter' => [],
                            'facebook' =>
                            [{ 'name' => 'friend', 'status' => "Here's some photos" },
                             { 'name' => 'Drama', 'status' => 'I am in a hospital' }],
                            'instagram' =>
                            [{ 'username' => 'hipster1', 'picture' => 'food' },
                             { 'username' => 'hipster2', 'picture' => 'cat' }])
      end
    end

    context 'timeout at one api' do
      before do
        success_instagram_stub
        timeout_twitter_stub
        success_facebook_stub
        get '/'
      end
      it_behaves_like 'success response status'

      it 'return correct result structure' do
        expect(json).to eql('twitter' => [],
                            'facebook' =>
                            [{ 'name' => 'friend', 'status' => "Here's some photos" },
                             { 'name' => 'Drama', 'status' => 'I am in a hospital' }],
                            'instagram' =>
                            [{ 'username' => 'hipster1', 'picture' => 'food' },
                             { 'username' => 'hipster2', 'picture' => 'cat' }])
      end
    end

    context 'timeout at all api' do
      before do
        timeout_instagram_stub
        timeout_twitter_stub
        timeout_facebook_stub
        get '/'
      end
      it_behaves_like 'success response status'

      it 'return correct result structure' do
        expect(json).to eql('twitter' => [],
                            'facebook' => [],
                            'instagram' => [])
      end
    end
  end
end
