require File.dirname(__FILE__) + '/../../behaviour_helper'

module MetaProject
  module ScmWeb
    class RubyForgeScmWebBehaviours < Spec::Context

      include ProjectAnalyzer

      def setup
        this_project = project_from_scm_web("http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/?cvsroot=xforge")
        scm_web = this_project.scm_web
        @root = scm_web.root
      end

      def should_list_contents_of_dir
      
        root_children = @root.children
        root_children.collect{|child| child.cleanpath}.should_equal [
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/Attic?cvsroot=xforge",
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/behaviours?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/doc?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/lib?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/test?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/.DS_Store?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/.cvsignore?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/CHANGES?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/MIT-LICENSE?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/README?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/Rakefile?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/xforge.tmproj?cvsroot=xforge" 
        ]
      
        root_children[4].directory?.should_equal true
        root_children[5].directory?.should_equal false

        # Drill down a little
      
        behaviours_children = root_children[1].children
        behaviours_children.collect{|child| child.cleanpath}.should_equal [
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/behaviours/meta_project?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/behaviours/behaviour_helper.rb?cvsroot=xforge", 
          "http://rubyforge.org/cgi-bin/viewcvs.cgi/xforge/behaviours/suite.rb?cvsroot=xforge"
        ]

      end
    
      def should_open_remote_contents
        local = File.open(File.dirname(__FILE__) + "/meta_project.rb.txt").read

        mp_web = @root.child("lib").child("meta_project.rb", "1.3", false)
        mp_web.path_from_root.should_equal("lib/meta_project.rb")      
        remote = mp_web.open.read
        local.should_equal remote
      end

    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::ScmWeb::RubyForgeScmWebBehaviours)
end
