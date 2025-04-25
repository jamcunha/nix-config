-- TODO: config manually using nvim-jdtls instead of relying on third-party config

local M = {}

M.extra_setup = function()
  require('java').setup {
    jdk = {
      auto_install = false,
    },
    root_markers = {
      'settings.gradle',
      'settings.gradle.kts',
      'pom.xml',
      'build.gradle',
      'mvnw',
      'gradlew',
      'build.gradle',
      'build.gradle.kts',
    },
    java_debug_adapter = {
      enable = false,
    },
  }
end

M.extra_opts = {}

return M
