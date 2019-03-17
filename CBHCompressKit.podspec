Pod::Spec.new do |spec|

  spec.name                   = "CBHCompressKit"
  spec.version                = "1.0.1"
  spec.module_name            = "CBHCompressKit"

  spec.summary                = "CBHCompressKit provides `CBHCompressor` and `CBHDecompressor` which provide an easy-to-use means of compressing `NSData`."
  spec.homepage               = "https://github.com/chris-huxtable/CBHCompressKit"

  spec.license                = { :type => "ISC", :file => "LICENSE" }

  spec.author                 = { "Chris Huxtable" => "chris@huxtable.ca" }
  spec.social_media_url       = "https://twitter.com/@Chris_Huxtable"

  spec.osx.deployment_target  = '10.11'

  spec.source                 = { :git => "https://github.com/chris-huxtable/CBHCompressKit.git", :tag => "v#{spec.version}" }

  spec.requires_arc           = false

  spec.public_header_files    = 'CBHCompressKit/*.h'
  spec.source_files           = "CBHCompressKit/*.{h,m}"

end
