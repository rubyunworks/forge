require File.dirname(__FILE__) + '/../../behaviour_helper'

module MetaProject
  module ScmWeb
    class CodehausSvnWebBehaviours < Spec::Context

      include ProjectAnalyzer

      def setup
        ashcroft = project_from_scm_web("http://svn.ashcroft.codehaus.org/ashcroft/", :jira_project_id => "ASH")
        scm_web = ashcroft.scm_web
        @root = scm_web.root
      end

      def should_list_contents_of_dir
        root_children = @root.children
        root_children.collect{|child| child.cleanpath}.should_equal [
          "http://svn.ashcroft.codehaus.org/ashcroft/lib", 
          "http://svn.ashcroft.codehaus.org/ashcroft/src", 
          "http://svn.ashcroft.codehaus.org/ashcroft/README.txt", 
          "http://svn.ashcroft.codehaus.org/ashcroft/ashcroft.iml", 
          "http://svn.ashcroft.codehaus.org/ashcroft/ashcroft.ipr", 
          "http://svn.ashcroft.codehaus.org/ashcroft/build.xml", 
          "http://svn.ashcroft.codehaus.org/ashcroft/commandments.txt" 
        ]

        root_children[1].directory?.should_equal true
        root_children[2].directory?.should_equal false
      end

      def should_open_remote_contents
        local = File.open(File.dirname(__FILE__) + "/codehaus_commandments.txt").read
        remote = @root.child("commandments.txt", "21", false).open.read.gsub(/\r\n/, "\n")
        local.should_equal remote
      end

    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::ScmWeb::CodehausSvnWebBehaviours)
end
