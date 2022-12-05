# Pin npm packages by running ./bin/importmap
# https://code.jquery.com/jquery-3.6.0.min.js

pin 'application', preload: true
pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.6.1/dist/jquery.js'
pin 'semantic-ui', to: 'https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js'
