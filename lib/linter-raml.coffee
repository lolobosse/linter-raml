linterPath = atom.packages.getLoadedPackage("linter").path
console.log linterPath
Linter = require "#{linterPath}/lib/linter"

class LinterRaml extends Linter
  # The syntax that the linter handles. May be a string or
  # list/tuple of strings. Names should be all lowercase.
  @syntax: 'source.raml'

  # A string, list, tuple or callable that returns a string, list or tuple,
  # containing the command line (with arguments) used to lint.
  cmd: 'echo [/Users/laurentmeyer/Documents/JobNinja_Doc/API_RAML/api.raml:6:6] ERROR property: is invalid in a security scheme'

  linterName: 'linter-raml'

  # A regex pattern used to extract information from the executable's output.
  #regex: 'java:(?<line>\\d+): ((?<error>error)|(?<warning>warning)): (?<message>.+)[\\n\\r]'
  regex: '(?<line>\d.):(\d.)] (?<error>[\s\S]*)'
  constructor: (editor) ->
    super(editor)

  destroy: ->
    super
    @configSubscription.dispose()

  errorStream: 'stderr'

module.exports = LinterRaml
