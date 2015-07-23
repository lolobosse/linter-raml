# module.exports =
#   config:
#     raml_cop_path:
#       type: 'string'
#       default: '/usr/local/bin/raml-cop'
#
# activate: ->
#    console.log 'activate linter-raml'

{BufferedProcess, CompositeDisposable} = require 'atom'

module.exports =
  config:
    executablePath:
      type: 'string'
      title: 'raml-cop Path'
      default: '/usr/local/bin/raml-cop'
  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-raml.raml_cop_path',
      (executablePath) =>
        @executablePath = executablePath

  deactivate: ->
    @subscriptions.dispose()


  provideLinter: ->
    LinterProvider = require ('./provider')
    provider = new LinterProvider()
    return {
      grammarScopes: ['source.raml']
      scope: 'file'
      lint: provider.lint
      lintOnFly: true
    }
