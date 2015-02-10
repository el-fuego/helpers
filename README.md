# helpers

### sortDependencies()
Sorting list of modules or functions with depencencies
[sort-dependensies.coffee](https://github.com/el-fuego/helpers/blob/master/sort-dependensies.coffee)

```coffee
# @return sortedList [{Object}]
sortDependencies [
    name: 'c',
    dependencies: ['b']
  ,
    name: 'd',
    dependencies: ['b']
  ,
    name: 'b',
    dependencies: ['a']
]
```
