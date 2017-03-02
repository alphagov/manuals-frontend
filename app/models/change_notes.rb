class ChangeNotes
  def initialize(change_notes)
    @change_notes = change_notes
  end

  def updates
    change_notes.map { |u|
      Update.new(u)
    }
  end

  def by_year
    group_updates_by_year(updates)
  end

private

  attr_reader :change_notes

  def group_updates_by_year(updates)
    updates.group_by { |update| update.updated_at.year }.map { |year, grouped_updates|
      [year, group_updates_by_day(grouped_updates)]
    }.reverse
  end

  def group_updates_by_day(updates)
    updates.group_by(&:updated_at).map { |day, grouped_updates|
      [day, group_updates_by_document(grouped_updates)]
    }.reverse
  end

  def group_updates_by_document(updates)
    updates.group_by(&:base_path).map { |_, grouped_updates|
      DocumentUpdates.new(grouped_updates)
    }
  end

  class Update
    def initialize(update)
      @update = update
      @title = update['title']
      @base_path = update['base_path']
      @change_note = update['change_note']
    end

    def updated_at
      @updated_at ||= Time.parse(update['published_at']).to_date
    end

    attr_reader :update, :title, :base_path, :change_note
  end

  class DocumentUpdates
    delegate :base_path, :title, to: :'updates.first'

    def initialize(updates)
      @updates = updates
    end

    def change_notes
      updates.map(&:change_note)
    end

  private

    attr_reader :updates
  end
end
