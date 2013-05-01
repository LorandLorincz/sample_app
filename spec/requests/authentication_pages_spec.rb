require 'spec_helper'

describe "AuthenticationPages" do

  describe "Sign in page" do
    before {visit signin_path}
    it {page.should have_selector('h1', :text=> 'Sign in') }
    it {page.should have_selector('title', :text=> 'Sign in') }

    describe "with invalid info" do
      before  { click_button "Sign in"}
       it { page.should have_selector('title', :text=>'Sign in') }
       it { page.should have_selector('div.alert.alert-error', :text=>'Invalid')}
       describe "after visiting another page" do
        before{ click_link "Home"}
        it { should_not have_selector('div.alert.alert-error', :text=>'Invalid')}
      end
    end

    describe "with valid info" do
      let(:user) { FactoryGirl.create(:user)}
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
        cookies[:remember_token] = user.remember_token
      end
      it { page.should have_selector('title', :text=> user.name) }
      it { page.should have_link('Profile', :href=> user_path(user)) }
      it { page.should  have_link('Settings', :href=> edit_user_path(user)) }
      it { page.should  have_link('Sign out', :href=> signout_path) }
      it { page.should_not have_link('Sign in', :href=> signin_path) }
    end

  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end

end
