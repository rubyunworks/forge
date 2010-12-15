--- 
name: forge
repositories: 
  public: git://github.com/rubyworks/forge.git
title: Forge
contact: Trans <transfire@gmail.com>
requires: 
- group: []

  name: facets
  version: 0+
- group: 
  - build
  name: syckle
  version: 0+
- group: 
  - test
  name: rcov
  version: 0+
resources: 
  code: http://gitub.com/rubyworks/forge
  home: http://rubyworks.gitub.com/forge
pom_verison: 1.0.0
manifest: 
- .ruby
- bin/forge
- lib/forge/abstract.rb
- lib/forge/command.rb
- lib/forge/rubyforge/abstract.rb
- lib/forge/rubyforge/post.rb
- lib/forge/rubyforge/publish.rb
- lib/forge/rubyforge/release.rb
- lib/forge/rubyforge/touch.rb
- lib/forge/rubyforge.rb
- lib/forge/sourceforge/TODO
- lib/forge/sourceforge.rb
- lib/forge.rb
- lib/plugin/syckle/rubyforge.rb
- HISTORY.rdoc
- LICENSE
- README.rdoc
- ROADMAP
version: 0.8.0
copyright: (c) 2006 Thomas Sawyer
licenses: 
- Apache 2.0
summary: POM-aware Rubyforge Front-End
authors: 
- Thomas Sawyer
