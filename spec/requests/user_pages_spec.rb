require 'spec_helper'

describe "UserPages" do

let(:base_title) {"RoR Sample App"}

  describe "signup page" do
    before {visit signup_path}

    it "Should have h1 'Sign up'" do
      page.should have_selector('h1', :text=>'Sign up')
    end
    it "Should have title 'Sign up'" do
      page.should have_selector('title', :text=> "#{base_title} | Sign up")
    end
    end
end
