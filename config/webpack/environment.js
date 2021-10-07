const { environment } = require('@rails/webpacker')
const sharedConfig = require('./shared');

environment.config.merge(sharedConfig);
environment.config.resolve.extensions = ['.js', '.jsx', '.json'];

module.exports = environment;