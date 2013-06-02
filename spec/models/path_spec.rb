require "spec_helper"

describe Path do
  let(:node1) { Node.new(1) }
  let(:node2) { Node.new(2) }
  let(:node3) { Node.new(3) }

  subject { Path.new([node1, node2]) }

  describe "#subpath_of?" do

    it "returns true if path is a subpath" do
      other_path = Path.new([node1, node2, node3])
      expect(subject).to be_subpath_of(other_path)
    end

    it "returns false if path is not a subpath" do
      other_path = Path.new([node2, node1])

      expect(subject).not_to be_subpath_of(other_path)
    end

    it "returns false if other path is shorter than subject" do
      other_path = Path.new([node1])

      expect(subject).not_to be_subpath_of(other_path)
    end
  end

  describe "#include_node?" do
    it "returns true if path include node" do
      expect(subject.include_node?(node1)).to be_true
    end

    it "uses proper comparison" do
      new_node1 = Node.new(1)
      expect(subject.include_node?(new_node1)).to be_true
    end

    it "returns false if path doesnt include node" do
      expect(subject.include_node?(node3)).to be_false
    end
  end

  describe "#include_edge?" do
    it "returns true if path include edge" do
      expect(subject.include_edge?(Edge.new(node1, node2))).to be_true
    end

    it "returns false if path doesnt include edge" do
      expect(subject.include_edge?(Edge.new(node2, node1))).to be_false
    end
  end
end
