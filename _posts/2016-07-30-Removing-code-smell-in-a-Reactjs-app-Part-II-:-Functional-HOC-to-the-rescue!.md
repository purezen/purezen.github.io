---
layout:   post
title:    "Removing code smell in a Reactjs app — Part II : Functional HOC to the rescue!"
comments: true
tags:     [reactjs, refactoring]
---

Great to have you back! (Click [here](https://medium.com/@purezen_/removing-code-smell-in-a-reactjs-app-6e45c1a76033#.22cbsqvxo) if you want to check the first part)

While surfing the inter-webs I came across functional Higher-Order Components as a React way of “enriching” components eg. [here](https://medium.com/r/?url=http%3A%2F%2Fengineering.blogfoster.com%2Fhigher-order-components-theory-and-practice%2F).

[Redux-form](http://redux-form.com) might be one of its most popular form.

The idea is to wrap a Component in a Higher Order function to produce an *enriched* component. Additional arguments can also be passed in just like regular functions to give more context.

> Shameless plug: I am using  [react-koa-minimal-starter](https://github.com/purezen/react-koa-minimal-starter) as the base for the project since it comes with react-hot-loader v3 which has improved support for Higher-Order components ([ref](https://github.com/gaearon/react-hot-boilerplate/pull/61#issue-148980319)).

To use it, it will be called in the container component with the list passed as a reference using the property name of the state. This is how it looks like,

```javscript
import {connect} from 'react-redux'
import Filter from ‘../enhancers/filter’

const ListContainer = connect(
 (state) => state
)(Filter(List, {list: ‘listName’}))

And this is how the function looks like,

export default function Filter(EnhancedComponent, sourceRef) {
 return class extends Component {
   constructor(props) {
   super(props)
   this.state = {
   searchTerm: ‘’,
   filteredList: []
  }
 }

componentDidMount() {
 this.setState({ filteredList: this.props[sourceRef.list] })
}

getFilteredList(searchTerm, sourceList) {
 let re = new RegExp(searchTerm,’gi’)
 return sourceList.filter((item) => item.match(re))
}

handleSearchTerm(e) {
 let filteredList =  this.getFilteredList(e.target.value,this.props[sourceRef.list])

 this.setState({
  searchTerm: e.target.value,
  filteredList: filteredList
 })
}

render() {
 return (
  <div>
   <input
    value={this.state.searchTerm}
    onChange={this.handleSearchTerm.bind(this)}
   />
   <EnhancedComponent
    {…this.props}
    filteredList={this.state.filteredList}
   />
  </div>
 )
}}}
```

Finally, as can be seen the filtered list is available as `filteredList` property in the Presentational (wrapped) component.

You can check out the implementation in the `abstraction-via-hoc` branch of the repo. https://github.com/purezen/react-hoc-example.
