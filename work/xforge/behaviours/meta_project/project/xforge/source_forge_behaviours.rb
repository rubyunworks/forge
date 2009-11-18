require File.dirname(__FILE__) + '/../../../behaviour_helper'

module MetaProject
  module Project
    module XForge
      class SourceForgeBehaviours < Spec::Context

        include ProjectAnalyzer

        def should_find_rubyforge_project_by_scm_web_url
          project = project_from_scm_web("http://cvs.sourceforge.net/viewcvs.py/icplus/javadocqa/")

          project.scm.root.should_equal ":pserver:anonymous@cvs.sourceforge.net:/cvsroot/icplus"
          project.scm.mod.should_equal "javadocqa"

          project.tracker.overview.should_equal "http://sourceforge.net/tracker/?group_id=24723"

          project.scm_web.dir("").should_equal "http://cvs.sourceforge.net/viewcvs.py/icplus/javadocqa/"

        end

        def should_create_view_cvs_url_for_path
          dir           = "http://cvs.sourceforge.net/viewcvs.py/icplus/javadocqa/"
          history       = "http://cvs.sourceforge.net/viewcvs.py/icplus/javadocqa/src/net/sourceforge/jbtools/javadocqa/JavaDocQAOpenTool.java"
          raw_revision  = "http://cvs.sourceforge.net/viewcvs.py/*checkout*/icplus/javadocqa/src/net/sourceforge/jbtools/javadocqa/JavaDocQAOpenTool.java?rev=1.1"
          html_revision = "http://cvs.sourceforge.net/viewcvs.py/icplus/javadocqa/src/net/sourceforge/jbtools/javadocqa/JavaDocQAOpenTool.java?rev=1.1&view=markup"
          diff          = "http://cvs.sourceforge.net/viewcvs.py/icplus/javadocqa/src/net/sourceforge/jbtools/javadocqa/JavaDocQAOpenTool.java?r1=1.1.1.1&r2=1.1"

          path = "src/net/sourceforge/jbtools/javadocqa/JavaDocQAOpenTool.java"

          project = project_from_scm_web("http://cvs.sourceforge.net/viewcvs.py/icplus/javadocqa/")
          scm_web = project.scm_web

          scm_web.dir("").should_equal(dir)
          scm_web.history(path).should_equal(history)
          scm_web.raw(path, "1.1").should_equal(raw_revision)
          scm_web.html(path, "1.1").should_equal(html_revision)
          scm_web.diff(path, "1.1", "1.1.1.1").should_equal(diff)
        end

        def should_find_home_page_uri
          bittorrent = SourceForge.new('bittorrent')
          bittorrent.home_page.should_equal "http://bitconjurer.org/BitTorrent/"
        end

        URI_417576 = "http://sourceforge.net/tracker/index.php/?group_id=24723&atid=382449&func=detail&aid=417576"
        SUMMARY_417576 = "JBuilder plugin"

        URI_414998 = "http://sourceforge.net/tracker/index.php/?group_id=24723&atid=382446&func=detail&aid=414998"
        SUMMARY_414998 = "control file not created"

        def should_find_issue
          # http://rubyforge.org/tracker/index.php?func=detail&aid=1462&group_id=85&atid=414
          # This issue has low pri, and is therefore unlikely to change and break this behaviour
          tracker = SourceForge.new("icplus").tracker
          issue = tracker.issue("417576")

          issue.summary.should_equal SUMMARY_417576
          issue.url.should_equal URI_417576
        end

        def should_markup_message_with_issue_summary
          # #9999 doesn't exist and should be left intact
          tracker = SourceForge.new("icplus").tracker
          markup = tracker.markup("Fixed #417576, #9999 and #414998 feature requests")
          markup.should_equal "Fixed <a href=\"#{URI_417576}\">\#417576: #{SUMMARY_417576}</a>, #9999 and <a href=\"#{URI_414998}\">\#414998: #{SUMMARY_414998}</a> feature requests"
        end

        def should_have_identifier_examples
          tracker = SourceForge.new("icplus").tracker
          tracker.identifier_examples.should_equal ["#1926", "#1446"]
        end      
      end
    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::Project::XForge::SourceForgeBehaviours)
end
