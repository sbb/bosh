require 'bosh/director'

module Bosh::Director
  class CompiledPackageYamlWriter
    def initialize(group, dir)
      @compiled_package_group = group
      @dir = dir
    end

    def write
      hashes = @compiled_package_group.compiled_packages.map do |compiled_package|
        {
          'package_name' => compiled_package.package.name,
          'package_fingerprint' => compiled_package.package.fingerprint,
          'stemcell_sha1' => @compiled_package_group.stemcell_sha1,
          'blobstore_id' => compiled_package.blobstore_id,
        }
      end
      File.open(File.join(@dir, 'compiled_packages.yml'), 'w') do |f|
        f.write(YAML.dump('compiled_packages' => hashes))
      end
    end
  end
end
