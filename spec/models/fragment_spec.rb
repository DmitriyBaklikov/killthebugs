require 'spec_helper'

describe Fragment do
  it 'strips \r from code' do
    fragment = Fragment.new code: "1\r\n2"
    fragment.code.should == "1\n2"
  end
end
