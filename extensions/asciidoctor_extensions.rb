require File.dirname(__FILE__) + '/asciidoctor_patch'
require File.dirname(__FILE__) + '/requirement_block'

Extensions.register do
  block RequirementBlock, :requirement
end
