require File.dirname(__FILE__) + '/../../../behaviour_helper'
require 'meta_project/project/xforge/ruby_forge'

module MetaProject
  module Tracker
    module XForge
      class RubyForgeTrackerBehaviours < Spec::Context
        URI_2585 = "http://rubyforge.org/tracker/index.php/?group_id=801&atid=3162&func=detail&aid=2585"
        SUMMARY_2585 = "DON'T CLOSE - This is just a test summary for MetaProject's tests"

        def should_find_issue
          tracker = ::MetaProject::Project::XForge::RubyForge.new("xforge").tracker
          issue = tracker.issue("2585")

          issue.summary.should_equal SUMMARY_2585
          issue.url.should_equal URI_2585
        end

        def should_markup_message_with_issue_summary
          # #9999 doesn't exist and should be left intact
          tracker = ::MetaProject::Project::XForge::RubyForge.new("xforge").tracker
          markup = tracker.markup("Fixed #9999 and #2585 feature requests")
          markup.should_equal "Fixed #9999 and <a href=\"#{URI_2585}\">\#2585: #{SUMMARY_2585}</a> feature requests"
        end

        def should_have_identifier_examples
          tracker = ::MetaProject::Project::XForge::RubyForge.new("xforge").tracker
          tracker.identifier_examples.should_equal ["#1926", "#1446"]
        end

        def should_close_issues
          tracker = ::MetaProject::Project::XForge::RubyForge.new("xforge", nil).tracker
          now = Time.now.utc.to_s
          summary = "Test Summary at #{now}"
          detail = "Test Detail at #{now}"
          
          issue = Issue.new(tracker, :summary => summary, :detail => detail)

          user_name = ENV['RUBYFORGE_USER']
          raise "ENV['RUBYFORGE_USER'] not set" unless user_name
          password = ENV['RUBYFORGE_PASSWORD']
          raise "ENV['RUBYFORGE_PASSWORD'] not set" unless password

          issue.create(user_name, password)
          issue.identifier.should_match /[\d]+/
          issue_again = tracker.issue(issue.identifier)
          issue_again.summary.should_equal summary
          issue_again.identifier.should_match /[\d]+/
          # TODO: close it and verify manually that it was closed.
          issue_again.attributes[:detail] = "Closing now"
          issue_again.close(user_name, password)
        end
        
      end
    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::Tracker::XForge::RubyForgeTrackerBehaviours)
end
