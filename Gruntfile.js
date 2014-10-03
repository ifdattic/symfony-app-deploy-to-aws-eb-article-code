module.exports = function (grunt) {
    var jsFilePaths = [
        'js/*.js',
        'js/app/*.js',
        'js/app/modules/*.js'
    ];

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        appDir: 'web/assets',

        jshint: {
            options: {
                reporter: require('jshint-stylish')
            },
            all: [
                'Gruntfile.js',
                '<%= appDir %>/js/{,*/}*.js'
            ]
        }
    });

    grunt.loadNpmTasks('grunt-contrib-jshint');

    grunt.registerTask('default', ['jshint']);

    grunt.registerTask('production', ['jshint']);
};
