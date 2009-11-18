require File.dirname(__FILE__) + '/../../../behaviour_helper'

module MetaProject
  module Tracker
    module Jira
      class JiraTrackerBehaviours < Spec::Context
        SUMMARY_DC_420 = "make Bugzilla magic configurable"
        URI_DC_420 = "http://jira.codehaus.org/browse/DC-420"

        SUMMARY_DC_429 = "Trac plugin"
        URI_DC_429 = "http://jira.codehaus.org/browse/DC-429"

        def setup
          @dc = JiraTracker.new("http://jira.codehaus.org", "DC")
          @ashcroft = JiraTracker.new("http://jira.codehaus.org", "ASH")
        end

        def should_find_issue
          issue = @dc.issue("DC-420")
          issue.url.should_equal URI_DC_420
          issue.summary.should_equal SUMMARY_DC_420
        end

        def should_markup_message_with_issue_summary
          # #9999 doesn't exist and should be left intact
          markup = @dc.markup("Fixed DC-420, DXXC-420 and DC-429 feature requests")
          markup.should_equal "Fixed <a href=\"#{URI_DC_420}\">DC-420: #{SUMMARY_DC_420}</a>, DXXC-420 and <a href=\"#{URI_DC_429}\">DC-429: #{SUMMARY_DC_429}</a> feature requests"
        end

        def should_have_identifier_examples
          @dc.identifier_examples.should_equal ["DC-420", "pico-12"]
        end
        
        # CLOSE API NOT WORKING ON CODEHAUS
        def _should_close_issues
          now = Time.now.utc.to_s
          summary = "Test Summary from MetaProject at #{now}"
          detail = "Test Detail from MetaProject at #{now}"

          issue = Issue.new(@ashcroft, :summary => summary, :detail => detail)
          issue.create
          issue.identifier.should_match /ASH-[\d]+/
          issue_again = @ashcroft.issue(issue.identifier)
          issue_again.summary.should_equal summary
          issue_again.identifier.should_match /ASH-[\d]+/
          # TODO: close it and verify manually that it was closed.
          issue_again.attributes[:detail] = "Closing now"
          issue_again.close
        end
        
      end
    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::Tracker::Jira::JiraTrackerBehaviours)
end
