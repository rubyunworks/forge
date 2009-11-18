require File.dirname(__FILE__) + '/../../behaviour_helper'

module MetaProject
  module ScmWeb
    class PathnameBehaviours < Spec::Context
      def should_not_have_leading_or_trailing_slash_for_path_from_root
        root = Pathname.new(nil, nil, "", nil, true)
        root.path_from_root.should_equal ""
        root.basename.should_equal ""
        
        var = root.child("var")
        var.path_from_root.should_equal "var"
        var.basename.should_equal "var"
        var.parent.should_be_same_as root

        spool = var.child("spool")
        spool.path_from_root.should_equal "var/spool"
        spool.basename.should_equal "spool"
        spool.parent.should_be_same_as var
      end
    end
  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::ScmWeb::PathnameBehaviours)
end
