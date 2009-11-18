require File.dirname(__FILE__) + '/meta_project/version_parser_behaviours'
require File.dirname(__FILE__) + '/meta_project/scm_web/pathname_behaviours'
require File.dirname(__FILE__) + '/meta_project/scm_web/ruby_forge_scm_web_behaviours'
require File.dirname(__FILE__) + '/meta_project/scm_web/source_forge_scm_web_behaviours'
require File.dirname(__FILE__) + '/meta_project/scm_web/codehaus_svn_web_behaviours'
require File.dirname(__FILE__) + '/meta_project/scm_web/trac_svn_web_behaviours'
require File.dirname(__FILE__) + '/meta_project/patois/parser_behaviours'
require File.dirname(__FILE__) + '/meta_project/project/codehaus/codehaus_svn_behaviours'
#require File.dirname(__FILE__) + '/meta_project/project/codehaus/codehaus_svn_behaviours'
require File.dirname(__FILE__) + '/meta_project/project/trac/trac_behaviours'
require File.dirname(__FILE__) + '/meta_project/project/xforge/ruby_forge_behaviours'
require File.dirname(__FILE__) + '/meta_project/project/xforge/source_forge_behaviours'
require File.dirname(__FILE__) + '/meta_project/tracker/jira/jira_tracker_behaviours'
require File.dirname(__FILE__) + '/meta_project/tracker/xforge/ruby_forge_tracker_behaviours'

runner = Spec::TextRunner.new($stdout)

runner.run(MetaProject::VersionParserBehaviours)
runner.run(MetaProject::ScmWeb::PathnameBehaviours)
runner.run(MetaProject::ScmWeb::RubyForgeScmWebBehaviours)
runner.run(MetaProject::ScmWeb::SourceForgeScmWebBehaviours)
runner.run(MetaProject::ScmWeb::CodehausSvnWebBehaviours)
runner.run(MetaProject::ScmWeb::TracSvnWebBehaviours)
runner.run(MetaProject::Patois::ParserBehaviours)
runner.run(MetaProject::Project::Codehaus::CodehausSvnBehaviours)
runner.run(MetaProject::Project::Trac::TracBehaviours)
runner.run(MetaProject::Project::XForge::RubyForgeBehaviours)
runner.run(MetaProject::Project::XForge::SourceForgeBehaviours)
runner.run(MetaProject::Tracker::Jira::JiraTrackerBehaviours)
runner.run(MetaProject::Tracker::XForge::RubyForgeTrackerBehaviours)
