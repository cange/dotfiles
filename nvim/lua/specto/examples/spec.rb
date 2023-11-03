# frozen_string_literal: true

# example of a jest test file
xdescribe('foo') do
  xit('bar') do
    expect(1).toBe(1)
  end
end

xcontext('foobar') do
  xscenario('barfoo') do
    expect(1).toBe(1)
  end
end
