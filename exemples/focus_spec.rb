describe "Something" do
  # can focus describe

  before do
    # cannot focus here
  end

  # can focus context

  it "can focus" do
    # can focus it

    expect do
      # cannot focus here
    end
  end

  specify "some specification" do
    # can focus specify
    #
    expect do
      # cannot focus here
    end
  end

  context "some context" do
    # can focus context

    before do
      # cannot focus here
    end

    # can focus context

    expect do
      # cannot focus here
    end
  end
end


feature "some feature" do
  # can focus feature

  before do
    # cannot focus here
  end

  # can focus feature

  scenario "some scenario" do
    # can focus some scenario

    expect do
      # cannot focus here
    end
  end
end

