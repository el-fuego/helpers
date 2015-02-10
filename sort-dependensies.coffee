# Sorting list of modules with dependencies
### 
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
###

sortDependencies = null
do ->
  ###
  Remove element of array at specified position
  @param list {Array}
  @param position {Int}
  @return list {Array}
  ###
  removeAt = (list, position) ->
    before = list.slice 0, position
    after = list.slice position + 1
    list = before.concat after

  ###
  Insert value to array at specified position
  @param list {Array}
  @param value {*}
  @param position {Int}
  @return list {Array}
  ###
  pushAt = (list, value, position) ->
    before = list.slice 0, position
    after = list.slice position
    list = before.concat [value], after

  ###
  Insert value to array at specified position or leave before it
  @param list {Array}
  @param value {*}
  @param position {Int}
  @return list {Array}
  ###
  insertBeforeOrAt = (list, value, position) ->
    currentPosition = list.indexOf value

    # already at list at needed position
    return if currentPosition <= position && currentPosition != -1

    # remove if found
    if currentPosition != -1
      list = removeAt list, currentPosition
      position-- if currentPosition <= position

    # add to needed position
    list = pushAt list, value, position


  ###
  Sort modules names and their dependencies
  @param modules [{Object}] [{name: 'b', dependencies: ['a']}]
  @return list [{String}]
  ###
  sortNamesByDependencies = (modules) ->
    list = []

    # Insert modules
    _.forEach modules, (module) ->
      list = insertBeforeOrAt wrapper.name, list.length
      wrapperPosition = list.indexOf(wrapper.name)

      # Insert dependencies
      _.forEach module.dependencies, (dependencyName) ->
        dependencyPosition = list.indexOf(dependencyName) || list.length
        dependencyPosition = wrapperPosition if dependencyPosition > wrapperPosition || dependencyPosition == -1
        list = insertBeforeOrAt list, dependencyName, dependencyPosition

    list

  ###
  Sort modules
  @param modules [{Object}] [{name: 'b', dependencies: ['a']}]
  ###
  sortDependencies = (modules) ->
    sortedModules = []
    names = sortNamesByDependencies modules
    _.foEach names, (name) ->
      module = _.find modules, (m) ->
        m.name == name

      if module?
        sortedModules.push module
      else
        throw new Error "sortDependencies: can`t find module '#{name}' "
