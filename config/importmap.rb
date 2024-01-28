# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "bootstrap", to: "https://unpkg.com/bootstrap@5.3.2/dist/js/bootstrap.js", preload: true
pin "@popperjs/core", to: "@popperjs--core.js", preload: true # @2.11.8
pin "@rails/actioncable", to: "@rails--actioncable.js" # @7.1.3
# pin "mapbox-gl", to: "https://unpkg.com/mapbox-gl@3.1.2/dist/mapbox-gl.js", preload: true # @3.1.2
# pin "mapbox/mapbox-gl-geocoder", to: "https://unpkg.com/mapbox-gl-geocoder@2.0.1/lib/index.js", preload: true
pin "process" # @2.0.1
pin "chartkick", to: "https://unpkg.com/chartkick@5.0.1/dist/chartkick.js" # @5.0.1
pin_all_from "app/javascript/controllers", under: "controllers"
