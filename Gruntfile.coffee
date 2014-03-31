module.exports = (grunt) ->
  grunt.initConfig
    concat:
      options:
        separator: "\n\n"
      dist:
        src: ["src/*.coffee", "src/widget/*.coffee"]
        dest: "build/app.coffee"
    coffee:
      app:
        expand: true
        cwd: "build"
        src: ["**/*.coffee"]
        dest: "build"
        ext: ".js"
      test:
        expand: true
        cwd: "tests/nodeunit"
        src: ["**/*.coffee"]
        dest: "tests/nodeunit/build"
        ext: ".js"

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.registerTask "default", ["concat", "coffee"]