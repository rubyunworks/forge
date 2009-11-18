require File.dirname(__FILE__) + '/../../../behaviour_helper'

module MetaProject
  module Project
    module Trac
      class TracBehaviours < Spec::Context

        include ProjectAnalyzer

        def should_find_rubyforge_project_by_scm_web_url
          project = project_from_scm_web(
            "http://dev.rubyonrails.com/browser/trunk/activerecord/", 
            :trac_svn_root_url => "http://dev.rubyonrails.org/svn/rails/")

          project.scm.url.should_equal "http://dev.rubyonrails.org/svn/rails/trunk/activerecord"
          project.scm.path.should_equal "trunk/activerecord"

          project.tracker.overview.should_equal "http://dev.rubyonrails.com/report"

          project.scm_web.dir("").should_equal "http://dev.rubyonrails.com/browser/trunk/activerecord/"

        end

        def should_create_view_cvs_url_for_path
          dir           = "http://dev.rubyonrails.com/browser/trunk/activerecord/"
          history       = "http://dev.rubyonrails.com/log/trunk/activerecord/lib/active_record.rb"
          raw_revision  = "http://dev.rubyonrails.com/file/trunk/activerecord/lib/active_record.rb?rev=1470&format=txt"
          html_revision = "http://dev.rubyonrails.com/file/trunk/activerecord/lib/active_record.rb?rev=1470"
          diff          = "http://dev.rubyonrails.com/changeset/1470"

          path = "lib/active_record.rb"

          project = project_from_scm_web(
            "http://dev.rubyonrails.com/browser/trunk/activerecord/", 
            :trac_svn_root_url => "http://dev.rubyonrails.org/svn/rails/")
          scm_web = project.scm_web

          scm_web.dir("").should_equal(dir)
          scm_web.history(path).should_equal(history)
          scm_web.raw(path, "1470").should_equal(raw_revision)
          scm_web.html(path, "1470").should_equal(html_revision)
          scm_web.diff(path, "1470", nil).should_equal(diff)
        end

        def should_find_home_page_uri
          project = project_from_scm_web(
            "http://dev.rubyonrails.com/browser/trunk/activerecord/", 
            :trac_svn_root_url => "http://dev.rubyonrails.org/svn/rails/")

          project.home_page.should_equal "http://dev.rubyonrails.com/wiki"
        end

        SUMMARY_1926 = "An AJAX-enabled checkbox."
        URI_1926 = "http://dev.rubyonrails.com/ticket/1926"

        SUMMARY_1446 = "uncached helpers and partials"
        URI_1446 = "http://dev.rubyonrails.com/ticket/1446"

        def setup
          @ror = ::MetaProject::Tracker::Trac::TracTracker.new("http://dev.rubyonrails.com")
        end

        def should_find_issue
          issue = @ror.issue("1926")
          issue.url.should_equal URI_1926
          issue.summary.should_equal SUMMARY_1926
        end

        def should_markup_message_with_issue_summary
          # #99999 doesn't exist and should be left intact
          markup = @ror.markup("Fixed #1926, #99999 and #1446 feature requests")
          markup.should_equal "Fixed <a href=\"#{URI_1926}\">\#1926: #{SUMMARY_1926}</a>, #99999 and <a href=\"#{URI_1446}\">\#1446: #{SUMMARY_1446}</a> feature requests"
        end

        def should_have_identifier_examples
          @ror.identifier_examples.should_equal ["#1926", "#1446"]
        end
      end
    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::Project::Trac::TracBehaviours)
end
