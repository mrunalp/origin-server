module OpenShift
  module Utils
    class Sdk
      MARKER = 'CARTRIDGE_VERSION_2'

      def self.new_sdk_app?(gear_home)
        File.exists?(File.join(gear_home, '.env', MARKER))
      end

      def self.mark_new_sdk_app(gear_home)
        IO.write(File.join(gear_home, '.env', MARKER), "export #{MARKER}=2", 0)
      end
    end
  end
end
