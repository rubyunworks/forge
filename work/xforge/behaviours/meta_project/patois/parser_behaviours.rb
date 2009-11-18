require File.dirname(__FILE__) + '/../../behaviour_helper'

module MetaProject
  module Patois
    class ParserBehaviours < Spec::Context
      
      def should_recognise_multiple_commands_with_hash_style_issues
        @p = Parser.new(Tracker::DigitIssues.command_pattern, Tracker::DigitIssues.issue_pattern)
        commands = []
        @p.parse("Fixes #1 and #23. Refs #456 & #7890") do |command|
          commands << command
        end

        commands.size.should_equal 4
        commands[0].issue_id.should_equal "1"
        commands[1].issue_id.should_equal "23"
        commands[2].issue_id.should_equal "456"
        commands[3].issue_id.should_equal "7890"
      end

      def should_recognise_multiple_commands_with_jira_style_issues
        @p = Parser.new(Tracker::Jira::JiraIssues.command_pattern, Tracker::Jira::JiraIssues.issue_pattern)
        commands = []
        @p.parse("Fixes DC-1 and dc-23. Refs DC-456 & DC-7890") do |command|
          commands << command
        end

        commands.size.should_equal 4
        commands[0].issue_id.should_equal "DC-1"
        commands[1].issue_id.should_equal "DC-23"
        commands[2].issue_id.should_equal "DC-456"
        commands[3].issue_id.should_equal "DC-7890"
      end
      
      # TODO: spec for command execution on an issue
    end
  end
end

