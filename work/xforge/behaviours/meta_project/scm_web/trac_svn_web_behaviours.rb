require File.dirname(__FILE__) + '/../../behaviour_helper'

module MetaProject
  module ScmWeb
    class TracSvnWebBehaviours < Spec::Context

      include ProjectAnalyzer

      def setup
        trac = project_from_scm_web(
          "http://projects.edgewall.com/trac/browser/trunk/trac/ticket",
          :trac_svn_root_url => "http://svn.edgewall.com/repos/trac/"
        )
        scm_web = trac.scm_web
        @root = scm_web.root
      end

      def should_list_contents_of_dir

        root_children = @root.children
        root_children.collect{|child| child.cleanpath}.should_equal [
          "http://projects.edgewall.com/trac/browser/trunk/trac/ticket/tests", 
          "http://projects.edgewall.com/trac/log/trunk/trac/ticket/__init__.py", 
          "http://projects.edgewall.com/trac/log/trunk/trac/ticket/api.py", 
          "http://projects.edgewall.com/trac/log/trunk/trac/ticket/model.py", 
          "http://projects.edgewall.com/trac/log/trunk/trac/ticket/query.py", 
          "http://projects.edgewall.com/trac/log/trunk/trac/ticket/report.py", 
          "http://projects.edgewall.com/trac/log/trunk/trac/ticket/web_ui.py" 
        ]

        root_children[0].directory?.should_equal true
        root_children[1].directory?.should_equal false
      end

      def should_open_remote_contents
        local = File.open(File.dirname(__FILE__) + "/trac__init__.py").read
        remote = @root.child("tests").child("/__init__.py", "1739", false).open.read
        local.should_equal remote
      end

    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::ScmWeb::TracSvnWebBehaviours)
end
