# frozen_string_literal: true

require './src/common/logger'
require './src/model/database/database'
require './src/view/view'

# Seed the database with seat numbers and show numbers
Log.instance.debug('Initialising the in-memory database with sample values')
Database.seed

# initiaise the views ie CLI script for interface
Log.instance.debug('Starting the CLI view scripts')
View.new.start
