require 'spec_helper'

describe "UserPages" do

subject { page }
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

  describe "Edit User" do
    let(:user) { FactoryGirl.create(:user)}
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_selector('h1', text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid info" do
      before  { click_button "Save changes" }

      it { should have_content('error') }
    end
  end

  describe "profile page" do
   let(:user) { FactoryGirl.create(:user) }
   before { visit user_path(user) }

   it { page.should have_selector('h1',    text: user.name) }
   it { page.should have_selector('title', text: user.name) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

end

