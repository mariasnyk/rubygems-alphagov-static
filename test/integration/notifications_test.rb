require 'integration_test_helper'

class NotificationsTest < ActionDispatch::IntegrationTest
  setup do
    @original_banner = Static.banner
  end

  teardown do
    Static.banner = @original_banner
  end

  context "banner files" do
    should "have a green file" do
      assert File.exist? "#{Rails.root}/app/views/notifications/banner_green.erb"
    end

    should "have a red file" do
      assert File.exist? "#{Rails.root}/app/views/notifications/banner_red.erb"
    end

    should "have a black file" do
      assert File.exist? "#{Rails.root}/app/views/notifications/banner_black.erb"
    end
  end

  context "banner notifications" do
    teardown do
      clean_up_test_files
    end

    context "given view files are empty" do
      setup do
        create_test_file(filename: "banner_green.erb", content: '')
        create_test_file(filename: "banner_red.erb", content: '')
        create_test_file(filename: "banner_black.erb", content: '')

        Static.banner = NotificationFileLookup.new(location_of_test_files).banner
      end

      should "not show a banner notification on the page" do
        visit "/templates/wrapper.html.erb"
        refute page.has_selector? "#banner-notification"
      end
    end

    context "given view files are present for a green notification" do
      setup do
        create_test_file(filename: "banner_green.erb", content: '<p>Everything is fine</p>')
        create_test_file(filename: "banner_red.erb", content: '')
        create_test_file(filename: "banner_black.erb", content: '')

        Static.banner = NotificationFileLookup.new(location_of_test_files).banner
      end

      should "show a banner notification on the page" do
        visit "/templates/wrapper.html.erb"
        assert page.has_selector? "#banner-notification.green"
        assert_match '<p>Everything is fine</p>', page.body
      end
    end

    context "given view files are present for a red notification" do
      setup do
        create_test_file(filename: "banner_green.erb", content: '')
        create_test_file(filename: "banner_red.erb", content: '<p>Everything is not fine</p>')
        create_test_file(filename: "banner_black.erb", content: '')

        Static.banner = NotificationFileLookup.new(location_of_test_files).banner
      end

      should "show a banner notification on the page" do
        visit "/templates/wrapper.html.erb"
        assert page.has_selector? "#banner-notification.red"
        assert_match '<p>Everything is not fine</p>', page.body
      end
    end

    context "given view files are present for a black notification" do
      setup do
        create_test_file(filename: "banner_green.erb", content: '')
        create_test_file(filename: "banner_red.erb", content: '')
        create_test_file(filename: "banner_black.erb", content: '<p>RIP John Doe</p>')

        Static.banner = NotificationFileLookup.new(location_of_test_files).banner
      end

      should "show a banner notification on the page" do
        visit "/templates/wrapper.html.erb"
        assert page.has_selector? "#banner-notification.black"
        assert_match '<p>RIP John Doe</p>', page.body
      end
    end
  end
end
