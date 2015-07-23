path = require 'path'
child_process = require 'child_process'

module.exports = class LinterProvider
  # regex = ///
  #   (\S+):  #The file with issue.
  #   (\d+):  #The line number with issue.
  #   (\d+):  #The column where the issue begins.
  #   \s+     #A space.
  #   (\w+):  #The type of issue being reported.
  #   \s+     #A space.
  #   (.*)    #A message explaining the issue at hand.
  # ///

  regex = ///
    (\d.)             # Line number
    (\d.)             # Character number
    ]                 # Closing bracket
    ([\s\S]*)         # Error message
  ///

  getCommand = -> "/usr/local/bin/raml-cop"

  getCommandWithFile = (file) -> "#{getCommand()} #{file}"

  # This is based on code taken right from the linter-plus rewrite
  #   of `linter-crystal`.
  lint: (TextEditor) ->
    new Promise (Resolve) ->
      file = path.basename TextEditor.getPath()
      cwd = path.dirname TextEditor.getPath()
      data = []
      command = getCommand()+ ' '+ file
      console.log "Raml Command: #{command}" if atom.inDevMode()
      console.log "Raml cwd: #{cwd}" if atom.inDevMode()

      #process = child_process.exec command, {cwd: cwd+"/"+file}
      # process = child_process.spawn(command + ' ' + file, { cwd: cwd }, (error, stdout, stderr) ->
      #   console.log 'stdout: ' + stdout
      #   console.log 'stderr: ' + stderr
      #   if error != null
      #     console.log 'exec error: ' + error
      #   return
      # )

      # ----
      spawn = require('child_process').spawn
      terminal = spawn(command, {cwd: cwd})
      terminal.stdout.on 'data', (data) ->
        console.log 'stdout: ' + data
        return
      terminal.stderr.on 'data', (data) ->
        console.log 'stderr: ' + data
        return
      terminal.on 'close', (code) ->
        console.log 'child process exited with code ' + code
        return


      # process.stderr.on 'data', (d) -> data.push d.toString()
      # process.on 'close', ->
      #   toReturn = []
      #   for line in data
      #     console.log "Raml Provider: #{line}" if atom.inDevMode()
      #     if line.match regex
      #       [line, column, message] = line.match(regex)[1..3]
      #       toReturn.push(
      #         text: message,
      #         range: [[line - 1, column - 1], [line - 1, column - 1]]
      #       )
      Resolve toReturn
