fs = require 'fs'
assert = require 'assert'

parseApk = require '..'

describe 'Ontdek', ->
    output = null

    before (done) ->
        fs.readFile __dirname + '/samples/ontdek.txt', 'utf8', (err, txt) ->
            return done(err) if err
            parseApk.parseOutput txt, (err, out) ->
                return done(err) if err
                output = out
                done()

    it 'Parses correctly', ->
        assert.notEqual(null, output)

    it 'Starts with a manifest tag', ->
        assert.equal(output.manifest.length, 1)

    it 'Contains a version name attribute', ->
        assert.equal(output.manifest[0]['@android:versionName'], '1.0.1')

    it 'Has a package name', ->
        assert.equal(output.manifest[0]['@package'], 'zeeland.ontdek.android')

    it 'Has an application tag', ->
        manifest = output.manifest[0]
        assert.equal(manifest.application.length, 1)

    it 'Has 6 meta-data tags', ->
        manifest = output.manifest[0]
        application = manifest.application[0]
        assert.equal(application['meta-data'].length, 6)
