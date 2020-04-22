require 'spec_helper'
require 'omniauth-snapchat-publisher'

describe OmniAuth::Strategies::Snapchat do
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }
  let(:app) { lambda { [200, {}, ['Hello.']] } }

  subject do
    described_class.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) do
        request
      end
    end
  end

  describe '#name' do
    it { expect(subject.name).to eq('snapchat') }
  end

  describe '#client_options' do
    it 'has correct site' do
      expect(subject.client.site).to eq('https://api.snapchat.com')
    end

    it 'has correct authorize_url' do
      expect(subject.client.options[:authorize_url]).to eq('https://accounts.snapchat.com/login/oauth2/authorize')
    end

    it 'has correct token_url' do
      expect(subject.client.options[:token_url]).to eq('https://accounts.snapchat.com/login/oauth2/access_token')
    end

    describe 'overrides' do
      context 'as strings' do
        it 'overrides the site' do
          @options = { client_options: { 'site' => 'https://example.com' } }
          expect(subject.client.site).to eq('https://example.com')
        end

        it 'overrides the authorize_url' do
          @options = { client_options: { 'authorize_url' => 'https://example.com' } }
          expect(subject.client.options[:authorize_url]).to eq('https://example.com')
        end

        it 'overrides the token_url' do
          @options = { client_options: { 'token_url' => 'https://example.com' } }
          expect(subject.client.options[:token_url]).to eq('https://example.com')
        end
      end

      context 'as symbols' do
        it 'overrides the site' do
          @options = { client_options: { site: 'https://example.com' } }
          expect(subject.client.site).to eq('https://example.com')
        end

        it 'overrides the authorize_url' do
          @options = { client_options: { authorize_url: 'https://example.com' } }
          expect(subject.client.options[:authorize_url]).to eq('https://example.com')
        end

        it 'overrides the token_url' do
          @options = { client_options: { token_url: 'https://example.com' } }
          expect(subject.client.options[:token_url]).to eq('https://example.com')
        end
      end
    end
  end

  context 'info methods' do
    let(:raw_info) do
      { 'data' =>
          { 'me' =>
              {
                'externalId' => 'abcdefg',
                'displayName' => 'account name',
                'bitmoji' => { 'avatar' => 'http://avatar_path.com' }
              }
          }
      }
    end
    let(:expected_info) do
      {
        display_name: 'account name',
        external_id: 'abcdefg',
        avatar: 'http://avatar_path.com'
      }
    end

    before { allow(subject).to receive(:raw_info).and_return(raw_info)}

    describe '#info' do
      it { expect(subject.info).to eq(expected_info) }
    end

    describe '#extra' do
      it { expect(subject.extra).to eq({ 'raw_info' => raw_info }) }
    end
  end

  describe '#raw_info' do
    let(:access_token_instance) { instance_double(OAuth2::AccessToken) }
    let(:response_instance) { instance_double(OAuth2::Response) }
    before do
      allow(subject).to receive(:access_token).and_return(access_token_instance)
      allow(access_token_instance).to receive(:get).
        with('https://kit.snapchat.com/v1/me', params: { query: '{ me { externalId displayName bitmoji { avatar } } }' }).
        and_return(response_instance)
      allow(response_instance).to receive(:parsed).and_return({ 'data' => { 'me' => {} }})
    end

    it { expect(subject.raw_info).to eq({ 'data' => { 'me' => {} }}) }
  end

  describe '#callback_path' do
    it 'has the correct default callback path' do
      expect(subject.callback_path).to eq('/auth/snapchat/callback')
    end

    it 'sets the callback_path parameter if present' do
      @options = { callback_path: '/auth/foo/callback' }
      expect(subject.callback_path).to eq('/auth/foo/callback')
    end
  end
end
