# Warning: this needs to be loaded before any dependent initializers
config_file_path = File.read(RAILS_ROOT + "/config/application.yml")
config = YAML.load(config_file_path)

APP_CONFIG = config.has_key?('global') ? config['global'].symbolize_keys : {}
APP_CONFIG.merge!(config[RAILS_ENV].symbolize_keys)
