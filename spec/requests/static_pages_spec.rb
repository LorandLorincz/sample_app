require 'spec_helper'

describe "Static pages" do

  let(:base_title) {"RoR Sample App"}

  describe "Home page" do
    before { visit root_path}
    it "Should have h1 'Sample App'" do
      page.should have_selector('h1', :text => 'Sample App')
    end

    it "Should have the title 'Home'" do
      page.should have_selector('title', :text=> "#{base_title}")
    end

    it "Should have have a custom page title" do
      page.should_not have_selector('title', :text => '| Home')
    end
  end

  describe "Help page" do
    before { visit help_path}
   it "Should have h1 'Help'" do
    page.should have_selector('h1', :text=> 'Help')
   end

   it "Should have title 'Help'" do
    page.should have_selector('title', :text=>"#{base_title} | Help")
   end
  end

  describe "About page" do
    before{visit about_path}
    it "Should have h1 'About us'" do
      page.should have_selector('h1',:text=>'About us')
    end

    it "Should have the title 'About us'" do
      page.should have_selector('title',:text=>"#{base_title} | About us")
    end
  end

  describe "Contact page" do
    before{visit contact_path}
    it "Should have the h1 'Contact'" do
      page.should have_selector('h1', text: 'Contact')
    end

    it "Should have the title 'Contact'" do
      page.should have_selector('title',
                    text: "#{base_title} | Contact")
    end
  end

end
