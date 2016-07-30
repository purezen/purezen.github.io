---
layout:   post
title:    "Removing code smell in a Reactjs app — Part I : Identifying the smell"
comments: true
tags:     [reactjs, refactoring]
---

Removing code smell in a Reactjs app — Part I : Identifying the smell Lately I have been working on a project made using a React.js stack and came across a task which involved creating a Filter Form. Since the form was going to be used across a number of places it had to be generic.

Now making a generic form basically means to write an abstraction for the form functionality so that it could be ‘plugged-in’ easily and efficiently reused, which means that the least amount of code is repeated across its usage.

I pondered over it and the first form of abstraction that I could think of in ‘React-land’ was that of a Component.

So, I designed a way to create a form ‘utility’, that could be plugged-in by nesting inside a component. Essentially the form would be React component. The form would have the api, getList and setFilteredList.

The original implementation (as would any other real-world use-case) also involved a map of the various properties that would need to be filtered, but I am just showing the minimal api surface for brevity.

I then set over it. The final implementation looked something like ..

```es2015
getList() {
  ...
}

setFilteredList(filteredList) {
  ...
}

render() {
  ...
  <div>
    <FilterComponent
      getList={this.getList()}
      setFilteredList={this.setFilteredList.bind(this)}
    />
  </div>
  ...
}
```

This abstracted away the presentational (the filter input(s)) as well as the state (ie. the filtering query) aspects of the filter functionality.

This worked fine for us initially since we were in a time-crunch (call it real-world software development!) but whenever I looked back over it, it just didn’t feel right.

It was because, we were receiving the filteredList from a ‘child’ component.

Now React emphasises on uni-directional flow of state, which is from parent to child and thus such a scenario is an anti-pattern since the information is flowing in reverse!

Because of this I had to explicitly set the filtered list in the parent component by calling setFilteredList function whereas in a perfectly ‘React-y’ scenario the filtered list should be available automatically.

This breaks the React paradigm which emphasises on uni-directional reactive flow of data.

Later, I found a solution for the same. Can you guess it? You might-have come across it while using Redux-Form.. Woah, I might have spilled the beans already!

Anyways, I will be discussing it in my next post. Stay tuned!
