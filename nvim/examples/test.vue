  <script>
  document.querySelector('selector')
  export default {
    name: 'NeovimTest',
    data() {
      return { greeting: 'Hello World!' }
    },
    methods: {
                                   foo(a, b)  {return a + b}
      }
  }
  </script>
  <template  >
    <p   class='greeting' :data-foo="foo(1,2)">{{
      this.greeting }}</p>
  </template>
 <style  >
  .greeting     {
    font-weight: bold;  color:    red;}</style>
