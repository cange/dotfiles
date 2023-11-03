// example of a jest test file
xdescribe('foo', () => {
  it('bar', () => {
    expect(1).toBe(1)
  })
})

describe.only('foobar', () => {
  it.only('barfoo', () => {
    expect(1).toBe(1)
  })
})
