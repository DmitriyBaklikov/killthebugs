require 'spec_helper'

describe User do
  describe '#generate_api_token!' do
    it 'generates unique token' do
      user = create :user
      lambda {
        user.generate_api_token!
      }.should change { user.reload.api_token }
    end
  end
end
