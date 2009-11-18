require File.dirname(__FILE__) + '/../behaviour_helper'

module MetaProject
  class VersionParserBehaviours < Spec::Context

    def should_parse_release_notes_for_specified_version
      vp = VersionParser.new
      version = vp.parse(File.dirname(__FILE__) + '/../../CHANGES', '0.1.2')
      version.release_notes.should_equal <<-EOF

This release is a minor release with fixes in the Rake script.

EOF
      version.release_changes.should_equal ["Fixed RDoc for gem", "Cleaned up documentation"]
    end

    def should_parse_release_notes_for_more_difficult_version
      vp = VersionParser.new
      version = vp.parse(File.dirname(__FILE__) + '/../../CHANGES', '0.4.0')
      version.release_notes.should_match /MetaProject/n
      version.release_notes.should_not_match /ViewCvs/n
      version.release_changes.length.should_equal 1 # not quite right. hrmpf!
    end

  end
end

if __FILE__ == $0
  runner = Spec::TextRunner.new($stdout)
  runner.run(MetaProject::VersionParserBehaviours)
end
