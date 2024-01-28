# Pin npm packages by running ./bin/importmap

pin "application"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin "bootstrap"
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "@rails/actioncable", to: "@rails--actioncable.js" # @7.1.3
pin "mapbox-gl" # @3.1.2
pin "process" # @2.0.1
pin "chartjs" # @0.3.24
pin "chartkick" # @5.0.1
