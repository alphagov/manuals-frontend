class SiblingPresenter

  def initialize(current_section_id, parent)
    @current_section_id = current_section_id
    @parent = parent
  end

  def previous_sibling
    section_groups.each do |section_group|
      section_group.child_sections.each_with_index do |section, index|
        if section.section_id == @current_section_id
          if index != 0
            return section_group.child_sections[index - 1]
          end
        end
      end
    end
    return nil
  end

  def next_sibling
    section_groups.each do |section_group|
      section_group.child_sections.each_with_index do |section, index|
        if section.section_id == @current_section_id
          if index != section_group.child_sections.length - 1 
            return section_group.child_sections[index + 1]
          end
        end
      end
    end
    return nil
  end

  def prepare_for_navigation_component
    if previous_sibling and next_sibling
      { 
        previous_page: {
          "title" => "Previous page",
          "url" =>  previous_sibling.base_path
        },
        next_page: {
          "title" => "Next page",
          "url" => next_sibling.base_path
        }
      } 
    elsif previous_sibling
      { 
        previous_page: {
          "title" => "Previous page",
          "url" =>  previous_sibling.base_path
        }
      } 
    elsif next_sibling
      { 
        next_page: {
          "title" => "Next page",
          "url" => next_sibling.base_path
        }
      } 
    else 
      {}
    end
  end

private

  def section_groups
    if @parent
      @parent.details.child_section_groups
    else
      []
    end
  end

end
