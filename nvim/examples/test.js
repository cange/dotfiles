window.addEventListener('eventName', event => {
  let magic = {
    foo: { bar: {} },
  }

  var foo = () => {
    event.preventDefault()

    return magic.foo
  }

  foo()
})
