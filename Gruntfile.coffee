module.exports = (grunt) ->
  grunt.initConfig

    coffee:
      app:
        options:
          join: true
          joinExt: '.coffee'
          sourceMap: true
        files:
          'build/app.js': [
            'src/*.coffee'
            'src/widget/*.coffee'
            'src/dev/*.coffee'
          ]

      test:
        expand: true
        cwd: "tests/nodeunit"
        src: ["**/*.coffee"]
        dest: "tests/nodeunit/build"
        ext: ".js"

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.registerTask "default", ["coffee"]