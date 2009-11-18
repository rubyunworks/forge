require File.dirname(__FILE__) + '/../../behaviour_helper'

module MetaProject
  module ScmWeb
    class SourceForgeScmWebBehaviours < Spec::Context

      include ProjectAnalyzer

      def setup
        middlegen = project_from_scm_web("http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/")
        scm_web = middlegen.scm_web
        @root = scm_web.root
      end

      def should_list_contents_of_dir

        root_children = @root.children
        root_children.collect{|child| child.cleanpath}.should_equal [
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/java", 
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/middlegen", 
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/sql", 
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/templates", 
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/web", 
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/webwork", 
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/xdoclet", 
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/.cvsignore", 
          "http://cvs.sourceforge.net/viewcvs.py/middlegen/middlegen/samples/src/application.xml"
        ]

        root_children[6].directory?.should_equal true
        root_children[7].directory?.should_equal false
      end

      def should_open_remote_contents
        local = File.open(File.dirname(__FILE__) + "/source_forge_application.xml").read
        remote = @root.child("application.xml", "1.4", false).open.read
        local.should_equal remote
      end

    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::ScmWeb::SourceForgeScmWebBehaviours)
end
