require File.dirname(__FILE__) + '/../../../behaviour_helper'

module MetaProject
  module Project
    module XForge
      class RubyForgeBehaviours < Spec::Context

        include ProjectAnalyzer

        def should_find_rubyforge_project_by_scm_web_url
          project = project_from_scm_web("http://rubyforge.org/cgi-bin/viewcvs.cgi/win32-pathname/?cvsroot=win32utils")

          project.scm.root.should_equal ":pserver:anonymous@rubyforge.org:/var/cvs/win32utils"
          project.scm.mod.should_equal "win32-pathname"

          project.tracker.overview.should_equal "http://rubyforge.org/tracker/?group_id=85"

          project.scm_web.dir("").should_equal "http://rubyforge.org/cgi-bin/viewcvs.cgi/win32-pathname/?cvsroot=win32utils"

        end

        def should_create_view_cvs_url_for_path
          dir           = "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/?cvsroot=xforge"
          history       = "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/test/xforge/rubyforge_specification.rb?cvsroot=xforge"
          raw_revision  = "http://rubyforge.org/cgi-bin/viewcvs.cgi/*checkout*/xforge/test/xforge/rubyforge_specification.rb?cvsroot=xforge&rev=1.1"
          html_revision = "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/test/xforge/rubyforge_specification.rb?cvsroot=xforge&rev=1.1&content-type=text/vnd.viewcvs-markup"
          diff          = "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/test/xforge/rubyforge_specification.rb.diff?cvsroot=xforge&r1=1.2&r2=1.4"

          path = "test/xforge/rubyforge_specification.rb"

          project = project_from_scm_web("http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/?cvsroot=xforge")
          scm_web = project.scm_web

          scm_web.dir("").should_equal(dir)
          scm_web.history(path).should_equal(history)
          scm_web.raw(path, "1.1").should_equal(raw_revision)
          scm_web.html(path, "1.1").should_equal(html_revision)
          scm_web.diff(path, "1.4", "1.2").should_equal(diff)
        end
        
        def should_find_home_page_uri
          rubygems = RubyForge.new('rubygems')
          rubygems.home_page.should_equal "http://docs.rubygems.org"
        end

      end
    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::Project::XForge::RubyForgeBehaviours)
end
