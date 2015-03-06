require 'rails_helper'

describe SiblingPresenter do

  Parent = Struct.new(:details)
  Details = Struct.new(:child_section_groups)
  ChildSectionGroup = Struct.new(:child_sections)
  ChildSection = Struct.new(:section_id)
  
  context "current section is at the top level of the manual" do
    let(:presenter) { SiblingPresenter.new(nil, nil) }

    it "should not have siblings" do
      expect(presenter.previous).to be_nil
      expect(presenter.next).to be_nil
    end
  end

  context "current section has a parent with multiple children" do

    let(:parent) {
      Parent.new(
        Details.new(
          [
            ChildSectionGroup.new(
              [
                ChildSection.new("EIM00510"),
                ChildSection.new("EIM00520"),
                ChildSection.new("EIM00530"),
              ]
            )
          ]
        )
      )
    }

    context "current section is the first child" do
      let(:presenter) { SiblingPresenter.new("EIM00510", parent) }

      it "should have next but not previous sibling" do
        expect(presenter.previous).to be_nil
        expect(presenter.next.section_id).to eq("EIM00520")
      end
    end

    context "current section is the mid child" do
      let(:presenter) { SiblingPresenter.new("EIM00520", parent) }

      it "should have previous and next siblings" do
        expect(presenter.previous.section_id).to eq("EIM00510")
        expect(presenter.next.section_id).to eq("EIM00530")
      end
    end

    context "current section is the last child" do
      let(:presenter) { SiblingPresenter.new("EIM00530", parent) }

      it "should have previous but not next sibling" do
        expect(presenter.previous.section_id).to eq("EIM00520")
        expect(presenter.next).to be_nil
      end
    end

    context "current section is not in the list" do
      let(:presenter) { SiblingPresenter.new("EIM00600", parent) }

      it "should have no siblings" do
        expect(presenter.previous).to be_nil
        expect(presenter.next).to be_nil
      end
    end

  end

  context "current section has a parent with a single child (self)" do

    let(:parent) {
      Parent.new(
        Details.new(
          [
            ChildSectionGroup.new(
              [
                ChildSection.new("EIM00600"),
              ]
            )
          ]
        )
      )
    }

    let(:presenter) { SiblingPresenter.new("EIM00600", parent) }

    it "should have no siblings" do
      expect(presenter.previous).to be_nil
      expect(presenter.next).to be_nil
    end
  end

  context "parent has multiple section groups" do

    let(:parent) {
      Parent.new(
        Details.new(
          [
            ChildSectionGroup.new(
              [
                ChildSection.new("EIM00600")
              ]
            ),
            ChildSectionGroup.new(
              [
                ChildSection.new("EIM00700"),
                ChildSection.new("EIM00800"),
                ChildSection.new("EIM00900"),
              ]
            )
          ]
        )
      )
    }

    let(:presenter) { SiblingPresenter.new("EIM00800", parent) }

    it "should have previous and next siblings" do
      expect(presenter.previous.section_id).to eq("EIM00700")
      expect(presenter.next.section_id).to eq("EIM00900")
    end
  end

end
