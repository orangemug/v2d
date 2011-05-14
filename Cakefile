fs     = require 'fs'
{exec} = require 'child_process'
util   = require 'util'

# Required for jasmine testing
express = require 'express'

srcCoffeeDir     = '.'
targetJsDir      = 'build'
targetCoffeeDir  = 'build'
targetFileName   = 'v2d'
targetCoffeeFile = "#{targetCoffeeDir}/#{targetFileName}.coffee"
targetJsFile     = "#{targetJsDir}/#{targetFileName}.js"
coffeeOpts       = " --output #{targetJsDir} --compile #{targetCoffeeFile}"

specFolder       = "spec"
specExtensions   = "coffee"

isVerbose = true
showColors = true

# Files to build 
coffeeFiles = [
    'v2d'
]


# Actions
runSpecs = ->
  app = express.createServer()

  app.configure 'development', () ->
    app.use(express.static(__dirname))
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

  util.log "Run tests at http://localhost:2555"
  app.listen(2555)


build = (callback) ->
  # Run the specs before we build
  util.log "Building #{targetJsFile}"
  appContents = new Array remaining = coffeeFiles.length
  util.log "Appending #{coffeeFiles.length} files to #{targetCoffeeFile}"

  for file, index in coffeeFiles then do (file, index) ->
      fs.readFile "#{srcCoffeeDir}/#{file}.coffee"
                , 'utf8'
                , (err, fileContents) ->
          util.log err if err

          appContents[index] = fileContents
          util.log "[#{index + 1}] #{file}.coffee"
          process() if --remaining is 0

  process = ->
      fs.writeFile targetCoffeeFile
                 , appContents.join('\n\n')
                 , 'utf8'
                 , (err) ->
          util.log err if err

          exec "coffee #{coffeeOpts}", (err, stdout, stderr) ->
              util.log err if err
              message = "Compiled #{targetJsFile}"
              util.log message
              fs.unlink targetCoffeeFile, (err) -> util.log err if err
              minify()


minify = (callback) ->
  command = "java -jar 'build/tools/google-compiler/compiler.jar'  --compilation_level ADVANCED_OPTIMIZATIONS --js_output_file #{targetJsDir}/#{targetFileName}.min.js --js #{targetJsDir}/#{targetFileName}.js"
  util.log "Running command: #{command}"
  exec command, (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
    callback?()


#
# TASKS
task 'build', 'Build a single javascript file', ->
  build()

task 'minify', 'Minify the javascript', ->
  minify()

task 'test', 'Run the specs', ->
  runSpecs()

