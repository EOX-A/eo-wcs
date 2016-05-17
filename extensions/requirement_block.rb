require 'asciidoctor/extensions'

include ::Asciidoctor

class RequirementBlock < Extensions::BlockProcessor
  option :contexts, [:paragraph]
  option :content_model, :simple

  def process parent, reader, attributes
    doc = parent.document
    requirement_id = doc.counter('requirement')
    attributes['id'] = "_requirement-#{requirement_id}" unless attributes['id']
    attributes['title'] = "#{doc.attributes['requirement-caption'] || 'Requirement'} #{requirement_id}" unless attributes['title']
    if attributes['uri']
      attributes['id'] = attributes['uri']
      attributes['title'] = attributes['title'] + " " + attributes['uri']
    end

    block = Asciidoctor::Block.new parent, :quote, :source => reader.lines, :attributes => attributes
  end
end
