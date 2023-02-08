describe("when something is added", () => {
  let wrapper;
  beforeEach(() => {
    wrapper = new Symbol("foo");
  });
  it("does something", () => {
    expect(wrapper).toBe("foo");
  });
});
