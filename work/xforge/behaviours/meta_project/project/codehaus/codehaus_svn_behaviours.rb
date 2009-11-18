require File.dirname(__FILE__) + '/../../../behaviour_helper'

module MetaProject
  module Project
    module Codehaus
      class CodehausSvnBehaviours < Spec::Context

        include ProjectAnalyzer

        def should_find_codehaus_project_by_scm_web_url
          project = project_from_scm_web("http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/", :jira_project_id => "PICO")

          project.scm.url.should_equal "svn://svn.picocontainer.codehaus.org/picocontainer/scm/java/picocontainer/trunk"
          project.scm.path.should_equal "java/picocontainer/trunk"

          project.tracker.overview.should_equal "http://jira.codehaus.org/browse/PICO"

          project.scm_web.dir("").should_equal "http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/"

        end

        def should_create_view_cvs_url_for_path
          dir           = "http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/"
          history       = "http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/container/project.xml"
          raw_revision  = "http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/container/project.xml?rev=2234"
          html_revision = "http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/container/project.xml?rev=2234&view=markup"
          diff          = "http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/container/project.xml?r1=2220&r2=2234&p1=java/picocontainer/trunk/container/project.xml&p2=java/picocontainer/trunk/container/project.xml"

          path = "container/project.xml"

          project = project_from_scm_web("http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/", :jira_project_id => "PICO")
          scm_web = project.scm_web

          scm_web.dir("").should_equal(dir)
          scm_web.history(path).should_equal(history)
          scm_web.raw(path, "2234").should_equal(raw_revision)
          scm_web.html(path, "2234").should_equal(html_revision)
          scm_web.diff(path, "2234", "2220").should_equal(diff)
        end

        def should_find_home_page_uri
          project = project_from_scm_web("http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/", :jira_project_id => "PICO")
          project.home_page.should_equal "http://picocontainer.codehaus.org/"
        end

        URI_PICO_244 = "http://jira.codehaus.org/browse/PICO-244"
        SUMMARY_PICO_244 = "Update docs"

        URI_PICO_242 = "http://jira.codehaus.org/browse/PICO-242"
        SUMMARY_PICO_242 = "Add component monitoring functionality"

        def should_find_issue
          project = project_from_scm_web("http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/", :jira_project_id => "PICO")
          issue = project.tracker.issue("PICO-242")

          issue.summary.should_equal SUMMARY_PICO_242
          issue.url.should_equal URI_PICO_242
        end

        def should_markup_message_with_issue_summary
          # PICO-9999 doesn't exist and should be left intact
          project = project_from_scm_web("http://svn.picocontainer.codehaus.org/java/picocontainer/trunk/", :jira_project_id => "PICO")
          markup = project.tracker.markup("Fixed PICO-244, PICO-9999 and pico-242 feature requests")
          markup.should_equal "Fixed <a href=\"#{URI_PICO_244}\">PICO-244: #{SUMMARY_PICO_244}</a>, PICO-9999 and <a href=\"#{URI_PICO_242}\">PICO-242: #{SUMMARY_PICO_242}</a> feature requests"
        end

        def _should_have_identifier_examples
          tracker = RubyForge.new("win32utils").tracker
          tracker.identifier_examples.should_equal ["#1926", "#1446"]
        end      
      end
    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::Project::Codehaus::CodehausSvnBehaviours)
end
