module.exports =
  config:
    raml_cop_path:
      type: 'string'
      default: '/usr/local/bin/raml-cop'

activate: ->
   console.log 'activate linter-raml'
